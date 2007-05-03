Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:46756 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753940AbXECWXW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 May 2007 18:23:22 -0400
In-Reply-To: <20070503.132801.68856382.davem@davemloft.net>
References: <20070503173842.GC10249@linux-mips.org> <20070503.132801.68856382.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1fb72105b8d63aa1a1c890d1b17cef2f@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: gcc generating calls to __udivdi3
Date: Fri, 4 May 2007 00:23:19 +0200
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

>> Forwarding this to linux-arch mostly as a heads up to other arch 
>> maintainers
>> and discussion.  With gcc's optimizer getting increasingly smarter 
>> I'm not
>> so sure if below patch is the right thing.  In timespec_add_ns we 
>> would
>> normally except the loop to be interated once at most and gcc should 
>> make
>> this assumption due to the unlikely() hint.  Anyway, we have to be
>> prepared for more such code transformations to happen so adding a 
>> __udivdi3
>> implementation is probably the defensive approach.
>
> I would rather not have it there and therefore know when such
> an expensive operation is being emitted by gcc.
>
> It looks like the divide costs might be set wrong on MIPS
> in gcc if it thinks udivdi3 is cheaper than this loop.

More likely GCC doesn't know how many times this
loop would run on average, making the loop very
expensive indeed.  Perhaps the loop->div optimisation
just doesn't see the "unlikely()".  How about filing
a bug report?  The original mail says this only
happens with SVN versions of GCC, so if it is handled
fast enough you won't have to deal with this in the
kernel at all.


Segher

