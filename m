From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: [BUG perf] perf_fetch_caller_regs / rewind_frame_pointer can panic
Date: Thu, 08 Apr 2010 11:57:20 +0200
Message-ID: <1270720640.2215.43.camel@edumazet-laptop>
References: <1269568362-13690-1-git-send-regression-fweisbec@gmail.com>
	 <1269568362-13690-6-git-send-regression-fweisbec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:53908 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab0DHJ50 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2010 05:57:26 -0400
In-Reply-To: <1269568362-13690-6-git-send-regression-fweisbec@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>, Archs <linux-arch@vger.kernel.org>

Hello

Current linux-2.6 tree panics on my dev machine

64 bit kernel, 32bit user land
CONFIG_FRAME_POINTER=y

perf timechart record &

Instant crash

Call Trace:
 perf_trace_sched_switch+0xd5/0x120
 schedule+0x6b5/0x860
 retint_careful+0xd/0x21
 
RIP ffffffff81010955 perf_arch_fetch_caller_regs+0x15/0x40
CR2: 00000000d21f1422


rewind_frame_pointer() is probably wrong.

No test performed to check frame is in current stack, or
that (!user_mode_vm(regs))


static inline unsigned long rewind_frame_pointer(int n)
{
	struct stack_frame *frame;

	get_bp(frame);

#ifdef CONFIG_FRAME_POINTER
	while (n--)
		frame = frame->next_frame;
#endif

	return (unsigned long)frame;
}
