From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 19:14:07 -0400 (EDT)
Message-ID: <20120525.191407.1171512018515372695.davem@davemloft.net>
References: <alpine.LFD.2.02.1205251528570.26378@i5.linux-foundation.org>
	<20120525.190625.1306293406531703607.davem@davemloft.net>
	<CA+55aFwNN0vBukJkEbsHNUGz7daJZ4gksCNV=Qw6j-XfcZ2HTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:53777 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848Ab2EYXOK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 19:14:10 -0400
In-Reply-To: <CA+55aFwNN0vBukJkEbsHNUGz7daJZ4gksCNV=Qw6j-XfcZ2HTA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 16:11:36 -0700

> Ugh. I'd rather then have a opaque typedef that may be a single word
> or a couple of words. Then it just declares that (without knowing what
> it is), and passes it around to the "find zeroes" and "get length from
> mask" functions.
> 
> For x86, it would be that single "mask" variable, for sparc it would
> be a struct of the "v" and "rhs" variables.
> 
> Hmm?

That might be better.

I suppose then I'd need to make BE's has_zero() a macro instead of a
function.  Either that or we pass a pointer to this opaque typedef
thing.
