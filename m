Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43813 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbbBBXbr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2015 18:31:47 -0500
Date: Mon, 2 Feb 2015 23:31:36 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] change non-atomic bitops method
Message-ID: <20150202233136.GL8656@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
 <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20150202233136.h_-ExbBPsdtrStF4quAxR5yMpEvlEHMCA7bA5pB8xMM@z>

On Mon, Feb 02, 2015 at 03:29:09PM -0800, Andrew Morton wrote:
> On Mon, 2 Feb 2015 11:55:03 +0800 "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:
> 
> > This patch change non-atomic bitops,
> > add a if() condition to test it, before set/clear the bit.
> > so that we don't need dirty the cache line, if this bit
> > have been set or clear. On SMP system, dirty cache line will
> > need invalidate other processors cache line, this will have
> > some impact on SMP systems.
> > 
> > --- a/include/asm-generic/bitops/non-atomic.h
> > +++ b/include/asm-generic/bitops/non-atomic.h
> > @@ -17,7 +17,9 @@ static inline void __set_bit(int nr, volatile unsigned long *addr)
> >  	unsigned long mask = BIT_MASK(nr);
> >  	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> >  
> > -	*p  |= mask;
> > +	if ((*p & mask) == 0)
> > +		*p  |= mask;
> > +
> >  }
> 
> hm, maybe.
> 
> It will speed up set_bit on an already-set bit.  But it will slow down
> set_bit on a not-set bit.  And the latter case is presumably much, much
> more common.
> 
> How do we know the patch is a net performance gain?

Yes, we do need to know the performance impact of changes like this -
as Laura said in her reply already...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
