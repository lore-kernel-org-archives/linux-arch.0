Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43367 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfABO4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 09:56:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so14618050plb.10
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 06:56:45 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/2] Unify the system call scripts
Date: Wed,  2 Jan 2019 20:26:16 +0530
Message-ID: <1546440978-19569-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102145616.pd3jP8vEdGCMpUjZtf8v9saULRA8f-zn52p6q5mV5xI@z>

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
  mips: remove nargs from __SYSCALL
  mips: generate uapi header and system call table files

 arch/mips/kernel/scall32-o32.S          |  2 +-
 arch/mips/kernel/scall64-n32.S          |  2 +-
 arch/mips/kernel/scall64-n64.S          |  2 +-
 arch/mips/kernel/scall64-o32.S          |  2 +-
 arch/mips/kernel/syscalls/Makefile      |  6 +++---
 arch/mips/kernel/syscalls/syscallhdr.sh | 37 ---------------------------------
 arch/mips/kernel/syscalls/syscallnr.sh  | 28 -------------------------
 arch/mips/kernel/syscalls/syscalltbl.sh | 36 --------------------------------
 8 files changed, 7 insertions(+), 108 deletions(-)
 delete mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
 delete mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
