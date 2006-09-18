Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:58808 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751494AbWIRPW4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 11:22:56 -0400
Date: Tue, 19 Sep 2006 00:22:43 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 2/6] Introduce CONFIG_ZONE_DMA
Message-ID: <20060918152243.GA4320@localhost.na.rta>
References: <20060911222729.4849.69497.sendpatchset@schroedinger.engr.sgi.com> <20060911222739.4849.79915.sendpatchset@schroedinger.engr.sgi.com> <20060918135559.GB15096@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918135559.GB15096@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>, Arjan van de Ven <arjan@infradead.org>, Martin Bligh <mbligh@google.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Sep 18, 2006 at 02:55:59PM +0100, Christoph Hellwig wrote:
> On Mon, Sep 11, 2006 at 03:27:39PM -0700, Christoph Lameter wrote:
> > Second, arches may use ZONE_DMA in an unknown way. We set CONFIG_ZONE_DMA
> > for all arches that do not set CONFIG_GENERIC_ISA_DMA in order to insure
> > backwards compatibility. The arches may later undefine ZONE_DMA
> > if their arch code has been verified to not depend on ZONE_DMA.
> 
> Let's pass this on to linux-arch so that the arch maintainers can give input
> whether they need ZONE_DMA or not.  If this just sneaks in unseen I'd bet
> various architectures will just keept it around despite not needing it.
> 
sh and sh64 have no use for ZONE_DMA, it's effectively ZONE_DMA ==
ZONE_NORMAL anyways, so it can be safely switched off (though
arch/sh/mm/init.c should then be changed to use ZONE_NORMAL if ZONE_DMA
goes away, as we currently place all lowmem in ZONE_DMA, likewise for
sh64). None of our DMA controllers have any particular limitations where
ZONE_DMA would be useful at least.
