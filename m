From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -v3 1/2] lmb: seperate region array from lmb_region
 struct
Date: Tue, 23 Mar 2010 16:07:41 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003231528100.3147@localhost.localdomain>
References: <1269333587-1866-1-git-send-email-yinghai@kernel.org> <1269333587-1866-5-git-send-email-yinghai@kernel.org> <4BA899C2.8020208@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:43370 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754102Ab0CWPIn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2010 11:08:43 -0400
In-Reply-To: <4BA899C2.8020208@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 23 Mar 2010, Yinghai Lu wrote:

> 
> lmb_init() connect them back.
> 
> also add region_array_size in lmb_region to tack the region array size.
> 
> -v3: seperate lmb core change to seperated patch
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  include/linux/lmb.h |    5 ++++-
>  lib/lmb.c           |   11 ++++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/include/linux/lmb.h
> ===================================================================
> --- linux-2.6.orig/include/linux/lmb.h
> +++ linux-2.6/include/linux/lmb.h
> @@ -26,7 +26,8 @@ struct lmb_property {
>  struct lmb_region {
>  	unsigned long cnt;
>  	u64 size;
> -	struct lmb_property region[MAX_LMB_REGIONS+1];
> +	struct lmb_property *region;
> +	unsigned long region_array_size;
>  };
>  
>  struct lmb {
> @@ -37,6 +38,8 @@ struct lmb {
>  };
>  
>  extern struct lmb lmb;
> +extern struct lmb_property lmb_memory_region[MAX_LMB_REGIONS + 1];
> +extern struct lmb_property lmb_reserved_region[MAX_LMB_REGIONS + 1];

Is there a reason why this needs to be exported ?

Thanks,

	tglx
