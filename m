From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: PAGE_KERNEL_RO
Date: Thu, 13 Jan 2011 12:04:02 +0300
Message-ID: <1294909442.3162.11.camel@mulgrave.site>
References: <20110112160722.6486a6c2.akpm@linux-foundation.org>
	 <1294877484.9586.66.camel@pasglop> <20110113073458.2179590a@stein>
	 <522C1DF17AF50042AD8AE87F7887BD3D01E1655529@exch.hq.tensilica.com>
	 <4D2EA95C.7000900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37303 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932429Ab1AMJER (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Jan 2011 04:04:17 -0500
In-Reply-To: <4D2EA95C.7000900@ladisch.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Marc Gauthier <marc@tensilica.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux1394-devel@lists.sourceforge.net

On Thu, 2011-01-13 at 08:27 +0100, Clemens Ladisch wrote:
> Marc Gauthier wrote:
> > Stefan Richter wrote:
> >> On Jan 13 Benjamin Herrenschmidt wrote at linux-arch:
> >>> On Wed, 2011-01-12 at 16:07 -0800, Andrew Morton wrote:
> >>>> drivers/firewire/ohci.c now needs PAGE_KERNEL_RO, but many
> >>>> architectures don't implement it.  Broke my sparc64 build.
> >>>
> >>> Some architectures actually cannot implement it even... at least some
> >>> variants of powerpc MMUs don't have a combination of protection bits
> >>> that allow a kernel-only RO mapping (yeah odd).
> >>
> >> The simplest perceivable fix, to disable firewire-ohci on
> >> architectures which don't have PAGE_KERNEL_RO, would be bad since
> >> there are actually sparc64 machines with these controllers.
> >>
> >> As far as I can tell, the new RO mapping in firewire-ohci can as well be
> >> an r/w mapping.  We just never need to write at these virtual
> >> addresses. So, should we just change the driver to map it r/w when we
> >> can't have PAGE_KERNEL_RO, or for simplicity on all architectures?
> > 
> > What do I know...  Is a simple:
> > 
> >   #ifndef PAGE_KERNEL_RO
> >   #define PAGE_KERNEL_RO PAGE_KERNEL
> >   #endif
> > 
> > in drivers/firewire/ohci.c too hacky?
> 
> --8<---------------------------------------------------------------->8--
> firewire: ohci: fix compilation on arches without PAGE_KERNEL_RO, e.g. sparc
> 
> PAGE_KERNEL_RO is not available on all architectures, so its use in the
> new AR code broke compilation on sparc64.
> 
> Because the R/O mapping is only used to catch drivers that try to write
> to the reception buffer and not actually required for correct operation,
> we can just use a normal PAGE_KERNEL mapping where _RO is not available.
> 
> Thanks to Stefan Richter and Marc Gauthier <marc@tensilica.com> for
> suggesting this fix.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> 
> --- a/drivers/firewire/ohci.c
> +++ b/drivers/firewire/ohci.c
> @@ -91,6 +91,14 @@ struct descriptor {
>  #define MAX_AR_PACKET_SIZE	(16 + MAX_ASYNC_PAYLOAD + 4)
>  #define AR_WRAPAROUND_PAGES	DIV_ROUND_UP(MAX_AR_PACKET_SIZE, PAGE_SIZE)
>  
> +/*
> + * For archs where PAGE_KERNEL_RO is not supported;
> + * mapping the AR buffers readonly for the CPU is just a debugging aid.
> + */
> +#ifndef PAGE_KERNEL_RO
> +#define PAGE_KERNEL_RO PAGE_KERNEL
> +#endif

This might cause interesting issues on sparc64 if it ever acquired a
PAGE_KERNEL_RO.  Sparc64 has extern pgprot_t for it's PAGE_KERNEL types
rather than #defines, so the #ifdef check wouldn't see this.

I think either PAGE_PROT_RO becomes part of our arch API (so all
architectures are forced to add it), or, if it's not part of the API,
ohci isn't entitled to use it.  The latter seems simplest since you have
no real use for write protection anyway.

James
