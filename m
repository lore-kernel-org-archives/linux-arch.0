From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/2] sh: Unify the system call scripts
Date: Wed,  2 Jan 2019 21:07:23 +0530
Message-ID: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
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
  sh: remove nargs from __SYSCALL
  sh: generate uapi header and syscall table header files

 arch/sh/kernel/syscalls/Makefile      | 11 +++++++++--
 arch/sh/kernel/syscalls/syscallhdr.sh | 36 -----------------------------------
 arch/sh/kernel/syscalls/syscalltbl.sh | 32 -------------------------------
 arch/sh/kernel/syscalls_32.S          |  2 +-
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
