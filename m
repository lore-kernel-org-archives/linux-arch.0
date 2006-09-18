Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:38586 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751746AbWIRO6O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 10:58:14 -0400
Subject: Re: [PATCH 2/6] Introduce CONFIG_ZONE_DMA
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20060918135559.GB15096@infradead.org>
References: <20060911222729.4849.69497.sendpatchset@schroedinger.engr.sgi.com>
	 <20060911222739.4849.79915.sendpatchset@schroedinger.engr.sgi.com>
	 <20060918135559.GB15096@infradead.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 09:58:05 -0500
Message-Id: <1158591485.3461.13.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>, Arjan van de Ven <arjan@infradead.org>, Martin Bligh <mbligh@google.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-18 at 14:55 +0100, Christoph Hellwig wrote:
> Let's pass this on to linux-arch so that the arch maintainers can give input
> whether they need ZONE_DMA or not.  If this just sneaks in unseen I'd bet
> various architectures will just keept it around despite not needing it.

Right at the moment, parisc has no use for ZONE_DMA.  We basically set
ZONE_DMA == ZONE_NORMAL.  I don't believe our 32 bit systems will ever
need it.  On the 64 bit systems currently we insist on having an IOMMU
for every transaction, so ZONE_DMA == ZONE_NORMAL still.  However, on
the zx1 systems, I can see us eventually implementing IOMMU bypass and
for that case, we might need ZONE_DMA (primarily for GFP_DMA32, I
suppose, which we could do internally).

James


