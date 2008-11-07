From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 7 Nov 2008 15:08:12 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0811071459130.3711@gandalf.stny.rr.com>
References: <20081107053349.861709786@polymtl.ca> <20081107052336.652868737@polymtl.ca> <25257.1226055312@redhat.com> <20081107170902.GD22134@Krystal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:56035 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYKGUIP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Nov 2008 15:08:15 -0500
In-Reply-To: <20081107170902.GD22134@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: David Howells <dhowells@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Nicolas Pitre <nico@cam.org>, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org


On Fri, 7 Nov 2008, Mathieu Desnoyers wrote:
> 
> I want to make sure
> 
>   __m_cnt_hi
>  is read before
>   mmio cnt_lo read

Hmm, let me make sure I understand why there is no wmb.

Paul, can you verify this?

Mathieu, you do the following:

   read a
   smp_rmb
   reab b
   if (test b)
      write a

So the idea is that you must read b to test it. And since we must read a 
before reading b we can see that we write a before either?

The question remains, can the write happen before either of the reads?

But since the read b is reading the hw clock, perhaps that just implies a
wmb on the hardware side?

-- Steve
