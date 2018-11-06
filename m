Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388760AbeKGBKZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 20:10:25 -0500
Date: Tue, 6 Nov 2018 07:44:37 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: + fls-change-parameter-to-unsigned-int.patch added to -mm tree
Message-ID: <20181106154437.GF3074@bombadil.infradead.org>
References: <20181105233301.KlgdF%akpm@linux-foundation.org>
 <20181106151444.GA11221@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106151444.GA11221@avx2>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org
Message-ID: <20181106154437.QhfDmZfHrUR51jS1KhCmaLRHIY8vRdvNdnaaZWEDTuI@z>

On Tue, Nov 06, 2018 at 06:14:44PM +0300, Alexey Dobriyan wrote:
> On Mon, Nov 05, 2018 at 03:33:01PM -0800, akpm@linux-foundation.org wrote:
> 
> > -static inline int fls(int x)
> > +static inline int fls(unsigned int x)
> >  {
> > -	return fls64((unsigned int) x);
> > +	return fls64(x);
> >  }
> 
> Should it return "unsigned"? Logically it should.
> I remember doing this and there was some code size increase :-(

Yes, it returns a number in the range [0-32], so it can absolutely
be unsigned.  I'm kind of surprised it made any difference.

When you say "doing this", what did you try?  unsigned fls(unsigned),
int fls(unsigned) or unsigned fls(int) ?
