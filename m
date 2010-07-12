From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: LMB bits
Date: Mon, 12 Jul 2010 13:24:41 +1000
Message-ID: <1278905081.28659.157.camel@pasglop>
References: <20100709.172050.112604881.davem@davemloft.net>
	 <20100709.205544.48508808.davem@davemloft.net>
	 <1278759719.28659.155.camel@pasglop>
	 <20100710.131418.246532639.davem@davemloft.net>
	 <4C38DDE3.9010303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41452 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755445Ab0GLDZi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 11 Jul 2010 23:25:38 -0400
In-Reply-To: <4C38DDE3.9010303@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>, mingo@elte.hu, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Sat, 2010-07-10 at 13:53 -0700, Yinghai Lu wrote:

> Ben/David, 
> 
> can you fold in following patch in your patchset too?
> 
> also please use -v2 [PATCH] lmb: rename to memblock
> that is removing one wrong change with microblaze dts

Will do. I'm also fixing another bug David found. I'll have an updated
branch later today.

Cheers,
Ben.

> Thanks
> 
> Yinghai
> 
> 
> Subject: [PATCH] memblock: memblock_find_base() should return MEMBLOCK_ERROR on failing path
> 
> all callees assume it return MEMBLOCK_ERROR when it fail to find a range
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  mm/memblock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/mm/memblock.c
> ===================================================================
> --- linux-2.6.orig/mm/memblock.c
> +++ linux-2.6/mm/memblock.c
> @@ -154,7 +154,7 @@ static phys_addr_t __init memblock_find_
>  		if (found != MEMBLOCK_ERROR)
>  			return found;
>  	}
> -	return 0;
> +	return MEMBLOCK_ERROR;
>  }
>  
>  static void memblock_remove_region(struct memblock_type *type, unsigned long r)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
