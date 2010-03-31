From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Wed, 31 Mar 2010 14:12:54 -0700
Message-ID: <4BB3BAD6.50308@zytor.com>
References: <20100325194100.GA2364@debian>	<20100331134048.da4e35a7.akpm@linux-foundation.org>	<4BB3B4DB.7040904@kernel.org> <20100331135220.c6695a51.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41398 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab0CaVRQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2010 17:17:16 -0400
In-Reply-To: <20100331135220.c6695a51.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi, cl@linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 03/31/2010 01:52 PM, Andrew Morton wrote:
> On Wed, 31 Mar 2010 13:47:23 -0700
> Yinghai Lu <yinghai@kernel.org> wrote:
> 
>> spin_unlock_irq from arm is different from other archs?
> 
> No, spin_unlock_irq() unconditionally enables interrupts on all
> architectures.

So I found checkin 60ba96e546da45d9e22bb04b84971a25684e4d46 in the
bk-historic git tree:

[PATCH] rwsem: Make rwsems use interrupt disabling spinlocks

The attached patch makes read/write semaphores use interrupt disabling
spinlocks in the slow path, thus rendering the up functions and trylock
functions available for use in interrupt context.  This matches the
regular semaphore behaviour.

I've assumed that the normal down functions must be called with
interrupts enabled (since they might schedule), and used the
irq-disabling spinlock variants that don't save the flags.

Signed-Off-By: David Howells <dhowells@redhat.com>
Tested-by: Badari Pulavarty <pbadari@us.ibm.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

What we have here is a case of this assumption being violated, because
the lock is taken with interrupts disabled on a path where contention
cannot happen (because the code is single-threaded at this point), but
the lock is taken due to reuse of generic code.

The obvious way to fix this would be to use
spin_lock_irqsave..spin_lock_irqrestore in __down_read as well as in the
other locations; I don't have a good feel for what the cost of doing so
would be, though.  On x86 it's fairly expensive simply because the only
way to save the state is to push it on the stack, which the compiler
doesn't deal well with, but this code isn't used on x86.

	-hpa
