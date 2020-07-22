From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Date: Wed, 22 Jul 2020 15:22:45 +0000
Message-ID: <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33794 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbgGVPWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 11:22:50 -0400
In-Reply-To: <20200722144213.GE2786714@ZenIV.linux.org.uk>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Al Viro' <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

From: Al Viro
> Sent: 22 July 2020 15:42
> 
> On Wed, Jul 22, 2020 at 09:27:32AM +0000, David Laight wrote:
> > From: Al Viro
> > > Sent: 21 July 2020 21:26
> > > Preparation for the change of calling conventions; right now all
> > > callers pass 0 as initial sum.  Passing 0xffffffff instead yields
> > > the values comparable mod 0xffff and guarantees that 0 will not
> > > be returned on success.
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  lib/iov_iter.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > > index 7405922caaec..d5b7e204fea6 100644
> > > --- a/lib/iov_iter.c
> > > +++ b/lib/iov_iter.c
> > > @@ -1451,7 +1451,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
> > >  		int err = 0;
> > >  		next = csum_and_copy_from_user(v.iov_base,
> > >  					       (to += v.iov_len) - v.iov_len,
> > > -					       v.iov_len, 0, &err);
> > > +					       v.iov_len, ~0U, &err);
> > >  		if (!err) {
> > >  			sum = csum_block_add(sum, next, off);
> > >  			off += v.iov_len;
> >
> > Can't you remove the csum_block_add() by passing the
> > old 'sum' in instead of the ~0U ?
> > You'll need to keep track of whether the buffer fragment
> > is odd/even aligned.
> > After an odd length fragment a bswap32() or 8 bit rotate will
> > fix things (and maybe one right at the end).
> 
> And the benefit of that would be...?  It wouldn't be any simpler,
> it almost certainly would not even be a valid microoptimization
> (nevermind that this is an arch-independent code)...

It ought to give a minor improvement because it saves the extra
csum_fold() when the checksum from a buffer is added to the
previous total.

On 64bit systems there are even advantages in passing in a 64bit
value - so the caller can add many 32bit values together.
If nothing else it lets you use a '<< 8' if the previous fragment
had an odd length.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
