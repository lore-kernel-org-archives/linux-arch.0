From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] swiotlb: enlarge iotlb buffer on demand
Date: Mon, 2 Aug 2010 23:56:12 +0900
Message-ID: <20100802235521D.fujita.tomonori@lab.ntt.co.jp>
References: <20100731010706.GA30319@andromeda.dapyr.net>
	<20100801120224F.fujita.tomonori@lab.ntt.co.jp>
	<201008020940.09552.konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:44245 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab0HBO4Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Aug 2010 10:56:24 -0400
In-Reply-To: <201008020940.09552.konrad.wilk@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: konrad.wilk@oracle.com
Cc: fujita.tomonori@lab.ntt.co.jp, konrad@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ak@linux.intel.com, akataria@vmware.com

On Mon, 2 Aug 2010 09:40:08 -0400
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> I am curious about the handling of the -ENOMEM stage. Naturally we would 
> return an error the device - are the most common ones (ahci, r8169, 
> ata_piix - those that are DMA_32) equipped to deal with unavailable memory?

libata does dma mapping for ata drivers. It can handle mapping errors.

Looks like r8169 can't handle errors.

All drivers should handle mapping errors because IOMMUs are pretty
common now. I think that drivers that vendor people are serious about
can handle mapping errors.
