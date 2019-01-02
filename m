Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38324 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfABPhs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:37:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so14731822pgc.5
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:37:48 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/2] sh: Unify the system call scripts
Date: Wed,  2 Jan 2019 21:07:23 +0530
Message-ID: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102153723.1yn7QdzmVWVqrKXIaRBet2GYLlgRF4xbbCGnvu4IqGw@z>

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
