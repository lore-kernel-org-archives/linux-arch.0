From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 11:52:48 +0300
Message-ID: <20080815085247.GK16231@frodo>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <20080815073750.GG16231@frodo> <20080815074318.GH16231@frodo> <20080815010227.121e5e4b.akpm@linux-foundation.org> <20080815081154.GJ16231@frodo> <20080815013148.b9dfc7ad.akpm@linux-foundation.org>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080815013148.b9dfc7ad.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

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
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
