Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10664
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751485AbWEUFz0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 May 2006 01:55:26 -0400
Date: Sat, 20 May 2006 22:55:30 -0700 (PDT)
Message-Id: <20060520.225530.23952587.davem@davemloft.net>
Subject: Re: Problem with sg_dma_address() on ia64, sh and sh64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1148141933.3529.25.camel@mulgrave.il.steeleye.com>
References: <1148141933.3529.25.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sat, 20 May 2006 11:18:53 -0500

> This is the defined accessor to our struct scatterlist.  These three
> architectures define it in asm/pci.h rather than asm/scatterlist.h.
> This means that one doesn't get the accessor simply by including
> linux/scatterlist.h, which one should.  This means that non-pci uses
> don't work (like our budding libsrp).
> 
> Could you all move it to where it should be?

I agree, there should be nothing PCI specific about
the scatterlist DMA entry accessors.
