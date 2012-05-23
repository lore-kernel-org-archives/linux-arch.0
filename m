From: David Miller <davem@davemloft.net>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 16:36:44 -0400 (EDT)
Message-ID: <20120523.163644.875474822428763332.davem@davemloft.net>
References: <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
	<20120523.143543.366370918467441501.davem@davemloft.net>
	<CA+55aFy78h5z1fnW+TovTQ4wUBauUW4i7=Z583tbQVMhsWvTAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:33704 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758666Ab2EWUhy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 16:37:54 -0400
In-Reply-To: <CA+55aFy78h5z1fnW+TovTQ4wUBauUW4i7=Z583tbQVMhsWvTAQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 May 2012 11:46:54 -0700

> On Wed, May 23, 2012 at 11:35 AM, David Miller <davem@davemloft.net> wrote:
>>
>> FWIW, when I code this end case in assembler on sparc64 I just go for
>> a bunch of conditional moves, so I'll try to come up with something
>> similar to the above that gcc will emit reasonably.
> 
> .. and yes, it's possible that the keep-it-simple-and-stupid code you
> posted first will actually generate better code if gcc can change it
> all to cmov's.

I toyed around with some of the ideas we discussed but gcc really
mishandled all the approaches I tried.

It seemed to, no matter what I did, want to reload the Mycroft
constants in the tail code even though it had them all readily
available in registers for the word-at-a-time loop body.

We, of course, can't just use the already calculated has_zero() mask
value to figure out has_zero_32() and has_zero_16().  This is because
carrying can cause 0x80 values to end up in the mask at the locations
adjacent to the real zero byte.

As discussed in the past and as implemented in fs/namei.c, on
little-endian it's trivial the mask out the uninteresting 0x80 bytes
with that:

	mask = (mask - 1) & ~mask;

thing.

What I think we can do on big-endian is this:

1) In the loop, use the test:

      (x + 0xfefefeff) & ~(x | 0x7f7f7f7f)

   It's the same effective cost as the current test (on sparc
   it would be ADD, OR, ANDNCC).

   We make sure to calculate the "x | 0x7f7f7f7f" part into
   a variable which is not clobbered by the rest of the test.

   This is so we can reuse it in #2.

2) Once we find a word containing the zero byte, do a:

	~(((x & 0x7f7f7f7f) + 0x7f7f7f7f) | x | 0x7f7f7f7f)

   and that "x | 0x7f7f7f7f" part is already calculated and thus
   can be cribbed the place we left it in #1 above.

   And now we'll have exactly a 0x80 where there is a zero byte,
   and no bleeding of 0x80 values into adjacent byte positions.

Once we have that we can just test that mask directly for the
zero byte location search code.
