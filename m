Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:44264 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S968827AbWLGJXz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2006 04:23:55 -0500
Message-ID: <4577DD75.50907@yahoo.com.au>
Date: Thu, 07 Dec 2006 20:23:01 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org> <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com> <20061206220532.GF3013@parisc-linux.org> <Pine.LNX.4.64.0612070130240.1868@scrub.home> <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Matthew Wilcox <matthew@wil.cx>, Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds wrote:
> 
> On Thu, 7 Dec 2006, Roman Zippel wrote:
> 
>>On Wed, 6 Dec 2006, Matthew Wilcox wrote:
>>
>>
>>>To be honest, it'd be much easier if we only defined these operations on
>>>atomic_t's.  We have all the infrastructure in place for them, and
>>>they're fairly well understood.  If you need different sizes, I'm OK
>>>with an atomic_pointer_t, or whatever.
>>
>>FWIW Seconded.
> 
> 
> I disagree.
> 
> Any _real_ CPU will simply never care about _anything_ else than just the 
> size of the datum in question. There's absolutely no point to only allow 
> it on certain types, especially as we _know_ those certain types are 
> already going to be more than one, and we also know that they are going to 
> be different sizes. In other words, in reality, we have to handle a 
> sizeable subset of the whole generic situation, and the "on certain types 
> only" situation is only going to be awkward and irritating.
> 
> For example, would we have a different "cmpxchg_ptr()" function for the 
> atomic pointer thing? With any reasonable CPU just depending on the _size_ 
> of the type, I don't see what the problem is with just doing the 
> bog-standard "cmpxchg_8/16/32/64" and having the bog-standard case- 
> statement in a header file to do it all automatically for you, and then we 
> don't need to worry about it.

What's wrong with using atomic_cmpxchg? For unsigned long / pointers,
there is a patch to implement atomic_long_cmpxchg.

Some architectures simply can't implement cmpxchg on memory that may
be modified in arbitrary ways. If you add some more conditions to use
cmpxchg, then you weaken it (ie. can't use it for synchronisation
with userspace) and on top of that you don't get the easy static
checking that atomic_t gives you.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
