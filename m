Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46739 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfAGOxS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2019 09:53:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so240837ply.13
        for <linux-arch@vger.kernel.org>; Mon, 07 Jan 2019 06:53:17 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 0/3] c6x: system call table generation for asm-generic
Date: Mon,  7 Jan 2019 20:22:43 +0530
Message-ID: <1546872766-3354-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-c6x-dev@linux-c6x.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Message-ID: <20190107145243.omFsg1r3wfUclREM4i8XRc9Ncr8NwS7LHBpbfoWAALI@z>

This will be an automated scripts to provide easy support
for add/modify/delete the system call entry by add entry 
in respective syscall.tbl file.

System call table generation support for asm-generic is
provide for c6x architecture which will use the common
scripts resides in scripts directory and use syscall.tbl
as inputs. This implementation will replace asm-generic-
/unistd.h.

This patch depends on:
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
 https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (3):
  c6x: add Makefile to invoke syscall table generation script
  c6x: add __ARCH_NOMMU as a bugfix
  c6x: generate uapi and kapi headers

 arch/c6x/Makefile                  |  3 +++
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/c6x/include/uapi/asm/Kbuild   |  1 +
 arch/c6x/include/uapi/asm/unistd.h | 15 +++++++++-----
 arch/c6x/kernel/sys_c6x.c          |  3 ++-
 arch/c6x/kernel/syscalls/Makefile  | 41 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 6 deletions(-)
 create mode 100644 arch/c6x/kernel/syscalls/Makefile

-- 
1.9.1
