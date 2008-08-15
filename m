Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51434 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbYHOIw6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Aug 2008 04:52:58 -0400
Date: Fri, 15 Aug 2008 11:52:48 +0300
From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: drivers/usb/musb/musb_io.h
Message-ID: <20080815085247.GK16231@frodo>
Reply-To: me@felipebalbi.com
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815073750.GG16231@frodo> <20080815074318.GH16231@frodo> <20080815010227.121e5e4b.akpm@linux-foundation.org> <20080815081154.GJ16231@frodo> <20080815013148.b9dfc7ad.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080815013148.b9dfc7ad.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20080815085248.YsXKaQa0dwHwsz8ofcKSDdVIXLleK_K4Zxz5Pmg1aqA@z>

On Fri, Aug 15, 2008 at 01:31:48AM -0700, Andrew Morton wrote:
> One possible implementation might be
> 
> 
> --- a/include/linux/io.h~a
> +++ a/include/linux/io.h
> @@ -67,4 +67,41 @@ int check_signature(const volatile void 
>  			const unsigned char *signature, int length);
>  void devm_ioremap_release(struct device *dev, void *res);
>  
> +#ifndef readsl
> +
> +/*
> + * description goes here
> + */
> +static inline void readsl(const void __iomem *addr, void *buf, int len)
> +{
> +	insl((unsigned long)addr, buf, len);
> +}
> +
> +static inline void readsw(const void __iomem *addr, void *buf, int len)
> +{
> +	insw((unsigned long)addr, buf, len);
> +}
> +
> +static inline void readsb(const void __iomem *addr, void *buf, int len)
> +{
> +	insb((unsigned long)addr, buf, len);
> +}
> +
> +static inline void writesl(const void __iomem *addr, const void *buf, int len)
> +{
> +	outsl((unsigned long)addr, buf, len);
> +}
> +
> +static inline void writesw(const void __iomem *addr, const void *buf, int len)
> +{
> +	outsw((unsigned long)addr, buf, len);
> +}
> +
> +static inline void writesb(const void __iomem *addr, const void *buf, int len)
> +{
> +	outsb((unsigned long)addr, buf, len);
> +}
> +
> +#endif		/* readsl */
> +
>  #endif /* _LINUX_IO_H */

That's what I meant (or tried to). It should come from the kernel itself.
Unfortunately we didn't have that at that time and we "hacked" it in the
driver.

> But just saying "oh look, the arch layer is all screwed up, let's hack
> around it in our driver" is plain irresponsible.

I'd be glad to change if include/linux/io.h can provide those stubs.

> > > avr32 and powerpc might also have conflicts.  Now, or in the future.
> 
> Did you review these architectures?

Yeah. ppc and avr32 provide them.
Wonder if it's possible to have the above patch applied so I can get rid
of those stubs in musb_io.h

-- 
balbi
