From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 11/25] x86,lmb: Add lmb_reserve_range/lmb_free_range
Date: Tue, 29 Jun 2010 11:52:27 -0600
Message-ID: <201006291152.29199.bjorn.helgaas@hp.com>
References: <1277227614-11581-1-git-send-email-yinghai@kernel.org> <1277227614-11581-12-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:10497 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab0F2Rvp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jun 2010 13:51:45 -0400
In-Reply-To: <1277227614-11581-12-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday, June 22, 2010 11:26:40 am Yinghai Lu wrote:

> +void __init lmb_reserve_range(u64 start, u64 end, char *name)
> +{
> +	if (start == end)
> +		return;
> +
> +	if (WARN_ONCE(start > end, "lmb_reserve_range: wrong range [%#llx, %#llx]\n", start, end))

Please use %pR format.

> +		return;
> +
> +	lmb_reserve(start, end - start);
> +}
> +
> +void __init lmb_free_range(u64 start, u64 end)
> +{
> +	if (start == end)
> +		return;
> +
> +	if (WARN_ONCE(start > end, "lmb_free_range: wrong range [%#llx, %#llx]\n", start, end))
> +		return;
> +
> +	lmb_free(start, end - start);
> +}
> 
