Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:38276 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761183AbWLKEbG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Dec 2006 23:31:06 -0500
Message-ID: <457CDEDE.9080804@yahoo.com.au>
Date: Mon, 11 Dec 2006 15:30:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an
References: <20061211023054.2622.qmail@science.horizon.com>
In-Reply-To: <20061211023054.2622.qmail@science.horizon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux@horizon.com
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi "Linux",

linux@horizon.com wrote:
>>Even if ARM is able to handle any arbitrary C code between the
>>"load locked" and store conditional API, other architectures can not
>>by definition.
> 
> 
> Maybe so, but I think you and Linus are missing the middle ground.

Nobdy argued against adding nice arch specific helpers to do higher
level operations (for example, atomic_add_unless I added was able to
reduce the use of cmpxchg in the kernel and can be optimally
implemented with ll/sc). I implemented it specifically because I
didn't want to use atomic_cmpxchg directly for lockless pagecache,
exactly because it is suboptimal on RISCs in that performance
critical path.

The point is that if somebody wants to implement some fancy lockless
code, atomic_cmpxchg is a good tool to use that does not require
writing the assembly for two dozen architectures. If it is performance
critical then it can absolutely be rewritten in an optimal manner.

> While I agree that LL/SC can't be part of the kernel API for people to
> get arbitrarily clever with in the device driver du jour, they are *very*
> nice abstractions for shrinking the arch-specific code size.
> 
> The semantics are widely enough shared that it's quite possible in
> practice to write a good set of atomic primitives in terms of LL/SC
> and then let most architectures define LL/SC and simply #include the
> generic atomic op implementations.
> 
> If there's a restriction that would pessimize the generic implementation,
> that function can be implemented specially for that arch.
> 
> Then implementing things like backoff on contention can involve writing
> a whole lot less duplicated code.
> 
> 
> Just like you can write a set of helpers for, say, CPUs with physically
> addressed caches, even though the "real" API has to be able to handle the
> virtually addressed ones, you can write a nice set of helpers for machines
> with sane LL/SC.

So, what would your ll/sc abstraction look like? Let's hear it.

The one I'm thinking of goes something like this:

   atomic_ll() / atomic_sc() with the restriction that they cannot be
   nested, you cannot write any C code between them, and may only call
   into some specific set of atomic_llsc_xxx primitives, operating on
   the address given to ll, and must not have more than a given number
   of instructions between them. Also, the atomic_sc won't always fail
   if there were interleaving stores.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
