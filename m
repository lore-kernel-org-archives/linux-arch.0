From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [BUG perf] perf_fetch_caller_regs / rewind_frame_pointer can
	panic
Date: Thu, 8 Apr 2010 12:59:16 +0200
Message-ID: <20100408105913.GE5247@nowhere>
References: <1269568362-13690-1-git-send-regression-fweisbec@gmail.com> <1269568362-13690-6-git-send-regression-fweisbec@gmail.com> <1270720640.2215.43.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:54719 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758368Ab0DHK7Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2010 06:59:25 -0400
Content-Disposition: inline
In-Reply-To: <1270720640.2215.43.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>, Archs <linux-arch@vger.kernel.org>

On Thu, Apr 08, 2010 at 11:57:20AM +0200, Eric Dumazet wrote:
> Hello
> 
> Current linux-2.6 tree panics on my dev machine
> 
> 64 bit kernel, 32bit user land
> CONFIG_FRAME_POINTER=y
> 
> perf timechart record &
> 
> Instant crash
> 
> Call Trace:
>  perf_trace_sched_switch+0xd5/0x120
>  schedule+0x6b5/0x860
>  retint_careful+0xd/0x21
>  
> RIP ffffffff81010955 perf_arch_fetch_caller_regs+0x15/0x40
> CR2: 00000000d21f1422
> 
> 
> rewind_frame_pointer() is probably wrong.
> 
> No test performed to check frame is in current stack, or
> that (!user_mode_vm(regs))



user_mode_vm() can not work here as we are actually filling
regs from scratch.

But we indeed need to have a safe dereference to avoid such
crashes. A simple probe_kernel_address() should do the trick.

This API is going to change for the next cycle as it won't need
to rewind further than the first caller. So I'm going to do a
rough probe_kernel_address() fix for the current version. The next
one won't have this problem.



> 
> 
> static inline unsigned long rewind_frame_pointer(int n)
> {
> 	struct stack_frame *frame;
> 
> 	get_bp(frame);
> 
> #ifdef CONFIG_FRAME_POINTER
> 	while (n--)
> 		frame = frame->next_frame;
> #endif
> 
> 	return (unsigned long)frame;
> }
> 
> 
> 
