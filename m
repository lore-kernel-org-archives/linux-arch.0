From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v4 0/7] uapi: export all headers under uapi directories
Date: Mon, 23 Jan 2017 15:58:34 +0100
Message-ID: <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au
List-Id: linux-arch.vger.kernel.org

Here is the v4 of this series. Seems there was too many people cc'ed, so I've
removed arch specific ml. Hope it's better now.

Patches #1 to #4 are just cleanup: some exported headers were still under
a non-uapi directory.
The patch #5 was spotted by code review: there is no in-tree user of this
functionality.
Patches #6 and #7 remove the need to list explicitly headers. Now all files
under an uapi directory are exported.

This series has been tested with a 'make headers_install' on x86 and a
'make headers_install_all'. I've checked the result of both commands.

This patch is built against linus tree. If I must rebase it against the kbuild
tree, just tell me.

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
