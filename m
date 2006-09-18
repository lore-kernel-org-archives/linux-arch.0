Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:5046 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965219AbWIRN4B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 09:56:01 -0400
Date: Mon, 18 Sep 2006 14:55:59 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/6] Introduce CONFIG_ZONE_DMA
Message-ID: <20060918135559.GB15096@infradead.org>
References: <20060911222729.4849.69497.sendpatchset@schroedinger.engr.sgi.com> <20060911222739.4849.79915.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911222739.4849.79915.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>, Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>, Arjan van de Ven <arjan@infradead.org>, Martin Bligh <mbligh@google.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Sep 11, 2006 at 03:27:39PM -0700, Christoph Lameter wrote:
> Introduce CONFIG_ZONE_DMA
> 
> This patch simply defines CONFIG_ZONE_DMA for all arches. We later do
> special things with CONFIG_ZONE_DMA after the VM and an arch are
> prepared to work without ZONE_DMA.
> 
> CONFIG_ZONE_DMA can be defined in two ways depending on how
> an architecture handles ISA DMA.
> 
> First if CONFIG_GENERIC_ISA_DMA is set by the arch then we know that
> the arch needs ZONE_DMA because ISA DMA devices are supported. We
> can catch this in mm/Kconfig and do not need to modify arch code.
> 
> Second, arches may use ZONE_DMA in an unknown way. We set CONFIG_ZONE_DMA
> for all arches that do not set CONFIG_GENERIC_ISA_DMA in order to insure
> backwards compatibility. The arches may later undefine ZONE_DMA
> if their arch code has been verified to not depend on ZONE_DMA.

Let's pass this on to linux-arch so that the arch maintainers can give input
whether they need ZONE_DMA or not.  If this just sneaks in unseen I'd bet
various architectures will just keept it around despite not needing it.

