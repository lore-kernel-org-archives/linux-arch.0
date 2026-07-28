Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2476384CD1;
	Tue, 28 Jul 2026 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238626; cv=none; b=HvkgbqFtRGudHIv7G+A75HsjpgHmSJ1JbLariHN0p2cXMW6rREEjI+s0QlOpfJXRuTQ16cPzJC1sr88cWBw4T4L9uVOF300szya78h+7J539PFB2ZhmkYyWIyhMIuS5L0VrPv040tv7c7bgHwLtmgJZk0Af6YIzFeW5lacvGiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238626; c=relaxed/simple;
	bh=IxbkiICINpIlbDNUAthBMdx95fky4s/jns4BcyOTCLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA/XtPMpSiRALrC/c/+amzg48vIfoPHPnkMpNDfrLnIz7Ji+LaCxJ8cuQtQzwyDGbavgXWaxNA3bWBh2OJcEY+ujAmaAkkLXx9tiUctw/tMYzqfsvXe8rWymwtF/WS1/YqbodZo7bYzhz0a/OT7wIJLV//k7RzqT+4MHG85PzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANlo7dNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANlo7dNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6222D1F000E9;
	Tue, 28 Jul 2026 11:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238625;
	bh=tR8EcFnGl3J8Tt2kJltOV9Wd4bMYRmU1WDMYbhcN7oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ANlo7dNE9fx5EO7d+BCxaihNg39CXQ7/a7TpyVtZ8cbCA/UwFdSxf6ZYFLdb+B2Fd
	 u4MlYY7ycrHRPrToNH5PX8TNP6Tip6zoIq2cybB0ZJt0I0B4hDvBM3TpFiLJkou0yX
	 kwzbX4my2TwaNHHdxEtqfkhE1BxdECWVEq2c+xZQLbqnRtOObtiHxBqzbUbywZw/FK
	 5N86OhZFHsPdGp00q35w7WjkZku9aD7vmstfE/sFlK2bWJXw6Nkj0Bv4lmbXUOtOBu
	 6sjoxoynf1CvdOvGDlY2JNZmTGMZga7gguD0xrs0pb9O5hn30LqfmQ2JU1kj5v8ucF
	 k60sAyRo++BtQ==
Date: Tue, 28 Jul 2026 12:36:58 +0100
From: Will Deacon <will@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
	peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, rdunlap@infradead.org,
	david.laight.linux@gmail.com, broonie@kernel.org,
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v14 13/15] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
Message-ID: <amiUWpsL1QGf929i@willie-the-truck>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-14-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714073041.40250-14-ankur.a.arora@oracle.com>

Hello, Ankur,

On Tue, Jul 14, 2026 at 12:30:39AM -0700, Ankur Arora wrote:
> This enables the barrier tests to be built as a module.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  arch/arm64/lib/delay.c               | 2 ++
>  drivers/clocksource/arm_arch_timer.c | 2 ++
>  2 files changed, 4 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

I think this is looking good from the arm64 side now (and appears to have
all the relevant Acks). What's the plan to get this series merged?

Will
