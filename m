Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3290 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164011AbWLGXnL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2006 18:43:11 -0500
Date: Thu, 7 Dec 2006 23:42:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than cmpxchg()
Message-ID: <20061207234250.GH1255@flint.arm.linux.org.uk>
References: <20061207085409.228016a2.akpm@osdl.org> <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com> <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com> <639.1165521999@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <639.1165521999@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, davem@davemloft.com, wli@holomorphy.com, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Dec 07, 2006 at 08:06:39PM +0000, David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > and we can assume (and ensure) that a failing test_and_set_bit() will not
> > write to the affected word at all.
> 
> You may not assume that; and indeed that is not so in the generic
> spinlock-based bitops or ARM pre-v6 or PA-RISC or sparc32 or ...

Incorrect.  pre-v6 ARM bitops for test_and_xxx_bit() all do:

	save and disable irqs
	load value
	test bit
	if not in desired state, alter bit and write it back
	restore irqs

but I don't guarantee that we'll always do that - indeed, post-armv6
bitops always write back even if the bit was in the desired state.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
