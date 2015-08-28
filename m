Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40565 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbbH1STm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2015 14:19:42 -0400
Date: Fri, 28 Aug 2015 11:19:28 -0700
From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 1/9] move io-64-nonatomic*.h out of asm-generic
Message-ID: <20150828181928.GD33809@vmdeb7>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
 <1440746842-19029-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440746842-19029-2-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: arnd@arndb.de, mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20150828181928.0PPmVoPXzYuZS0QxlSygYmJBO5MslyhJAB04iMh3Gs8@z>

On Fri, Aug 28, 2015 at 09:27:14AM +0200, Christoph Hellwig wrote:
> These are not implementations of default architecture code but helpers
> for drivers. Move them to the place they belong to.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

...

>  drivers/platform/x86/ibm_rtl.c                 |  2 +-
>  drivers/platform/x86/intel_ips.c               |  2 +-

No objection for platform/drivers/x86

Acked-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
