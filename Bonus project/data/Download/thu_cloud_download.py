# coding=utf-8

import os
import json
import requests
import sys

from urllib.parse import (
    urlparse,
    parse_qs,
    unquote,
    quote
)


class THUCloud:

    def __init__(self, shared_link, outdir="download"):

        self.headers = {
            "User-Agent":
            "Mozilla/5.0"
        }

        if "/d/" not in shared_link:
            raise ValueError("Only directory share links are supported.")

        archive = shared_link.split("/d/")[1].split("/")[0]

        self.api_link = (
            f"https://cloud.tsinghua.edu.cn/"
            f"api/v2.1/share-links/{archive}/dirents/"
        )

        self.file_link = (
            f"https://cloud.tsinghua.edu.cn/"
            f"d/{archive}/files/"
        )

        parsed = urlparse(shared_link)
        qs = parse_qs(parsed.query)

        if "p" in qs:
            self.start_path = unquote(qs["p"][0])
        else:
            self.start_path = "/"

        self.root = os.path.abspath(outdir)

        os.makedirs(self.root, exist_ok=True)

    def list_dir(self, path):

        url = self.api_link + "?path=" + quote(path)

        r = requests.get(
            url,
            headers=self.headers,
            timeout=60
        )

        if r.status_code != 200:
            raise RuntimeError(
                f"Cannot access {path}\n"
                f"status={r.status_code}\n"
                f"{r.text}"
            )

        return r.json()["dirent_list"]

    def download_file(self, remote_path, local_path):

        if os.path.exists(local_path):

            print("Skip:", local_path)

            return

        url = (
            self.file_link
            + "?p="
            + quote(remote_path)
            + "&dl=1"
        )

        r = requests.get(
            url,
            headers=self.headers,
            stream=True,
            timeout=60
        )

        if r.status_code != 200:
            print("Fail:", remote_path)
            return

        print("Downloading:", remote_path)

        with open(local_path, "wb") as f:

            for chunk in r.iter_content(
                    chunk_size=1024 * 1024):

                if chunk:
                    f.write(chunk)

    def recurse(self, remote_path, local_dir):

        os.makedirs(local_dir, exist_ok=True)

        items = self.list_dir(remote_path)

        for item in items:

            if item["is_dir"]:

                next_remote = item["folder_path"]

                next_local = os.path.join(
                    local_dir,
                    item["folder_name"]
                )

                self.recurse(
                    next_remote,
                    next_local
                )

            else:

                remote_file = item["file_path"]

                local_file = os.path.join(
                    local_dir,
                    item["file_name"]
                )

                self.download_file(
                    remote_file,
                    local_file
                )

    def run(self):

        print()

        print("Start path:")
        print(self.start_path)

        print()

        print("Output:")
        print(self.root)

        print()

        self.recurse(
            self.start_path,
            self.root
        )

        print()

        print("Finished.")


if __name__ == "__main__":

    if len(sys.argv) < 2:

        print()

        print(
            "Usage:\n"
            "python thu_cloud_download.py "
            "\"share_link\" "
            "[output_dir]"
        )

        sys.exit()

    share = sys.argv[1]

    if len(sys.argv) >= 3:
        out = sys.argv[2]
    else:
        out = "./download"

    THUCloud(
        share,
        out
    ).run()