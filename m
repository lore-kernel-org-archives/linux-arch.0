From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH V3 01/29] bitops: add parity functions
Date: 25 Apr 2016 12:17:09 -0400
Message-ID: <20160425161709.15792.qmail@ns.horizon.com>
References: <571DDFE3.9010407@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns.horizon.com ([71.41.210.147]:28679 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933003AbcDYQRK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Apr 2016 12:17:10 -0400
In-Reply-To: <571DDFE3.9010407@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux@horizon.com, zengzhaoxiu@163.com, zhaoxiu.zeng@gmail.com
Cc: akpm@linux-foundation.org, arnd@arndb.de, dvlasenk@redhat.com, linux-arch@vger.kernel.org, martink@posteo.de, mingo@kernel.org, sasha.levin@oracle.com, yury.norov@gmail.com

>> Given a PARITY_MAGIC of 0x6996, this is even parity, not odd.

> From "http://www.encyclopedia.com/doc/1O11-oddparity.html", we can get
> the definition of "odd parity":

> odd parity A property that holds when a group of binary values contains
> an odd number of 1s.

That's correct, but the group of bits being discussed *includes the
parity bit itself*.

Let me be specific:

Let x be a word, which is BITS bits long.
Let parity(x) = popcount(x) & 1
Let y = x | parity(x) << BITS
Let z = x | !parity(x) << BITS

y is described as having even parity.
z is described as having odd parity.
x is not normally described using those terms

The bits appended are usually referred to as an "even parity bit" and
an "odd parity bit".

You're right that your function returns "true" if the word fed to it has
odd parity, but the bit it computes is an even parity bit.

In the field of error-checking codes, an inverse convention is
generally used: zero means no error and non-zero means error.  When
this convention is used, the same function can be used to both generate
and check parity.  (And the one you have is the even parity function.)

I think the best solution is to just delete the word "odd".
