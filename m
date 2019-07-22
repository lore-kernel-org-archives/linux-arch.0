Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34170 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbfGVFs7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jul 2019 01:48:59 -0400
Message-ID: <1563774526.3223.2.camel@HansenPartnership.com>
Subject: Re: [PATCH] unaligned: delete 1-byte accessors
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 22 Jul 2019 14:48:46 +0900
In-Reply-To: <20190722052244.GA4235@avx2>
References: <20190721215253.GA18177@avx2>
         <1563750513.2898.4.camel@HansenPartnership.com>
         <20190722052244.GA4235@avx2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, axboe@kernel.dk, kvalo@codeaurora.org, john.johansen@canonical.com, linux-arch@vger.kernel.org
Message-ID: <20190722054846.PoRCI1cji2LGyghE4ezXy5UrRhyLA2Sj0KwuMVzagu4@z>

On Mon, 2019-07-22 at 08:22 +0300, Alexey Dobriyan wrote:
> On Mon, Jul 22, 2019 at 08:08:33AM +0900, James Bottomley wrote:
> > On Mon, 2019-07-22 at 00:52 +0300, Alexey Dobriyan wrote:
> > > Each and every 1-byte access is aligned!
> > 
> > The design idea of this is for parsing descriptors.  We simply
> > chunk up the describing structure using get_unaligned for
> > everything.  The reason is because a lot of these structures come
> > with reserved areas which we may make use of later.  If we're using
> > get_unaligned for everything we can simply change a u8 to a u16 in
> > the structure absorbing the reserved padding.  With your change now
> > I'd have to chase down every byte access and replace it with
> > get_unaligned instead of simply changing the structure.
> > 
> > What's the significant advantage of this change that compensates
> > for the problems the above causes?
> 
> HW descriptors have fixed endianness, you're supposed to use
> get_unaligned_be32() and friends.

Not if this is an internal descriptor format, which is what this is
mostly used for.

> For that matter, drivers/scsi/ has exactly 2 get_unaligned() calls
> one of which can be changed to get_unaligned_be32().

You haven't answered the "what is the benefit of this change" question.
 I mean sure we can do it, but it won't make anything more efficient
and it does help with the descriptor format to treat every structure
field the same.

James
