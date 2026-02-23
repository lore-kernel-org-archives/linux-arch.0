Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8AE1EBA14;
	Mon, 23 Feb 2026 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851630; cv=none; b=i2PnWFrrxwyRskUdu9oJEsiDMfEgVIDbY9OT/zZClgIJj+V/EitK/L0LMh2sCJzbGXD3iZvI/Gnhs1w3/S6NbP9pVvEIVBfcDCptdXBcAEyLEMPAZ0ETewiyD4X4HWFxTtKqkrq/bMgtZ4TbXmBEyZnK81GffN8p6Kb693tr08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851630; c=relaxed/simple;
	bh=uOtJDy2FyPxpMhP2bRO2gFMv/2nj4Vw849MMg7jCtgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoHdyIxQfeW2JSph6qMBNSRhlriUEA6aXgBRtNoathMjPECR1jJ+w1cSy0d2tGdPLTkOCBjvZnFF7OEQYXKl/uQF4U9I87rcGM5T3Od8qHwJE1+d0XKr10V5+QFSnl628RHoCLmIFByJa+xHgvO1zIwBU19nkGQDzOFQqVfya+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clGrAsM1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clGrAsM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D62C116C6;
	Mon, 23 Feb 2026 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771851630;
	bh=uOtJDy2FyPxpMhP2bRO2gFMv/2nj4Vw849MMg7jCtgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clGrAsM1eO4t5380MKOhdLbYwfD37kNqsjhSPZfNmBaOz+46Aab5ZPI93qEZEU5nS
	 DcwHN+ArfBxcohFQnPXImXwzoJa/FHhgA0Z9jrj3wh7XDmC3M+vqCxsmgfy4RSA5tt
	 kkQBqXWtWNzYKtp35Gc+GZEl+P9QXOmoXkBRlX43RAI4LY7FuHvlHjYGeyDpC+RGBT
	 tUqkFw7eNYiDbxZ/wRx1d7LsNHhur4YAEp9jJv9TLYXDgW2OX+BkEv5rWEz9yWRU0b
	 nbhXvY0Av3j2c9EfjiEXgY8ljwW0Re4YGY8ls3P4Q9In+IRfQjjZq3NlZG1S3pcp07
	 1d/WixW1O9Mnw==
Date: Mon, 23 Feb 2026 20:41:55 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>, ardb@kernel.org,
	mark.rutland@arm.com
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 2/3] genirq: use runtime constant to optimize
 handle_arch_irq access
Message-ID: <aZxLE-wNGaEGDHGI@xhacker>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-3-jszhang@kernel.org>
 <877bs4wi0c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bs4wi0c.ffs@tglx>

On Sun, Feb 22, 2026 at 11:06:11PM +0100, Thomas Gleixner wrote:
> On Fri, Feb 20 2026 at 17:09, Jisheng Zhang wrote:
> > Currently, on GENERIC_IRQ_MULTI_HANDLER platforms, the handle_arch_irq
> > is a pointer which is set during booting, and every irq processing needs
> > to access it, so it sits in hot code path. We can use the
> > runtime constant mechanism which was introduced by Linus to speed up
> > its accessing.
> 
> The proper solution is to use a static call and update it in
> set_handle_irq().  That removes the complete indirect call issue from
> the hot path.

+ Ard, Mark,

Good idea. The remaining problem is no static call support for current
GENERIC_IRQ_MULTI_HANDLER (or similar, arm64 e.g) platforms.

For arm64, Ard tried to add the static call support[1] in 2021, but
Mark concerned "compiler could easily violate our expectations in
future"[2], and asked for static calls "critical rather than a
nice-to-have" usage.

Hi Ard, Mark,

Could this irq performance improvement be used as a "critical" usage for
arm64 static call? Per my test, about 6.5% improvement was seen on quad CA55.

Another alternative: 
disable static call if CFI is enabled, and give the platform/SoC users
chance to enable static call to benefit from it.

Any comment is appreciated.

Thanks


[1] https://www.spinics.net/lists/arm-kernel/msg931861.html

[2] https://www.spinics.net/lists/arm-kernel/msg932481.html

> 
> Thanks,
> 
>         tglx
