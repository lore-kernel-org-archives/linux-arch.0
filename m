Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:22080 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1031883AbWLGJbz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2006 04:31:55 -0500
Message-ID: <4577DF5C.5070701@yahoo.com.au>
Date: Thu, 07 Dec 2006 20:31:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk>
In-Reply-To: <20061206195820.GA15281@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King wrote:
> On Wed, Dec 06, 2006 at 11:16:55AM -0800, Christoph Lameter wrote:

> No.  If you read what I said, you'll see that you can _cheaply_ use
> cmpxchg in a ll/sc based implementation.  Take an atomic increment
> operation.
> 
> 	do {
> 		old = load_locked(addr);
> 	} while (store_exclusive(old, old + 1, addr);
> 
> On a cmpxchg, that "store_exclusive" (loosely) becomes your cmpxchg
> instruction, comparing the first arg, and if equal storing the second.
> The "load_locked" macro becomes a standard pointer deref.  Ergo, x86
> becomes:
> 
> 	do {
> 		load value
> 		manipulate it
> 		conditional store
> 	} while not stored
> 
> On ll/sc, the load_locked() macro is the load locked instruction.  The
> store_exclusive() macro is the exclusive store and it doesn't need to
> use the first parameter at all.  Ergo, ARM becomes:
> 
> 	do {
> 		ldrex r1, [r2]
> 		manipulate r1
> 		strex r0, r1, [r2]
> 	} while failed
> 
> Notice that both are optimal.
> 
> Now let's consider the cmpxchg case.
> 
> 	do {
> 		val = *addr;
> 	} while (cmpxchg(val, val + 1, addr);
> 
> The x86 case is _identical_ to the ll/sc based implementation.  Absolutely
> entirely.  No impact what so ever.
> 
> Let's look at the ll/sc case.  The cmpxchg code implemented on this has
> to reload the original value, compare it, if equal store the new value.
> So:
> 
> 	do {
> 		val = *addr;
> 		(r2 = addr, 
> 		ldrex r1, [r2]
> 		compare r1, r0
> 		strexeq r4, r3, [r2] (store exclusive if equal)
> 	} while store failed or comparecondition failed
> 
> Note how the cmpxchg has _forced_ the ll/sc implementation to become
> more complex.
> 
> So, let's recap.
> 
> Implementing ll/sc based accessor macros allows both ll/sc _and_ cmpxchg
> architectures to produce optimal code.
> 
> Implementing an cmpxchg based accessor macro allows cmpxchg architectures
> to produce optimal code and ll/sc non-optimal code.
> 
> See my point?

Wrong. Your ll/sc implementation with cmpxchg is buggy. The cmpxchg
load_locked is not locked at all, and there can be interleaving writes
between the load and cmpxchg which do not cause the store_conditional
to fail.

It might be reasonable to implement this watered down version, but:
don't some architectures have restrictions on what instructions can
be issued between the ll and the sc?

But in general I agree with you, in that a higher level primitive is
preferable (eg. atomic_add_unless).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
