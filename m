From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [patch] parisc, iommu: add missing include for prefetchw()
Date: Sat, 15 Oct 2011 19:56:55 -0500
Message-ID: <1318726615.7271.59.camel@dabdike.int.hansenpartnership.com>
References: <20111013233818.GB26654@one.firstfloor.org>
	 <1318631204.3018.101.camel@dabdike.int.hansenpartnership.com>
	 <alpine.DEB.2.00.1110151536310.25063@chino.kir.corp.google.com>
	 <1318722499.7271.54.camel@dabdike.int.hansenpartnership.com>
	 <alpine.DEB.2.00.1110151739330.5728@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46050 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753512Ab1JPA47 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 15 Oct 2011 20:56:59 -0400
In-Reply-To: <alpine.DEB.2.00.1110151739330.5728@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, 2011-10-15 at 17:41 -0700, David Rientjes wrote:
> On Sat, 15 Oct 2011, James Bottomley wrote:
> 
> > This isn't physically possible on the parisc platform: prefetch.h is
> > included by processor.h which, amongst other things, goes into
> > spinlock.h which is above this file in sba_iommu.c
> > 
> 
> asm/prefetch.h is included in processor.h, not linux/prefetch.h.  Thus, 
> it's undefined for CONFIG_PA20=n.

sba_iommu isn't possible with CONFIG_PA20=n; it's a ZX1 or above
feature.

> > How did you try to compile this file?
> > 
> 
> make allyesconfig
> make drivers/parisc/sba_iommu.o


OK, so just take one of the standard configs ... I don't think anyone's
tried much randconfig testing over parisc, most of the configuration
lore is handed down from the mountain on stone tablets.

James
