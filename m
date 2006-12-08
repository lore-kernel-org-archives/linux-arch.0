Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:49015 "HELO
	smtp101.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1164342AbWLHBTm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2006 20:19:42 -0500
Message-ID: <4578BD7C.4050703@yahoo.com.au>
Date: Fri, 08 Dec 2006 12:18:52 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk>
In-Reply-To: <20061207150303.GB1255@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King wrote:
> On Thu, Dec 07, 2006 at 08:31:08PM +1100, Nick Piggin wrote:

>>>Implementing ll/sc based accessor macros allows both ll/sc _and_ cmpxchg
>>>architectures to produce optimal code.
>>>
>>>Implementing an cmpxchg based accessor macro allows cmpxchg architectures
>>>to produce optimal code and ll/sc non-optimal code.
>>>
>>>See my point?
>>
>>Wrong. Your ll/sc implementation with cmpxchg is buggy. The cmpxchg
>>load_locked is not locked at all,
> 
> 
> Intentional - cmpxchg architectures don't generally have a load locked.

Exactly, so it is wrong -- you can't implement that behaviour with
load + cmpxchg.

>>and there can be interleaving writes
>>between the load and cmpxchg which do not cause the store_conditional
>>to fail.
> 
> 
> In which case the cmpxchg fails and we do the atomic operation again,
> in exactly the same way that we do the operation again if the 'sc'
> fails in the ll/sc case.

Not if cmpxchg sees the same value, it won't fail, regardless of how
many writes have hit that memory address.

> I do not see any problem.

This was not the big problem -- as I said, if this was the only problem
we could opt for a "watered down" version that doesn't actually load
locked [the ll/sc interface would be much cooler than cmpxchg, IMO :)]

The main problem is the restrictions between the ll and sc. This is why
I implemented atomic_cmpxchg rather than atomic_ll/sc. However I agree
that in critical code, a higher level API should be used instead (eg.
see atomic_add_unless, which can be implemented optimally on RISCs).

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
