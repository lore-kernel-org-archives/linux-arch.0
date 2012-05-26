From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 21:21:45 -0400 (EDT)
Message-ID: <20120525.212145.1644592144935537416.davem@davemloft.net>
References: <20120525.194125.1593753424815090718.davem@davemloft.net>
	<20120525.204135.1619066165157180427.davem@davemloft.net>
	<CA+55aFwQV9kaVV9rvrVvqMa_dAetG-X1HzsiHHb4TNVa=W6Pgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:54462 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab2EZBVu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 21:21:50 -0400
In-Reply-To: <CA+55aFwQV9kaVV9rvrVvqMa_dAetG-X1HzsiHHb4TNVa=W6Pgg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 18:09:33 -0700

> On Fri, May 25, 2012 at 5:41 PM, David Miller <davem@davemloft.net> wrote:
>> Probably I should add little-endian code to the header and put it
>> under asm-generic instead since there isn't really anything sparc
>> specific about it and this will make it easier for other ports to use
>> this stuff.
> 
> Actually, I think it's better if we just do two separate ones: a
> "generic little-endian" and a "generic big-endian" one. Rather than
> mixing both into one file that is then included from some arch-file
> that statically knows its endianness instead.

Agreed, it will look a lot nicer that way.

>> This is untested and of course we'd need to tweak the x86
>> word-at-a-time header and adjust the other call sites in
>> the DCACHE and elsewhere.
> 
> I can do that. Give me a few minutes. Or more. Let's see how it ends
> up..

Ok.
