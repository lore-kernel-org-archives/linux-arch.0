From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v5 0/8] uapi: export all headers under uapi directories
Date: Thu,  2 Feb 2017 14:25:02 +0100
Message-ID: <1486041910-2665-1-git-send-email-nicolas.dichtel@6wind.com>
References: <20170131162133.GA8258@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170131162133.GA8258@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org


Here is the v5 of this series. Seems there was too many people cc'ed, so I've
removed arch specific ml. Hope it's better now.

Patches #1 and #2 are just cleanup: some exported headers were still under
a non-uapi directory. Patch #3 is a fix to avoid exporting a file that was
not under an uapi directory.
After these three patches, all exported headers are under an uapi directory:
path #4 stops searching files in non uapi directories.
The patch #5 was spotted by code review: there is no in-tree user of this
functionality.
Patch #6 fixes some warnings/errors reported by 0-day tests.
Patches #7 and #8 remove the need to list explicitly headers. Now all files
under an uapi directory are exported.

This series has been tested with a 'make headers_install' on x86 and a
'make headers_install_all'. I've checked the result of both commands.

This patch is built against linus tree. If I must rebase it against the kbuild
tree, just tell me.

v4 -> v5:
  - patch #3: get back to v3 (don't export msr-index.h)
  - patch #6: new in this version
  - patch #7: fix compilation by introducing header-n

v3 -> v4:
 - first patch has been included
 - patch #4: get back to v2 and remove arch/x86/include/asm/msr-index.h

v2 -> v3:
 - patch #1: remove arch/arm/include/asm/types.h
 - patch #2: remove arch/h8300/include/asm/bitsperlong.h
 - patch #3: remove arch/nios2/include/uapi/asm/setup.h
 - patch #4: don't export msr-index.h
 - patch #5: fix a typo: s/unput-files3-name/input-files3-name
 - patch #6: no change
 - patch #7: fix include/uapi/asm-generic/Kbuild.asm by introducing mandatory-y
 - add patch #8

v1 -> v2:
 - add patch #1 to #6
 - patch #7: remove use of header-y

Comments are welcomed,
Nicolas
