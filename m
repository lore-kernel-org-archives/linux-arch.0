From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 07/24] C6X: memory management
Date: Wed, 17 Aug 2011 09:26:12 -0400
Message-ID: <1313587573.2306.12.camel@deneb.redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
	 <1312839879-13592-8-git-send-email-msalter@redhat.com>
	 <201108091827.40045.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39499 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab1HQN0Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Aug 2011 09:26:16 -0400
In-Reply-To: <201108091827.40045.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Tue, 2011-08-09 at 18:27 +0200, Arnd Bergmann wrote:
> > +static inline int dma_is_consistent(struct device *dev, dma_addr_t
> handle)
> > +{
> > +     if (arch_is_coherent() || __dma_is_coherent(dev, handle))
> > +             return 1;
> > +     else
> > +             return 0;
> > +}
> 
> Does this need to be both a runtime decision and set per device?
> Most architectures are just always consistent or never, so you could
> turn this into an #ifdef block to define the two versions, or even
> just provide one version.

C6X is never consistent in that there is no hw snooping between main
memory and L2 cache. There is some cache control however which allows
us to create a pool of uncached memory for use as consistent DMA memory.
I think the __dma_is_coherent tries to tell at runtime if the dma handle
comes from such a pool of consistent memory.

I'm not aware of any drivers actually needing this although I'm sure TI
has some. For the purpose of getting the arch accepted, I could just
punt and take it out for now, simplifying the dma support. It can be
revisited later if needed.

--Mark
