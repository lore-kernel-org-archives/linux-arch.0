From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH -v3 1/2] lmb: seperate region array from lmb_region
 struct
Date: Tue, 23 Mar 2010 11:42:41 +0100
Message-ID: <20100323104241.GA1189@elte.hu>
References: <1269333587-1866-1-git-send-email-yinghai@kernel.org>
 <1269333587-1866-5-git-send-email-yinghai@kernel.org>
 <4BA899C2.8020208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:53448 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab0CWKmv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2010 06:42:51 -0400
Content-Disposition: inline
In-Reply-To: <4BA899C2.8020208@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

>  void __init lmb_init(void)
>  {
> +	lmb.memory.region   = lmb_memory_region;
> +	lmb.memory.region_array_size   = ARRAY_SIZE(lmb_memory_region);
> +	lmb.reserved.region = lmb_reserved_region;
> +	lmb.reserved.region_array_size = ARRAY_SIZE(lmb_reserved_region);
> +

That's rather unreadable and has random whitespace noise.

Should be something like:

	lmb.memory.region		= lmb_memory_region;
	lmb.memory.region_array_size	= ARRAY_SIZE(lmb_memory_region);
	lmb.reserved.region		= lmb_reserved_region;
	lmb.reserved.region_array_size	= ARRAY_SIZE(lmb_reserved_region);

also, i'd suggest to shorten region_array_size to region_size (we know it's an 
array), so it would become:

	lmb.memory.region	 = lmb_memory_region;
	lmb.memory.region_size	 = ARRAY_SIZE(lmb_memory_region);

	lmb.reserved.region	 = lmb_reserved_region;
	lmb.reserved.region_size = ARRAY_SIZE(lmb_reserved_region);

> -	if (rgn->cnt >= MAX_LMB_REGIONS)
> +	if (rgn->cnt >= (rgn->region_array_size - 1))
>  		return -1;

'x >= y-1' is equivalent to 'x > y', so that should be:

	if (rgn->cnt > rgn->region_size)

	Ingo
