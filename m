Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261571AbUKOLkv@vger.kernel.org>
Received: from plam.fujitsu-siemens.com ([217.115.66.9]:30008 "EHLO
	plam.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261570AbUKOLkv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Nov 2004 06:40:51 -0500
Message-ID: <419895BC.6060109@fujitsu-siemens.com>
Date: Mon, 15 Nov 2004 12:40:44 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [PATCH 9/11] - UML - fix signal mask on delivery error
References: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>  <20041112163442.45fc966f.akpm@osdl.org> <200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>
In-Reply-To: <200411142213.iAEMDHbV013050@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, blaisorblade_spam@yahoo.it, linux-arch@vger.kernel.org, jdike@ccure.user-mode-linux.org
List-ID: <linux-arch.vger.kernel.org>

Jeff Dike wrote:
> akpm@osdl.org said:
> 
>>Could you send one of the test apps?  This is something which the arch
>>maintainers might want to look into fixing, thanks. 
> 
> 
> Attached...
> 
> Included are
> 	breakout.c - UML-specific breakouts, fixed in 2.6 and 2.4 now, but
> please don't popularize these :-)
> 
> 	step_sighdlr.c - PTRACE_SINGLESTEPs into a signal handler, if I'm
> reading the code right, fails on i386
I guess, you are notb using i386 2.6.9. On a 2.6.9-vanilla i386 the test
doesn't fail! In 2.6.9 some enhancement of singlestepping syscalls and
singlestepping signal handlers is included. The test checks, whether
UML 2.6.9 is compatible to 2.6.9-i386. With my patchset, it is.
> 
> 	interrupted_syscall.c - counts signals and system calls during 
> interrupted system calls, under ptrace and not.  Fails on x86 under ptrace.
On my 2.6.7 and 2.6.9 kernels, the test doesn't fail. What kerenel are you
using? Could you please send me a listing of the messages from the test?
> 
> 	kernel_restorer.c - I can't get this to compile because it's too
> intimate with the libc headers, expecting to get a k_sigaction from them.
On my SuSE 9 system, k_sigaction comes from /usr/include/asm/signal.h. This
again comes from glibc-devel-2.3.3-98.28, SuSE supplies. I had to write a
"#define __KERNEL__" into the test to have k_sigaction included. If your
system lacks a k_sigaction in the includes, please copy a definition from
the kernel sources to my test. Yes, that's dirty, but it's a test only!
k_sigaction is needed to call sys_sigaction directly, bypassing the lib.
This was the only way to test the kernels restorer-stub, since the lib
always inserted its own stub, if I used "NULL".
> 
> 	sigmasking.c - Makes sure that when a signal is (not) delivered to
> a bogus stack, that a segfault is delivered then, and not after returning
> to userspace.  This is the test relevant to the patch that Andrew replied
> to.
Yes. This should be the only test, that shows differences between i386
2.6.9-vanilla and UML 2.6.9 with my patches.
> 
> 				Jeff
