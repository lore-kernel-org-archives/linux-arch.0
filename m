Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:47510 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750816AbWIRRdX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 13:33:23 -0400
Date: Mon, 18 Sep 2006 10:33:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 2/6] Introduce CONFIG_ZONE_DMA
In-Reply-To: <20060918152243.GA4320@localhost.na.rta>
Message-ID: <Pine.LNX.4.64.0609181031420.19312@schroedinger.engr.sgi.com>
References: <20060911222729.4849.69497.sendpatchset@schroedinger.engr.sgi.com>
 <20060911222739.4849.79915.sendpatchset@schroedinger.engr.sgi.com>
 <20060918135559.GB15096@infradead.org> <20060918152243.GA4320@localhost.na.rta>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>, Arjan van de Ven <arjan@infradead.org>, Martin Bligh <mbligh@google.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 19 Sep 2006, Paul Mundt wrote:

> sh and sh64 have no use for ZONE_DMA, it's effectively ZONE_DMA ==
> ZONE_NORMAL anyways, so it can be safely switched off (though
> arch/sh/mm/init.c should then be changed to use ZONE_NORMAL if ZONE_DMA
> goes away, as we currently place all lowmem in ZONE_DMA, likewise for
> sh64). None of our DMA controllers have any particular limitations where
> ZONE_DMA would be useful at least.

Ok. I dropped the CONFIG_ZONE_DMA for sh so you will no longer have a DMA 
zone when this patch goes in.
 
sh64 has the same strange code as parisc:

config GENERIC_ISA_DMA
        bool

You do not have ISA_DMA so I should drop these lines?

