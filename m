Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34776 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfGVGUt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jul 2019 02:20:49 -0400
Message-ID: <1563776443.3223.8.camel@HansenPartnership.com>
Subject: Re: [PATCH] unaligned: delete 1-byte accessors
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 22 Jul 2019 15:20:43 +0900
In-Reply-To: <20190722060744.GA24253@avx2>
References: <20190721215253.GA18177@avx2>
         <1563750513.2898.4.camel@HansenPartnership.com>
         <20190722052244.GA4235@avx2>
         <1563774526.3223.2.camel@HansenPartnership.com>
         <20190722060744.GA24253@avx2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, axboe@kernel.dk, kvalo@codeaurora.org, john.johansen@canonical.com, linux-arch@vger.kernel.org
Message-ID: <20190722062043.HqrJWxVWk2gxT35TWLqmaJxescfqB4NTOqqTXaPr3_A@z>

On Mon, 2019-07-22 at 09:07 +0300, Alexey Dobriyan wrote:
> On Mon, Jul 22, 2019 at 02:48:46PM +0900, James Bottomley wrote:
> > On Mon, 2019-07-22 at 08:22 +0300, Alexey Dobriyan wrote:
> > > On Mon, Jul 22, 2019 at 08:08:33AM +0900, James Bottomley wrote:
> > > > On Mon, 2019-07-22 at 00:52 +0300, Alexey Dobriyan wrote:
> > > > > Each and every 1-byte access is aligned!
> > > > 
> > > > The design idea of this is for parsing descriptors.  We simply
> > > > chunk up the describing structure using get_unaligned for
> > > > everything.  The reason is because a lot of these structures
> > > > come
> > > > with reserved areas which we may make use of later.  If we're
> > > > using
> > > > get_unaligned for everything we can simply change a u8 to a u16
> > > > in
> > > > the structure absorbing the reserved padding.  With your change
> > > > now
> > > > I'd have to chase down every byte access and replace it with
> > > > get_unaligned instead of simply changing the structure.
> > > > 
> > > > What's the significant advantage of this change that
> > > > compensates
> > > > for the problems the above causes?
> > > 
> > > HW descriptors have fixed endianness, you're supposed to use
> > > get_unaligned_be32() and friends.
> > 
> > Not if this is an internal descriptor format, which is what this is
> > mostly used for.
> 
> Maybe, but developer is supposed to look at all struct member usages
> while changing types, right?
> 
> > > For that matter, drivers/scsi/ has exactly 2 get_unaligned()
> > > calls
> > > one of which can be changed to get_unaligned_be32().
> > 
> > You haven't answered the "what is the benefit of this change"
> > question.
> >  I mean sure we can do it, but it won't make anything more
> > efficient
> > and it does help with the descriptor format to treat every
> > structure
> > field the same.
> 
> The benefit is less code, come on.
> 
> Another benefit is that typoing
> 
> 	get_unaligned((u16*)p)
> 
> for
> 	get_unaligned((u8*)p)
> 
> will get detected.

Well, that's not the way it's supposed to be used.  It's supposed to be
used as

struct desc {
u8 something;
u8 pad 1;
u16 another;
} __packed;

something = get_unaligned[_le/be](&struct.something);

So that the sizes are encoded in the descriptor structure.  If you
think it's badly documented, then please update that, I just don't see
a benefit to a coding change that removes the u8 version of this
because it makes our descriptor structure handling inconsistent.

Even if we allow people are hard coding the typedef, then making u8 not
work just looks inconsistent ... you could easily have typoed u32 for
u16 in the example above and there would be no detection.

James
