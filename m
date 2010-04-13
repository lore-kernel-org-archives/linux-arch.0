From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/39] lmb: Seperate __lmb_find_base() from
 __lmb_alloc_base()
Date: Tue, 13 Apr 2010 13:58:01 +1000
Message-ID: <1271131081.13059.51.camel@pasglop>
References: <1270793048-23796-1-git-send-email-yinghai@kernel.org>
	 <1270793048-23796-7-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39226 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197Ab0DMD7a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Apr 2010 23:59:30 -0400
In-Reply-To: <1270793048-23796-7-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 2010-04-08 at 23:03 -0700, Yinghai Lu wrote:

> +	return -1ULL;
> +}

Defininf some kind of LMB_ERROR would be nicer.

Cheers,
Ben.

> +u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
> +{
> +	u64 base;
> +
> +	base = __lmb_find_base(size, align, max_addr);
> +
> +	if (base == -1ULL)
> +		return 0;
> +
> +	if (lmb_add_region(&lmb.reserved, base, size) < 0)
> +		return 0;
> +
> +	return base;
>  }
>  
>  /* You must call lmb_analyze() before this. */
