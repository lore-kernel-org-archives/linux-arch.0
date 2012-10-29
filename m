From: czankel <chris@zankel.net>
Subject: Re: [PATCH v2 0/4] xtensa: conversion to generic kernel_thread and
 friends
Date: Mon, 29 Oct 2012 09:23:23 -0700
Message-ID: <508EAD7B.9000303@zankel.net>
References: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56757 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495Ab2J2QXX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 12:23:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4369615pbb.19
        for <linux-arch@vger.kernel.org>; Mon, 29 Oct 2012 09:23:23 -0700 (PDT)
In-Reply-To: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org, Marc Gauthier <marc@tensilica.com>

Hi Max,

Has anything changed from the version that's already in linux-next? I 
wanted to push that version upstream today.

Thanks,
-Chris


On 10/29/12 7:56 AM, Max Filippov wrote:
> Hi.
>
> This is v2 of xtensa conversion to generic kernel_thread and friends series,
> for inclusion into git://git.kernel.org/pub/scm/linux/kernel/git/viro/signal
> tree.
>
> Changes v1 ->  v2:
> - rebase on top of czankel/xtensa-linux dev branch; a fix to copy_thread from
>    that branch on which kernel_thread conversion depends is also included;
> - move pt_regs memset from copy_thread to start_thread;
> - drop {set,clear}_child_tid manipulation;
> - don't look at regs argument to copy_thread;
> - move zero newsp logic from xtensa_clone to copy_thread.
>
> Chris Zankel (1):
>    xtensa: reset windowbase/windowstart when cloning the VM
>
> Max Filippov (3):
>    xtensa: switch to generic kernel_thread()
>    xtensa: switch to generic kernel_execve()
>    xtensa: switch to generic sys_execve()
>
>   arch/xtensa/Kconfig                   |    2 +
>   arch/xtensa/include/asm/processor.h   |    4 +-
>   arch/xtensa/include/asm/syscall.h     |    2 +-
>   arch/xtensa/include/asm/unistd.h      |    1 +
>   arch/xtensa/include/uapi/asm/unistd.h |    2 +-
>   arch/xtensa/kernel/entry.S            |   57 ++++-----------
>   arch/xtensa/kernel/process.c          |  128 ++++++++++++++++++---------------
>   arch/xtensa/kernel/xtensa_ksyms.c     |    1 -
>   8 files changed, 90 insertions(+), 107 deletions(-)
>
