Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40790 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbfABPXS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jan 2019 10:23:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so15311267pfo.7
        for <linux-arch@vger.kernel.org>; Wed, 02 Jan 2019 07:23:18 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/2] ia64: Unify the system call scripts
Date: Wed,  2 Jan 2019 20:52:45 +0530
Message-ID: <1546442567-20637-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190102152245.b3evq8r4j6o4G2PBlXudaKns3uJCR7shF9FNX-a1pOE@z>

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
  ia64: remove nargs from __SYSCALL
  ia64: generate uapi header and system call table files

 arch/ia64/kernel/entry.S                |  2 +-
 arch/ia64/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/ia64/kernel/syscalls/syscallhdr.sh | 36 ---------------------------------
 arch/ia64/kernel/syscalls/syscalltbl.sh | 32 -----------------------------
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/ia64/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/ia64/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
