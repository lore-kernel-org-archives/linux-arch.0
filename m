Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:15621 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965247AbWIROIQ
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 10:08:16 -0400
Subject: Re: [PATCH 2/6] Introduce CONFIG_ZONE_DMA
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20060918135559.GB15096@infradead.org>
References: <20060911222729.4849.69497.sendpatchset@schroedinger.engr.sgi.com>
	 <20060911222739.4849.79915.sendpatchset@schroedinger.engr.sgi.com>
	 <20060918135559.GB15096@infradead.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 16:08:07 +0200
Message-Id: <1158588487.31364.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>, Arjan van de Ven <arjan@infradead.org>, Martin Bligh <mbligh@google.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-18 at 14:55 +0100, Christoph Hellwig wrote:
> > Second, arches may use ZONE_DMA in an unknown way. We set CONFIG_ZONE_DMA
> > for all arches that do not set CONFIG_GENERIC_ISA_DMA in order to insure
> > backwards compatibility. The arches may later undefine ZONE_DMA
> > if their arch code has been verified to not depend on ZONE_DMA.
> 
> Let's pass this on to linux-arch so that the arch maintainers can give input
> whether they need ZONE_DMA or not.  If this just sneaks in unseen I'd bet
> various architectures will just keept it around despite not needing it.

s390 needs ZONE_DMA for the memory area below 2GB. That is required for
the control structure of channel based I/O. It is not ISA but
conceptually related. Can we rename GENERIC_ISA_DMA into GENERIC_IO_DMA
or something similar?

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


