Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4114 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751704AbWIROnC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 10:43:02 -0400
Date: Mon, 18 Sep 2006 15:42:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] Introduce CONFIG_ZONE_DMA
Message-ID: <20060918144235.GD1523@flint.arm.linux.org.uk>
References: <20060911222729.4849.69497.sendpatchset@schroedinger.engr.sgi.com> <20060911222739.4849.79915.sendpatchset@schroedinger.engr.sgi.com> <20060918135559.GB15096@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918135559.GB15096@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>, Arjan van de Ven <arjan@infradead.org>, Martin Bligh <mbligh@google.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Sep 18, 2006 at 02:55:59PM +0100, Christoph Hellwig wrote:
> Let's pass this on to linux-arch so that the arch maintainers can give input
> whether they need ZONE_DMA or not.  If this just sneaks in unseen I'd bet
> various architectures will just keept it around despite not needing it.

Thanks Chris - I'd have missed this otherwise.

FWIW, several ARM platforms do make use of ZONE_DMA, though not all, so
it's not safe to assume that it can be turned off just because it's ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
