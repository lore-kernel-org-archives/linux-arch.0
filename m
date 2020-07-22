From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Date: Wed, 22 Jul 2020 16:17:02 +0000
Message-ID: <a55679c8d4dc4fb08d1e1782b5fc572c@AcuMS.aculab.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
 <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
 <20200722155452.GF2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50685 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728821AbgGVQRI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 12:17:08 -0400
In-Reply-To: <20200722155452.GF2786714@ZenIV.linux.org.uk>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Al Viro' <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

From: Al Viro > Sent: 22 July 2020 16:55
> To: David Laight <David.Laight@ACULAB.COM>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>; linux-kernel@vger.kernel.org; linux-
> arch@vger.kernel.org
> Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead of 0 as initial sum
> 
> On Wed, Jul 22, 2020 at 03:22:45PM +0000, David Laight wrote:
> 
> > > And the benefit of that would be...?  It wouldn't be any simpler,
> > > it almost certainly would not even be a valid microoptimization
> > > (nevermind that this is an arch-independent code)...
> >
> > It ought to give a minor improvement because it saves the extra
> > csum_fold() when the checksum from a buffer is added to the
> > previous total.
> >
> 
> Sigh...  _WHAT_ csum_fold()?
> 
> static inline __wsum
> csum_block_add(__wsum csum, __wsum csum2, int offset)
> {
>         u32 sum = (__force u32)csum2;
> 
>         /* rotate sum to align it with a 16b boundary */
>         if (offset & 1)
>                 sum = ror32(sum, 8);
> 
>         return csum_add(csum, (__force __wsum)sum);
> }
> 
> David, do you *ever* bother to RTFS?  I mean, competent supercilious twits
> are annoying, but at least with those you can generally assume that what
> they say makes sense and has some relation to reality.  You, OTOH, keep
> spewing utter bollocks, without ever lowering yourself to checking if your
> guesses have anything to do with the reality.  With supercilious twit part
> proudly on the display - you do speak with confidence, and the way you
> dispense the oh-so-valuable advice to everyone around...

Yes, I do look at the code.
I've actually spent a lot of time looking at the x86 checksum code.
I've posted a patch for a version that is about twice as fast as the
current one on a large range of x86 cpus.

Possibly I meant the 32bit reduction inside csum_add()
rather than what csum_fold() does.

Having worked on the internals of SYSV, NetBSD and Linux I probably
forget the exact names for a few things.
The brain can only hold so much information.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
