Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43497 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbfABPM3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:12:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so14634597plb.10
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:12:29 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/2] microblaze: Unify the system call scripts
Date: Wed,  2 Jan 2019 20:42:02 +0530
Message-ID: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102151202.e_UcCSRg5EaHEkSrI35sYaCHE6E5L0b_VLwjNxqyT8s@z>

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
  microblaze: remove nargs from __SYSCALL
  microblaze: generate uapi header and system call table files

 arch/microblaze/kernel/syscall_table.S        |  2 +-
 arch/microblaze/kernel/syscalls/Makefile      | 11 ++++++--
 arch/microblaze/kernel/syscalls/syscallhdr.sh | 36 ---------------------------
 arch/microblaze/kernel/syscalls/syscalltbl.sh | 32 ------------------------
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
