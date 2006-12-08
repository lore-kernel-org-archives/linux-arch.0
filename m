Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760725AbWLHN5t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Dec 2006 08:57:49 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061208111410.GA31068@flint.arm.linux.org.uk> 
References: <20061208111410.GA31068@flint.arm.linux.org.uk>  <20061207234250.GH1255@flint.arm.linux.org.uk> <20061207085409.228016a2.akpm@osdl.org> <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com> <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com> <639.1165521999@redhat.com> <26012.1165535903@redhat.com> 
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than cmpxchg() 
Date: Fri, 08 Dec 2006 13:57:09 +0000
Message-ID: <4501.1165586229@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, davem@davemloft.com, wli@holomorphy.com, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> These are the constant versions, where the compiler can optimise the
> mask and word offset itself.

So my inclusion of ARM is correct...  Under some circumstances it will write
to the target word when it wouldn't actually make a change:

	static inline int
	____atomic_test_and_set_bit(unsigned int bit, volatile unsigned long *p)
	{
		unsigned long flags;
		unsigned int res;
		unsigned long mask = 1UL << (bit & 31);

		p += bit >> 5;

		raw_local_irq_save(flags);
		res = *p;
		*p = res | mask;
		raw_local_irq_restore(flags);

		return res & mask;
	}

Remember: *p is volatile.

David
