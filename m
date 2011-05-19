From: David Miller <davem@davemloft.net>
Subject: Re: Software prefetching considered harmful
Date: Thu, 19 May 2011 15:32:59 -0400 (EDT)
Message-ID: <20110519.153259.1670240855485459381.davem@davemloft.net>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
	<BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:52431 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933808Ab1ESTe6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2011 15:34:58 -0400
In-Reply-To: <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org, mingo@elte.hu, benh@kernel.crashing.org, rmk@arm.linux.org.uk

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 May 2011 12:05:31 -0700

> Added davem, benh and rmk explicitly - I think you're on linux-arch,
> but still..  You may have machines that like prefetch more, although I
> think the "pollute the L1 cache" issue means that even if  you don't
> have the NULL pointer microtrap issue you'll still find this actually
> performs better..

It's been my experience that prefetch hurts more than it ever helps
for these list traversal functions.

In fact I had been looking at some assembler output for files in the
networking and noticed how all of these list prefetch turds just take
up I-cache space.

Please kill them off, you have my utmost support :-)

Acked-by: David S. Miller <davem@davemloft.net>
