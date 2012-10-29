From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 0/4] xtensa: conversion to generic kernel_thread and friends
Date: Mon, 29 Oct 2012 18:56:17 +0400
Message-ID: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32848 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab2J2O4l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 10:56:41 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3826574lag.19
        for <linux-arch@vger.kernel.org>; Mon, 29 Oct 2012 07:56:40 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, Max Filippov <jcmvbkbc@gmail.com>

Hi.

This is v2 of xtensa conversion to generic kernel_thread and friends series,
for inclusion into git://git.kernel.org/pub/scm/linux/kernel/git/viro/signal
tree.

Changes v1 -> v2:
- rebase on top of czankel/xtensa-linux dev branch; a fix to copy_thread from
  that branch on which kernel_thread conversion depends is also included;
- move pt_regs memset from copy_thread to start_thread;
- drop {set,clear}_child_tid manipulation;
- don't look at regs argument to copy_thread;
- move zero newsp logic from xtensa_clone to copy_thread.

Chris Zankel (1):
  xtensa: reset windowbase/windowstart when cloning the VM

Max Filippov (3):
  xtensa: switch to generic kernel_thread()
  xtensa: switch to generic kernel_execve()
  xtensa: switch to generic sys_execve()

 arch/xtensa/Kconfig                   |    2 +
 arch/xtensa/include/asm/processor.h   |    4 +-
 arch/xtensa/include/asm/syscall.h     |    2 +-
 arch/xtensa/include/asm/unistd.h      |    1 +
 arch/xtensa/include/uapi/asm/unistd.h |    2 +-
 arch/xtensa/kernel/entry.S            |   57 ++++-----------
 arch/xtensa/kernel/process.c          |  128 ++++++++++++++++++---------------
 arch/xtensa/kernel/xtensa_ksyms.c     |    1 -
 8 files changed, 90 insertions(+), 107 deletions(-)

-- 
1.7.7.6
