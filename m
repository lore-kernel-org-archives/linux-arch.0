From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-RFC 02/10] lib: add GENERIC_PCI_IOMAP
Date: Sun, 27 Nov 2011 19:12:04 +0200
Message-ID: <20111127171203.GA31987@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
 <20111125115455.9d5e18da6e683586d84ed9c8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20111125115455.9d5e18da6e683586d84ed9c8@canb.auug.org.au>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux@openrisc.net, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, Jonas Bonn <jonas@southpole.se>, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>lin
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 25, 2011 at 11:54:55AM +1100, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Thu, 24 Nov 2011 22:17:02 +0200 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index 9120887..c8a67345 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -19,6 +19,8 @@
> >  #include <asm-generic/iomap.h>
> >  #endif
> >  
> > +#include <asm-generic/pci_iomap.h>
> > +
> >  #ifndef mmiowb
> >  #define mmiowb() do {} while (0)
> >  #endif
> > @@ -283,9 +285,6 @@ static inline void writesb(const void __iomem *addr, const void *buf, int len)
> >  #define __io_virt(x) ((void __force *) (x))
> >  
> >  #ifndef CONFIG_GENERIC_IOMAP
> > -/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
> > -struct pci_dev;
> > -extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> >  static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
> >  {
> >  }
> 
> Just wondering why you move pci_iomap but not pic_iounmap.

unmap is implemented significantly different between architectures.


>  And also if
> pci_iounmap is meant to stay here, then the "struct pci_dev" should
> probably stay as well.

Right. I'll fix that.

> > diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
> > index 98dcd76..fdcddcb 100644
> > --- a/include/asm-generic/iomap.h
> > +++ b/include/asm-generic/iomap.h
> > @@ -69,16 +69,13 @@ extern void ioport_unmap(void __iomem *);
> >  #ifdef CONFIG_PCI
> >  /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
> >  struct pci_dev;
> > -extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> >  extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
> 
> Ditto with pci_iounmap.

Answered above :)

>  Also the comment above really belongs with pci_iomap.

Right, I'll correct the comment.

> > diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> > new file mode 100644
> > index 0000000..e08b3bd
> > --- /dev/null
> > +++ b/include/asm-generic/pci_iomap.h
> > @@ -0,0 +1,26 @@
> > +/* Generic I/O port emulation, based on MN10300 code
> > + *
> > + * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
> > + * Written by David Howells (dhowells@redhat.com)
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public Licence
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the Licence, or (at your option) any later version.
> > + */
> > +#ifndef __ASM_GENERIC_PCI_IOMAP_H
> > +#define __ASM_GENERIC_PCI_IOMAP_H
> > +
> > +#ifdef CONFIG_PCI
> > +/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
> > +struct pci_dev;
> 
> You could move this struct declaration above the ifdef and remove the
> duplicate below.

Good point. Will do.

> > +extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
> > +#else
> > +struct pci_dev;
> > +static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> > +
> > +#endif /* __ASM_GENERIC_IO_H */
> > diff --git a/lib/iomap.c b/lib/iomap.c
> > index 5dbcb4b..ada922a 100644
> > --- a/lib/iomap.c
> > +++ b/lib/iomap.c
> > @@ -242,45 +242,11 @@ EXPORT_SYMBOL(ioport_unmap);
> >  #endif /* CONFIG_HAS_IOPORT */
> >  
> >  #ifdef CONFIG_PCI
> > -/**
> > - * pci_iomap - create a virtual mapping cookie for a PCI BAR
> > - * @dev: PCI device that owns the BAR
> > - * @bar: BAR number
> > - * @maxlen: length of the memory to map
> > - *
> > - * Using this function you will get a __iomem address to your device BAR.
> > - * You can access it using ioread*() and iowrite*(). These functions hide
> > - * the details if this is a MMIO or PIO address space and will just do what
> > - * you expect from them in the correct way.
> > - *
> > - * @maxlen specifies the maximum length to map. If you want to get access to
> > - * the complete BAR without checking for its length first, pass %0 here.
> > - * */
> > -void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
> > -{
> > -	resource_size_t start = pci_resource_start(dev, bar);
> > -	resource_size_t len = pci_resource_len(dev, bar);
> > -	unsigned long flags = pci_resource_flags(dev, bar);
> > -
> > -	if (!len || !start)
> > -		return NULL;
> > -	if (maxlen && len > maxlen)
> > -		len = maxlen;
> > -	if (flags & IORESOURCE_IO)
> > -		return ioport_map(start, len);
> > -	if (flags & IORESOURCE_MEM) {
> > -		if (flags & IORESOURCE_CACHEABLE)
> > -			return ioremap(start, len);
> > -		return ioremap_nocache(start, len);
> > -	}
> > -	/* What? */
> > -	return NULL;
> > -}
> > -
> > +/* Hide the details if this is a MMIO or PIO address space and just do what
> > + * you expect in the correct way. */
> >  void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
> >  {
> >  	IO_COND(addr, /* nothing */, iounmap(addr));
> >  }
> > -EXPORT_SYMBOL(pci_iomap);
> >  EXPORT_SYMBOL(pci_iounmap);
> 
> Ditto with pci_iounmap

Answered above.

> > diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> > new file mode 100644
> > index 0000000..40b26cb
> > --- /dev/null
> > +++ b/lib/pci_iomap.c
> > @@ -0,0 +1,48 @@
> > +/*
> > + * Implement the default iomap interfaces
> > + *
> > + * (C) Copyright 2004 Linus Torvalds
> > + */
> > +#include <linux/pci.h>
> > +#include <linux/io.h>
> > +
> > +#include <linux/module.h>
> 
> If this is relative to (at least) v3.2-rc1, then you should use export.h
> instead of module.h

I just copied lib/iomap.c
Will fix, thanks for the comments.

> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
