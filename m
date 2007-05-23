Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60780
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756000AbXEWVr2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 May 2007 17:47:28 -0400
Date: Wed, 23 May 2007 14:47:31 -0700 (PDT)
Message-Id: <20070523.144731.52132260.davem@davemloft.net>
Subject: Re: [patch 04/11] remove pci_dac_dma_... APIs
From: David Miller <davem@davemloft.net>
In-Reply-To: <200705232139.l4NLd1Mv000943@shell0.pdx.osdl.net>
References: <200705232139.l4NLd1Mv000943@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: greg@kroah.com, jbeulich@novell.com, ak@suse.de, hch@infradead.org, jeff@garzik.org, jesse.barnes@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: akpm@linux-foundation.org
Date: Wed, 23 May 2007 14:39:01 -0700

> From: "Jan Beulich" <jbeulich@novell.com>
> 
> Based on replies to a respective query, remove the pci_dac_dma_...() APIs
> (except for pci_dac_dma_supported() on Alpha, where this function is used
> in non-DAC PCI DMA code).
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Cc: Andi Kleen <ak@suse.de>
> Cc: Jesse Barnes <jesse.barnes@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David Miller <davem@davemloft.net>
> Cc: Greg KH <greg@kroah.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: <linux-arch@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: David S. Miller <davem@davemloft.net>
