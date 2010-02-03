From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 5/14] blackfin: use generic ptrace_resume code
Date: Wed, 3 Feb 2010 14:36:47 -0500
Message-ID: <8bd0f97a1002031136h2573b05cr8dada3bd78ffaa38@mail.gmail.com>
References: <20100202185755.GA3630@lst.de> <20100202185907.GE3630@lst.de>
	<8bd0f97a1002021229x1c84d13flcc95102b7723468c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:46495 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab0BCThI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2010 14:37:08 -0500
In-Reply-To: <8bd0f97a1002021229x1c84d13flcc95102b7723468c@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: roland@redhat.com, oleg@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Feb 2, 2010 at 15:29, Mike Frysinger wrote:
> On Tue, Feb 2, 2010 at 13:59, Christoph Hellwig wrote:
>> Use the generic ptrace_resume code for PTRACE_SYSCALL, PTRACE_CONT,
>> PTRACE_KILL and PTRACE_SINGLESTEP. =C2=A0This implies defining
>> arch_has_single_step in <asm/ptrace.h> and implementing the
>> user_enable_single_step and user_disable_single_step functions, whic=
h
>> also causes the breakpoint information to be cleared on fork, which
>> could be considered a bug fix.
>>
>> Also the TIF_SYSCALL_TRACE thread flag is now cleared on PTRACE_KILL
>> which it previously wasn't which is consistent with all architecture=
s
>> using the modern ptrace code.
>
> i have local code in the Blackfin tree that does part of this patch
> (and has been tested), so i'll split this patch apart and merge into
> my tree. =C2=A0thanks!

i added tracehook support to Blackfin recently, so that covered all
the new functions here.  i just had to drop the handling of the
PTRACE_xxx things that common code already does.

when did you want to push through these updates ?  i was planning on
sending these ptrace() updates through the Blackfin tree as part of my
2.6.34 queue.  i'm guessing you didnt want this stuff in 2.6.33 ...
-mike
