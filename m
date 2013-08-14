From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH 0/5] preempt_count rework
Date: Wed, 14 Aug 2013 06:47:45 -0700
Message-ID: <520B8A81.1080405@zytor.com>
References: <20130814131539.790947874@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45435 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759652Ab3HNNsr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Aug 2013 09:48:47 -0400
In-Reply-To: <20130814131539.790947874@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 08/14/2013 06:15 AM, Peter Zijlstra wrote:
> These patches optimize preempt_enable by firstly folding the preempt and
> need_resched tests into one -- this should work for all architectures. And
> secondly by providing per-arch preempt_count implementations; with x86 using
> per-cpu preempt_count for fastest access.
> 
> These patches have so far only been compiled for defconfig-x86_64 +
> CONFIG_PREEMPT=y and boot tested with kvm -smp 4 upto wanting to mount root.
> 
> It still needs asm volatile("call preempt_schedule": : :"memory"); as per
> Andi's other patches to avoid the C calling convention cluttering the
> preempt_enable() sites.

Hi,

I still don't see this using a decrement of the percpu variable
anywhere.  The C compiler doesn't know how to generate those, so if I'm
not completely wet we will end up relying on sub_preempt_count()...
which, because it relies on taking the address of the percpu variable
will generate absolutely horrific code.

On x86, you never want to take the address of a percpu variable if you
can avoid it, as you end up generating code like:

	movq %fs:0,%rax
	subl $1,(%rax)

... for absolutely no good reason.  You can use the existing accessors
for percpu variables, but that would make you lose the flags output
which was part of the point, so I think the whole sequence needs to be
in assembly (note that once you are manipulating percpu state you are
already in assembly.)

	-hpa
