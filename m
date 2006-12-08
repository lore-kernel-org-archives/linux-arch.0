Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2723 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426186AbWLHUAF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2006 15:00:05 -0500
Date: Fri, 8 Dec 2006 19:59:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208195949.GK31068@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com> <Pine.LNX.4.64.0612081045430.3516@woody.osdl.org> <20061208190403.GH31068@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612081130110.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612081130110.3516@woody.osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Dec 08, 2006 at 11:35:39AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 8 Dec 2006, Russell King wrote:
> >
> > Yes you can.  Well, you can on ARM at least.  Between the load exclusive
> > you can do anything you like until you hit the store exclusive.  If you
> > haven't touched the location (with anything other than another load
> > exclusive) and no other CPU has issued a load exclusive, your store
> > exclusive succeeds.
> 
> Is that actually true?
> 
> Almost all LL/SC implementations have granularity rules, where "touch the 
> location" is not a byte-granular thing, but actually ends up being 
> something like "touch the same cachline".

ARM's implementation works by using some CPU core peripheral hardware to hold
two pieces of information:

 1. the physical address being accessed by the load exclusive instruction.
 2. the cpu number.

When an exclusive load is performed, this hardware "remembers" bits
[31:N] (7 >= N >= 2 *) of the physical address and the CPU number.

When an exclusive store is performed, the address and CPU number are
compared to the stored versions, and the store is only allowed to succeed
if they match.  Hence, it is independent of the actual cache state,
and is relatively cheap to implement.

The only instructions which affect the exclusive access state are the
exclusive access instructions themselves.  Hence, to the same memory
location with the following sequence:

	load exclusive
	load normal
	modify
	store normal
	store exclusive

the store exclusive _will_ succeed even though you've modified the value
in that memory location via standard loads/stores.

(* - while it is true that the physical address is stored,
implementations may themselves choose not to store between the
lower 7 to 2 bits inclusive - which incidentally means putting
two atomic_t's next together is probably a Bad Thing(tm)... and
rather sucks.  However, non-exclusive accesses within that address
region do not affect the exclusive access state.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
