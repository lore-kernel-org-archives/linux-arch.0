From: David Miller <davem@davemloft.net>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 19:25:50 -0400 (EDT)
Message-ID: <20120410.192550.1904257005034151185.davem@davemloft.net>
References: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
	<1334097321.3040.62.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:48889 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab2DJXZ5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 19:25:57 -0400
In-Reply-To: <1334097321.3040.62.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Apr 2012 08:35:21 +1000

> On Fri, 2012-04-06 at 14:32 -0700, Linus Torvalds wrote:
>> Ok, as some of you are aware, one of the things that got merged very
>> early in the 3.4 merge window was the "word-at-a-time" filename lookup
>> patches I had been working on. They only get enabled on x86, but when
>> they do, they do speed things up by quite a noticeable bit (mainly on
>> x86-64, which ends up doing things 8 bytes at a time - it's much less
>> noticeable on x86-32).
> 
> Talking of which ... I haven't had much time to look but any reason that
> wouldn't work on BE platforms as well when they have a fast
> byteswap-load ? Now powerpc sadly only have up to 32-bit byteswap loads
> so doing 64-bit requires a bit of shifting around but the result might
> still be faster than loading individual bytes especially since we do
> have a bunch of registers to spare....
> 
> Something lines of
> 
> -		a = *(unsigned long *)name;
> +		a = le64_to_cpup((__le64 *)name);

Yes, you're right:

https://plus.google.com/101384639386588513837/posts/737GNZPe2q6

and we can use the trick that strlen uses in glibc on powerpc
and sparc to avoid the alignment issues in strncpy_from_user().

For the DCACHE hashing bits though, we'll need to use a barrel shifted
loop on platforms that can't handle unaligned loads well.  Since the
way the hashing computation works, we can't use the same alignment
trick we use for things like strlen and strncpy

Although that would be a neat trick, making the hashing function work
in a way such that if we simply rewound the initial pointer to be
aligned, put 0xff into the alignment bytes, and the hash would still
compute properly.
