From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 0/4] xtensa: conversion to generic kernel_thread and friends
Date: Mon, 29 Oct 2012 19:58:02 +0300
Message-ID: <CAMo8BfKUDHyMjDRUO8jRJ=RFWcsasXKe0_Rr88+xjLkkzTa_Ng@mail.gmail.com>
References: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
	<508EAD7B.9000303@zankel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:46230 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759406Ab2J2Q6D (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 12:58:03 -0400
Received: by mail-qa0-f53.google.com with SMTP id c1so1606743qae.19
        for <linux-arch@vger.kernel.org>; Mon, 29 Oct 2012 09:58:02 -0700 (PDT)
In-Reply-To: <508EAD7B.9000303@zankel.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: czankel <chris@zankel.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org, Marc Gauthier <marc@tensilica.com>

On Mon, Oct 29, 2012 at 8:23 PM, czankel <chris@zankel.net> wrote:
> Hi Max,
>
> Has anything changed from the version that's already in linux-next? I wanted
> to push that version upstream today.

It's the same. I sent self-contained series to Al in case it blocks whatever.

> On 10/29/12 7:56 AM, Max Filippov wrote:
>>
>> Hi.
>>
>> This is v2 of xtensa conversion to generic kernel_thread and friends
>> series,
>> for inclusion into
>> git://git.kernel.org/pub/scm/linux/kernel/git/viro/signal
>> tree.
>>
>> Changes v1 ->  v2:
>> - rebase on top of czankel/xtensa-linux dev branch; a fix to copy_thread
>> from
>>    that branch on which kernel_thread conversion depends is also included;
>> - move pt_regs memset from copy_thread to start_thread;
>> - drop {set,clear}_child_tid manipulation;
>> - don't look at regs argument to copy_thread;
>> - move zero newsp logic from xtensa_clone to copy_thread.
>>
>> Chris Zankel (1):
>>    xtensa: reset windowbase/windowstart when cloning the VM
>>
>> Max Filippov (3):
>>    xtensa: switch to generic kernel_thread()
>>    xtensa: switch to generic kernel_execve()
>>    xtensa: switch to generic sys_execve()
>>
>>   arch/xtensa/Kconfig                   |    2 +
>>   arch/xtensa/include/asm/processor.h   |    4 +-
>>   arch/xtensa/include/asm/syscall.h     |    2 +-
>>   arch/xtensa/include/asm/unistd.h      |    1 +
>>   arch/xtensa/include/uapi/asm/unistd.h |    2 +-
>>   arch/xtensa/kernel/entry.S            |   57 ++++-----------
>>   arch/xtensa/kernel/process.c          |  128
>> ++++++++++++++++++---------------
>>   arch/xtensa/kernel/xtensa_ksyms.c     |    1 -
>>   8 files changed, 90 insertions(+), 107 deletions(-)
>>

-- 
Thanks.
-- Max
