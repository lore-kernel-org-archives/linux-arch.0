From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 22:43:18 -0400 (EDT)
Message-ID: <20120525.224318.1418525735588086513.davem@davemloft.net>
References: <20120525.204135.1619066165157180427.davem@davemloft.net>
	<CA+55aFwQV9kaVV9rvrVvqMa_dAetG-X1HzsiHHb4TNVa=W6Pgg@mail.gmail.com>
	<CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:54833 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2EZCnY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 22:43:24 -0400
In-Reply-To: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 19:13:31 -0700

> One issue is just syntactic: the fact that you want to initialize
> those constants just results in nasty syntax. Is gcc really so bad on
> sparc that it doesn't do the obvious CSE etc on the constants? That
> surprises me, because it does it on x86-64..

It CSE's them into the loop, but like I said a few days
ago it doesn't CSE them into the find_zero() code block.

> Do you *really* need to CSE them by hand?

Yes, GCC refused to do it.

It CSEs it into the loop, but not the tail code.

> So how bad does the code look on sparc if you just get rid of the
> "low_bits" and "high_bits" and just replace them with the constants
> they are?

It looks like GCC reconstituting the constants for the zero byte
determination, which on 64-bit is nearly half of the instructions
of the exit path.

But you shouldn't really need to care about this, we can surely
abstract it behind something.
