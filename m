Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54350 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGINyk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 09:54:40 -0400
Date: Mon, 9 Jul 2018 15:54:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709134550.29541-1-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, David Laight <David.Laight@ACULAB.COM>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>, stable@vger.kernel.org
Message-ID: <20180709135409.1SthS0PLwQSgRyAZdPrantuXEXwg6UhF6n_K4zvmigk@z>

On Mon, Jul 09, 2018 at 04:45:50PM +0300, Alexey Brodkin wrote:
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index f98a097e73f2..d65327cb83c9 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -24,8 +24,12 @@ struct devres_node {
>  
>  struct devres {
>  	struct devres_node		node;
> -	/* -- 3 pointers */
> -	unsigned long long		data[];	/* guarantee ull alignment */
> +	/*
> +	 * data[] must be 64 bit aligned even on 32 bit architectures
> +	 * because it might be accessed by instructions that require
> +	 * aligned memory arguments such as atomic64_t.
> +	 */
> +	u8 __aligned(8)			data[];
>  };
