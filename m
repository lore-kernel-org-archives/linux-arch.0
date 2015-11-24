From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
Date: Tue, 24 Nov 2015 11:44:34 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511241133410.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <4277009.MDAEAbRExl@wuerfel> <alpine.LFD.2.20.1511240007580.22569@knanqh.ubzr> <7133744.P9YviJnnuV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36413 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbbKXQoh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2015 11:44:37 -0500
Received: by qkda6 with SMTP id a6so7126562qkd.3
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2015 08:44:37 -0800 (PST)
In-Reply-To: <7133744.P9YviJnnuV@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 24 Nov 2015, Arnd Bergmann wrote:

> On Tuesday 24 November 2015 00:37:17 Nicolas Pitre wrote:
> > OK... I produced a minimal test case. I think gcc is screwed. And it is 
> > not a question of __builtin_constant_p being best effort. The resulting 
> > code is plain wrong where a variable is suddenly turned into a constant 
> > of value 0. Any random modification to various part of the code just 
> > makes it disappear but I didn't check the disassembly to see if it is 
> > then correct.
> > 
> > And the good news(tm) is that the same bug is triggered with x86 gcc as 
> > well.
> > 
> > Please try the attached test case.
> 
> I can confirm the behavior you see with gcc-4.9 and later (I only saw
> it on 5.x or later with the kernel code). 

It is really sensitive to code modifications. You simplify it somehow 
and the bug is gone.  So there might be some kind of complexity threshold 
that gcc-4.9 didn't reach with the kernel code.

> It seems to have been
> introduced with
> 
> https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=206941
> 
> 
>         PR tree-optimization/59597
>         * tree-ssa-threadupdate.c (dump_jump_thread_path): Move to earlier
>         in file.  Accept new argument REGISTERING and use it to modify
>         dump output appropriately.
>         (register_jump_thread): Corresponding changes.
>         (mark_threaded_blocks): Reinstate code to cancel unprofitable
>         thread paths involving joiner blocks.  Add code to dump cancelled
>         jump threading paths.
>     
>         PR tree-optimization/59597
>         * gcc.dg/tree-ssa/pr59597.c: New test.
>     
>     git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk@206941 138bc75d-0d04-0410-961f-82ee72b054a4
> 
>  gcc/ChangeLog                           |  11 +++++
>  gcc/testsuite/ChangeLog                 |   5 +++
>  gcc/testsuite/gcc.dg/tree-ssa/pr59597.c |  55 +++++++++++++++++++++++++
>  gcc/tree-ssa-threadupdate.c             | 125 +++++++++++++++++++++++++++++++++++++++------------------
>  4 files changed, 157 insertions(+), 39 deletions(-)
> 
> however, in that version, the -DHIDE_THE_BUG variant also fails:
> 
> compilation that works:
> gcc-cross -Wall -I /home/arnd/git/buildall/arm/gcc/gcc/include  -O2 -c -o /home/arnd/git/buildall/arm/gcc_testcase/src.o /home/arnd/git/buildall/arm/gcc_testcase/src.c -DHIDE_THE_BUG
> /home/arnd/git/buildall/arm/gcc_testcase/src.c: In function 'il_send_rxon_timing':
> /home/arnd/git/buildall/arm/gcc_testcase/src.c:39:30: error: call to '____ilog2_NaN' declared with attribute error: gcc is screwed

IMHO the fact that the -DHIDE_THE_BUG case is enough to make the bug go 
away sometimes is even more worrisome given the nature of the 
"workaround".

Given you have a good handle with the bad commits already, are you going 
to bring it up with the gcc people?


Nicolas
