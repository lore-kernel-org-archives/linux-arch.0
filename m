Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37309 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbfABPCd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:02:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so14703483pgb.4
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:02:32 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/2] powerpc: Unify the system call scripts
Date: Wed,  2 Jan 2019 20:32:02 +0530
Message-ID: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Al Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102150202.BE16ZSQYbDtVwo2KLJYF1bR-KJJVbXEJY1e5WmReA5E@z>

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
  powerpc: remove nargs from __SYSCALL
  powerpc: generate uapi header and system call table files

 arch/powerpc/kernel/syscalls/Makefile       | 11 +++++++--
 arch/powerpc/kernel/syscalls/syscallhdr.sh  | 37 -----------------------------
 arch/powerpc/kernel/syscalls/syscalltbl.sh  | 36 ----------------------------
 arch/powerpc/kernel/systbl.S                |  6 ++---
 arch/powerpc/platforms/cell/spu_callbacks.c |  2 +-
 5 files changed, 13 insertions(+), 79 deletions(-)
 delete mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
