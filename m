From: David Miller <davem@davemloft.net>
Subject: Re: Software prefetching considered harmful
Date: Thu, 19 May 2011 15:47:00 -0400 (EDT)
Message-ID: <20110519.154700.1253349185128359804.davem@davemloft.net>
References: <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
	<20110519.153259.1670240855485459381.davem@davemloft.net>
	<BANLkTi=0N55+mQjE1gq8DHdoQ0GU0A7kLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:32959 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933806Ab1ESTsO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2011 15:48:14 -0400
In-Reply-To: <BANLkTi=0N55+mQjE1gq8DHdoQ0GU0A7kLw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org, mingo@elte.hu, benh@kernel.crashing.org, rmk@arm.linux.org.uk

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 May 2011 12:38:40 -0700

> On Thu, May 19, 2011 at 12:32 PM, David Miller <davem@davemloft.net> wrote:
>>
>> It's been my experience that prefetch hurts more than it ever helps
>> for these list traversal functions.
>>
>> In fact I had been looking at some assembler output for files in the
>> networking and noticed how all of these list prefetch turds just take
>> up I-cache space.
>>
>> Please kill them off, you have my utmost support :-)
> 
> Hmm. Networking tends to use both hlist and regular lists. Does it go
> for both for you, or is one or the other more of an issue?

I think you should kill them off for all kinds of lists.

Here is one example for the non-hlist cast.  In the routing tables
we have a trie datastructure and this leads to a "struct list_head"
list of aliases.

Except in obscure setups, this list is only ever 1 entry long.  So
every prefetch is completely spurious.

There are several of these "1 entry list" cases, so it's not just
hlist that runs into this scenerio a lot.

So, to reiterate, I think you should kill all the list handling
prefetches off.

What we can do is say "for this specific list use, prefetch does
in fact help".  And provide an interface for that.  I imagine there
are things like inode dirty writeback or some dcache stuff that
walks large lists and for which prefetch might be appropriate.
