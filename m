Return-Path: <willy@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25802 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262076AbUB2Qqd
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 29 Feb 2004 11:46:33 -0500
Date: Sun, 29 Feb 2004 16:46:30 +0000
From: Matthew Wilcox <willy@debian.org>
Subject: Re: [RFC] Implement dma_boundary in the generic device
Message-ID: <20040229164630.GH25779@parcelfarce.linux.theplanet.co.uk>
References: <1078070182.1756.11.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078070182.1756.11.camel@mulgrave>
Sender: <willy@www.linux.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>
List-ID: <linux-arch.vger.kernel.org>

On Sun, Feb 29, 2004 at 09:56:21AM -0600, James Bottomley wrote:
> ===== drivers/scsi/hosts.c 1.96 vs edited =====
> --- 1.96/drivers/scsi/hosts.c	Mon Dec 29 15:38:10 2003
> +++ edited/drivers/scsi/hosts.c	Sun Feb 29 09:08:09 2004
> @@ -111,6 +111,9 @@
>  	if (!shost->shost_gendev.parent)
>  		shost->shost_gendev.parent = dev ? dev : &platform_bus;
>  
> +	if(dev)

<nitpick style=janitor> Space between "if" and "(" </nitpick>

> ===== include/linux/dma-mapping.h 1.1 vs edited =====
> --- 1.1/include/linux/dma-mapping.h	Sat Dec 21 22:37:05 2002
> +++ edited/include/linux/dma-mapping.h	Sun Feb 29 09:12:02 2004
> @@ -12,6 +12,15 @@
>  
>  #include <asm/dma-mapping.h>
>  
> +#ifndef ARCH_HAS_DMA_SET_BOUNDARY
> +static inline void
> +dma_set_boundary(struct device *dev, u64 boundary)
> +{
> +	dev->dma_boundary = boundary;
> +}
> +#endif

Don't all architectures want a limit to 4GB boundaries, to avoid crossing
the first 4GB?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
