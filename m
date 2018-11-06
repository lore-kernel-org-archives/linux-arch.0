Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50649 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389285AbeKGC2B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 21:28:01 -0500
Date: Tue, 6 Nov 2018 20:01:49 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: + fls-change-parameter-to-unsigned-int.patch added to -mm tree
Message-ID: <20181106170149.GA12947@avx2>
References: <20181105233301.KlgdF%akpm@linux-foundation.org>
 <20181106151444.GA11221@avx2>
 <20181106154437.GF3074@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181106154437.GF3074@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org
Message-ID: <20181106170149.6Dl5BFNU2mBVdNRghu00ifbYko5iBa8gH6KrEY4X-wE@z>

On Tue, Nov 06, 2018 at 07:44:37AM -0800, Matthew Wilcox wrote:
> On Tue, Nov 06, 2018 at 06:14:44PM +0300, Alexey Dobriyan wrote:
> > On Mon, Nov 05, 2018 at 03:33:01PM -0800, akpm@linux-foundation.org wrote:
> > 
> > > -static inline int fls(int x)
> > > +static inline int fls(unsigned int x)
> > >  {
> > > -	return fls64((unsigned int) x);
> > > +	return fls64(x);
> > >  }
> > 
> > Should it return "unsigned"? Logically it should.
> > I remember doing this and there was some code size increase :-(
> 
> Yes, it returns a number in the range [0-32], so it can absolutely
> be unsigned.  I'm kind of surprised it made any difference.
> 
> When you say "doing this", what did you try?  unsigned fls(unsigned),
> int fls(unsigned) or unsigned fls(int) ?

I did "unsigned fls()" with and without

	if (rv > 32)
		__builtin_unreachable();

but I didn't send anything because there was something erratic with code
generation.
