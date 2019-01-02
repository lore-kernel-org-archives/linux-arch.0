Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40945 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfABPxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:53:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so15343844pfo.7
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:53:15 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/3] sparc: Unify the system call scripts
Date: Wed,  2 Jan 2019 21:22:50 +0530
Message-ID: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S . Miller" <davem@davemloft.net>, Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102155250.jxX7pp2Zl_TB4MBJQsAt8Ygv4KH6nfr6nWTdR6SJnGo@z>

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

Firoz Khan (3):
  sparc: remove nargs from __SYSCALL
  sparc: rename not implemented system call
  sparc: generate uapi header and system call table files

 arch/sparc/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/sparc/kernel/syscalls/syscall.tbl   | 26 +++++++++++------------
 arch/sparc/kernel/syscalls/syscallhdr.sh | 36 --------------------------------
 arch/sparc/kernel/syscalls/syscalltbl.sh | 36 --------------------------------
 arch/sparc/kernel/systbls_32.S           |  3 ++-
 arch/sparc/kernel/systbls_64.S           |  4 +++-
 6 files changed, 27 insertions(+), 89 deletions(-)
 delete mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
