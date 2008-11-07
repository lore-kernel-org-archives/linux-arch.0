From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 7 Nov 2008 12:33:26 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0811071229570.28548@gandalf.stny.rr.com>
References: <20081107053349.861709786@polymtl.ca> <20081107052336.652868737@polymtl.ca> <25257.1226055312@redhat.com> <20081107170902.GD22134@Krystal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753937AbYKGRdo@vger.kernel.org>
In-Reply-To: <20081107170902.GD22134@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: David Howells <dhowells@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Nicolas Pitre <nico@cam.org>, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


On Fri, 7 Nov 2008, Mathieu Desnoyers wrote:
> 
>   __m_cnt_hi
>  is read before
>   mmio cnt_lo read
> 
> for the detailed reasons explained in my previous discussion with
> Nicolas here :
> http://lkml.org/lkml/2008/10/21/1
> 
> I use smp_rmb() to do this on SMP systems (hrm, actually, a rmb() could
> be required so it works also on UP systems safely wrt interrupts).

smp_rmb turns into a compiler barrier on UP and should prevent the below
description.

-- Steve

> 
> The write side is between the hardware counter, which is assumed to
> increment monotonically between each read, and the value __m_cnt_hi
> updated by the CPU. I don't see where we could put a wmb() there.
> 
> Without barrier, the smp race looks as follow :
> 
> 
> CPU    A                                    B
>                                             read hw cnt low (0xFFFFFFFA)
>        read __m_cnt_hi (0x80000000)
>        read hw cnt low (0x00000001)
>        (wrap detected :
>         (s32)(0x80000000 ^ 0x1) < 0)
>        write __m_cnt_hi = 0x00000001
>                                             read __m_cnt_hi (0x00000001)
>        return 0x0000000100000001
>                                             (wrap detected :
>                                              (s32)(0x00000001 ^ 0xFFFFFFFA) < 0)
>                                             write __m_cnt_hi = 0x80000001
>                                             return 0x80000001FFFFFFFA
>                                                                   (time jumps)
> 
> And UP interrupt race :
> 
>        Thread context                       Interrupts
>        read hw cnt low (0xFFFFFFFA)
>                                             read __m_cnt_hi (0x80000000)
>                                             read hw cnt low (0x00000001)
>                                             (wrap detected :
>                                              (s32)(0x80000000 ^ 0x1) < 0)
>                                             write __m_cnt_hi = 0x00000001
>        read __m_cnt_hi (0x00000001)
>                                             return 0x0000000100000001
>        (wrap detected :
>         (s32)(0x00000001 ^ 0xFFFFFFFA) < 0)
>        write __m_cnt_hi = 0x80000001
>        return 0x80000001FFFFFFFA
>                 (time jumps)
> 
