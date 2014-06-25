From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Wed, 25 Jun 2014 14:51:51 -0700
Message-ID: <1403733111.24788.8.camel@joe-AO725>
References: <cover.1403530604.git.joe@perches.com>
	 <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
	 <20140625122755.152685fadbc9cffe7a298dc6@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:48716 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755516AbaFYVvy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jun 2014 17:51:54 -0400
In-Reply-To: <20140625122755.152685fadbc9cffe7a298dc6@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Wed, 2014-06-25 at 12:27 -0700, Andrew Morton wrote:
> On Mon, 23 Jun 2014 06:41:29 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > Add this helper for consistency with pci_zalloc_coherent
> > and the ability to remove unnecessary memset(,0,) uses.
> 
> While we're being anal..  I'm not a big fan of the patch titles.  Worst
> is "amd: Use pci_zalloc_consistent".  "amd" is quite a poor identifier
> - it's only when you get in and look at the diff that you realise it's
> an ethernet driver.

Yeah, those "amd:" prefixes should really have been "pcnet32:"

> People sometimes address this by using
> 
> 	"drivers: net: ethernet: amd: use pci_zalloc_consistent"
> 
> which strikes me as utterly perverse.  We already have a nice way of
> representing the hierarchy and that's using '/'.

I used to do that until several people complained.
Now I don't.  btw:  Documentation/SubmittingPatches says:

15) The canonical patch format

The canonical patch subject line is:

    Subject: [PATCH 001/123] subsystem: summary phrase


> So when the irritation gets too high and when I can be bothered I'll
> rewrite things like that to
> 
> 	"drivers/net/ethernet/amd: use pci_zalloc_consistent"
> 
> which strikes me as being blindingly obvious, but apparently I'm in a
> small minority :(
> 
> > --- a/include/asm-generic/pci-dma-compat.h
> > +++ b/include/asm-generic/pci-dma-compat.h
> > @@ -19,6 +19,14 @@ pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
> >  	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
> >  }
> >  
> > +static inline void *
> > +pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
> > +		      dma_addr_t *dma_handle)
> > +{
> > +	return dma_zalloc_coherent(hwdev == NULL ? NULL : &hwdev->dev,
> > +				   size, dma_handle, GFP_ATOMIC);
> > +}
> > +
> 
> We'd get a smaller kernel by uninlining this.  It is hardly
> performance-sensitive.  Uninlining would presumably use more stack,
> but GFP_ATOMIC won't use a ton of stack anyway.

True.  Maybe via a follow-on patch.

Another option would be to remove pci_[z]alloc_consistent
and just use dma_alloc_coherent instead.
