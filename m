From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/3] xtensa: conversion to generic kernel_thread and friends
Date: Wed, 24 Oct 2012 05:48:34 +0400
Message-ID: <1351043317-21631-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61817 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab2JXBtU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2012 21:49:20 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so765207lbo.19
        for <linux-arch@vger.kernel.org>; Tue, 23 Oct 2012 18:49:19 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Marc Gauthier <marc@tensilica.com>, Al Viro <viro@zeniv.linux.org.uk>, Max Filippov <jcmvbkbc@gmail.com>

Hi.

This series converts xtensa arch to use kernel_thread, kernel_execve and
generic sys_execve.

Max Filippov (3):
  xtensa: switch to generic kernel_thread()
  xtensa: switch to generic kernel_execve()
  xtensa: switch to generic sys_execve()

 arch/xtensa/Kconfig                   |    2 +
 arch/xtensa/include/asm/processor.h   |    3 -
 arch/xtensa/include/asm/syscall.h     |    2 +-
 arch/xtensa/include/asm/unistd.h      |    1 +
 arch/xtensa/include/uapi/asm/unistd.h |    2 +-
 arch/xtensa/kernel/entry.S            |   57 +++++---------------
 arch/xtensa/kernel/process.c          |   97 +++++++++++++++------------------
 arch/xtensa/kernel/xtensa_ksyms.c     |    1 -
 8 files changed, 62 insertions(+), 103 deletions(-)

-- 
1.7.7.6
