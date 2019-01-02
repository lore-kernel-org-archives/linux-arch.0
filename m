From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/2] parisc: Unify the system call scripts
Date: Wed,  2 Jan 2019 21:32:31 +0530
Message-ID: <1546444953-21630-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, John David Anglin <dave.anglin@bell.net>, Matthew Wilcox <willy@infradead.org>, linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

System call table generation support is provided for
alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
sh, sparc and xtensa architectures. The implementat-
ions are almost similar across all the above archte-
ctures. In order to reduce the source code across all
the above architectures, create common ".sh" files and
keep it in the common directory, script/. This will 
be a generic scripts which can use for all the above
architectures.

This patch depends on;
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (2):
  parisc: remove nargs from __SYSCALL
  parisc: generate uapi header and system call table files

 arch/parisc/kernel/syscall.S              |  2 +-
 arch/parisc/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/parisc/kernel/syscalls/syscallhdr.sh | 36 -------------------------------
 arch/parisc/kernel/syscalls/syscalltbl.sh | 36 -------------------------------
 4 files changed, 10 insertions(+), 75 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
