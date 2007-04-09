Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:49791 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbXDIPK3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Apr 2007 11:10:29 -0400
Date: Mon, 9 Apr 2007 09:57:58 -0500
From: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] slob: handle SLAB_PANIC flag
Message-ID: <20070409145758.GO4892@waste.org>
References: <20070409130847.GA5048@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070409130847.GA5048@APFDCB5C>
Sender: linux-arch-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Apr 09, 2007 at 10:08:47PM +0900, Akinobu Mita wrote:
> kmem_cache_create() for slob doesn't handle SLAB_PANIC.
> 
> Cc: Matt Mackall <mpm@selenic.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> ---
>  mm/slob.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: 2.6-mm/mm/slob.c
> ===================================================================
> --- 2.6-mm.orig/mm/slob.c
> +++ 2.6-mm/mm/slob.c
> @@ -298,6 +298,9 @@ struct kmem_cache *kmem_cache_create(con
>  		c->align = (flags & SLAB_MUST_HWCACHE_ALIGN) ? SLOB_ALIGN : 0;
>  		if (c->align < align)
>  			c->align = align;
> +	} else {
> +		if (flags & SLAB_PANIC)
> +			panic("Cannot create slab cache %s\n", name);
>  	}

I think this would be more canonical:

} else if (..)
   panic();

But otherwise,

Signed-off-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
