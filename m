Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39839 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfABPH1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:07:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so14700857pgl.6
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:07:26 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/2] alpha: Unify the system call scripts
Date: Wed,  2 Jan 2019 20:36:57 +0530
Message-ID: <1546441619-19977-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102150657.FxdT4JfXGVjbOxfkk7_gZEBKg_y-ovjYwVG1Ei5WmhI@z>

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
  alpha: remove nargs from __SYSCALL
  alpha: generate uapi header and syscall table header files

 arch/alpha/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/alpha/kernel/syscalls/syscallhdr.sh | 36 --------------------------------
 arch/alpha/kernel/syscalls/syscalltbl.sh | 32 ----------------------------
 arch/alpha/kernel/systbls.S              |  2 +-
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/alpha/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
