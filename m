From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/3] spinlock: allow inlined spinlocks
Date: Sun, 16 Aug 2009 11:43:03 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908161123250.3162@localhost.localdomain>
References: <20090814125801.881618121@de.ibm.com> <20090814125857.181021997@de.ibm.com> <20090816175750.GA5808@osiris.boeblingen.de.ibm.com> <20090816180631.GA23448@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59091 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751846AbZHPSnc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Aug 2009 14:43:32 -0400
In-Reply-To: <20090816180631.GA23448@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>



On Sun, 16 Aug 2009, Ingo Molnar wrote:
> 
> What's the current situation on s390, precisely which of the 28 lock 
> functions are a win to be inlined and which ones are a loss? Do you 
> have a list/table perhaps?

Let's look at x86 instead. 

The one I can _guarantee_ is worth inlining is "spin_unlock()", since it 
just generates a single "incb %m" or whatever. No loops, no conditionals, 
no nuthing. It's not even a locked instruction. Right now we literally 
generate this function for it:

	0xffffffff81420d74 <_spin_unlock+0>:	push   %rbp
	0xffffffff81420d75 <_spin_unlock+1>:	mov    %rsp,%rbp
	0xffffffff81420d78 <_spin_unlock+4>:	incb   (%rdi)
	0xffffffff81420d7a <_spin_unlock+6>:	leaveq 
	0xffffffff81420d7b <_spin_unlock+7>:	retq   

iow, the actual "bulk" of that function is a single two-byte instruction. 
And for that we generate a whole 5-byte "call" instruction, along with all 
the costs of fixed register scheduling and stupid spilling etc.

read_unlock and write_unlock are similar, and are

	lock incl (%rdi)	// 3 bytes

and

	lock addl $0x1000000,(%rdi)	// 7 bytes

respectively. At 7 bytes, write_unlock() is still likely to be smaller 
inlined (because you avoid the register games).

Other cases on x86 that would be smaller in-lined:

 - _spin_unlock_irq: 3 bytes

	incb   (%rdi)
	sti

 - _spin_unlock_irqrestore: 4 bytes

	incb   (%rdi)
	push   %rsi
	popfq

 - _read_unlock_irq/_read_unlock_irqrestore (4 and 5 bytes respectively):

	lock incl (%rdi)
	sti / push+popfq

but not, for example, any of the locking functions, nor any of the "_bh" 
versions (because local_bh_enable ends up pretty complicated, unlike 
local_bh_disable). Nor even perhaps

 - _write_unlock_irqrestore: (9 bytes)

	lock addl $0x1000000,(%rdi)
	push   %rsi
	popfq

which is starting to get to the point where a call _may_ be smaller 
(largely due to that big constant).

And '_spin_lock()' is already too big to inline:

	mov	$0x100,%eax
	lock xadd %ax,(%rdi)
	cmp	%ah,%al
	je	2f
	pause
	mov	(%rdi),%al
	je	1b

which is 20 bytes or so, and that's the simplest of the locking cases. So 
you really do have a mix of "want to inline" and "do not want to inline".

			Linus
