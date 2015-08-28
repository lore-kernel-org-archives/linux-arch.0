From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 5/9] hifn_795x: stop including <asm-generic/kmap_types.h>
Date: Fri, 28 Aug 2015 21:14:59 +0800
Message-ID: <20150828131459.GA11796@gondor.apana.org.au>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
 <1440746842-19029-6-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440746842-19029-6-git-send-email-hch@lst.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: arnd@arndb.de, mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 28, 2015 at 09:27:18AM +0200, Christoph Hellwig wrote:
> <linux/highmem.h> is the placace the get the kmap type flags, asm-generic
> files are generic implementations only to be used by architecture code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
