Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp3.pp.htv.fi ([213.243.153.36]:6300 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1030283AbWEYRD1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 May 2006 13:03:27 -0400
Date: Thu, 25 May 2006 20:03:25 +0300
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] move scatterlist accessors into scatterlist.h on ia64, sh and sh64
Message-ID: <20060525170325.GB27601@linux-sh.org>
References: <1148221874.17239.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148221874.17239.3.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 21, 2006 at 09:31:14AM -0500, James Bottomley wrote:
> Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
> 
> ---
> Although this is a simple move, the sh implementation looks bogus.
> dma_map_sg is this:
> 
[snip]

> which is about right for a simple physical==bus physical implementation.
> However, your accessor is:
> 
> #define sg_dma_address(sg)	(virt_to_bus((sg)->dma_address))
> 
> so you're calling virt_to_bus() on an already physical address.
> 
Yes, the virt_to_bus() is bogus, feel free to drop it. The rest looks
fine.
