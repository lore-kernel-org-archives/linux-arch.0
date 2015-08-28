From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 1/9] move io-64-nonatomic*.h out of asm-generic
Date: Fri, 28 Aug 2015 11:19:28 -0700
Message-ID: <20150828181928.GD33809@vmdeb7>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
 <1440746842-19029-2-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440746842-19029-2-git-send-email-hch@lst.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: arnd@arndb.de, mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
