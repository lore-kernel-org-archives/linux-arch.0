Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16D395D99;
	Wed, 25 Feb 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031516; cv=none; b=WgxCqZ+UTb30C3V4M+MJSSaeaFb2/QDdcKxtaCfoDF8YTJdRVCwBcYOJ+0xVg4C0d38yxi5aKoSfbWHQoBvQn/mSaYTuvPSPCdQaEVk/AZsMzDjcHOYX32zWbaYMsJYlFsn+tazbuvjHiw9wDeGPQH1nuB3tMirWdwr0qqfbgH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031516; c=relaxed/simple;
	bh=DKswOemgE0o8dLAbtbgTdWvG4rdX6n55NSS0972JIdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVjEExkC1Kdkl35Vbei9SgBXHDAXV9b8s/mGYx8rV8Bp3Mw2xtQwN0z/qg0SxmeG+3pHbDMNC6eWOHHTASsV+mKSkJ+mpvUQLvbua2u+mB7C6avEhm39yZ7nlDeL0NfWJB1gNsJA0dVjBRB4e35ZcG6fnx2HwmxHLeh1Y2oRzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdh6iujj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdh6iujj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910B6C116D0;
	Wed, 25 Feb 2026 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772031516;
	bh=DKswOemgE0o8dLAbtbgTdWvG4rdX6n55NSS0972JIdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mdh6iujjSWp6SFz+JwLy4nalaRpHoytaT2mXrTErJdY8ripQ/GKKYsH1b4yAf+HN4
	 bt2suB/55pPPBWFpqHeD5Wf39lqMh8j/eCfpQ/7ZSOTdklaPGnXI+6N/ciFXt5w7l6
	 K+AkIiooofhvA2kywZtHdb++EyS59f+F8KnRSR+E2QCR71eqiPfOz0zxuodScZsQkH
	 wYrCJuQhJlMi/x81lK+QlxaMf2EwoNJ8O50o9wHLMBYStJitsqpCEgdFsRfVcbwA/O
	 5uR2Pq84gRkLCyKcI0lNk99ypfPbGi9rQ6KJc5K/xZf00J+9lmkqkfdjqbP46f6P3S
	 IsjdrQZRFnTNA==
Date: Wed, 25 Feb 2026 22:40:00 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: use runtime constant to optimize
 handle_arch_irq access
Message-ID: <aZ8JwB2vJ98uab2V@xhacker>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-4-jszhang@kernel.org>
 <20260220123414.GF136967@e132581.arm.com>
 <aZheqINXslxlrmTt@xhacker>
 <aZhi1p0NJH5ug8CA@xhacker>
 <20260220164738.GH136967@e132581.arm.com>
 <aZj42cyIHADECszW@xhacker>
 <20260223091547.GJ136967@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223091547.GJ136967@e132581.arm.com>

On Mon, Feb 23, 2026 at 09:15:47AM +0000, Leo Yan wrote:
> On Sat, Feb 21, 2026 at 08:14:17AM +0800, Jisheng Zhang wrote:
> 
> [...]
> 
> > On Fri, Feb 20, 2026 at 04:47:38PM +0000, Leo Yan wrote:
> > > On Fri, Feb 20, 2026 at 09:34:14PM +0800, Jisheng Zhang wrote:
> > > 
> > > [...]
> > > 
> > > > > > Run 3 iterations, and measures three metrics (messaging/pipe/seccomp)
> > > > > > and results in seconds. Less is better.
> > > > > > 
> > > > > >   +---------------------+--------+--------+--------+--------+
> > > > > >   |Without change       |   run1 |   run2 |   run3 |    avg |
> > > > > >   +---------------------+--------+--------+--------+--------+
> > > > > >   |messaging (sec)      |  4.546 |  4.508 |  4.591 |  4.548 |
> > > > > >   |pipe (sec)           | 24.258 | 24.224 | 24.017 | 24.166 |
> > > > > >   |seccomp-notify (sec) | 48.393 | 48.457 | 48.232 | 48.361 |
> > > > > >   +---------------------+--------+--------+--------+--------+
> > > > > > 
> > > > > >   +---------------------+--------+--------+--------+--------+--------+
> > > > > >   |With change          |   run1 |   run2 |   run3 |    avg |   diff |
> > > > > >   +---------------------+--------+--------+--------+--------+--------+
> > > > > >   |messaging (sec)      |  4.493 |  4.523 |  4.556 |  4.524 | +0.52% |
> > > > > >   |pipe (sec)           | 23.159 | 23.702 | 28.649 | 25.170 | -4.15% |
> > > > > 
> > > > > If you check the result, this result variance is abnormal, it means
> > > > > your OS is noiser.
> > > > 
> > > > BTW: if you remove the abnormal run3 result, you'll find that the
> > > > benchmark is improved by ~3.5% on CA73:
> > > > (23.159 + 23.702) / 2 = 23.43
> > > > (24.258 + 24.224) / 2 = 24.24
> > > > (24.24 - 23.43)*100 / 23.43 = ~3.5
> > > 
> > > TBH, I don't think we should subjectively select data.  But I agree a
> > 
> > The precondition of this is testing the benchmark properly. And I just
> > tried perf bench sched in noisy OS, I didn't get the similar abnormal
> > variance as you got, so I think your run3 result was CA53's result.
> > This isn't an apple-to-apple comparison.
> 
> Not true.  As said, I tested on CA73.  I should say explicitly that I
> have hotplugged off CA53 CPUs and run test only on CA73 CPUs.

I tested on quad CA73 platform, I can reproduce the abnormal variance
as you got. This means the series may not alway improve performance
as I expected for *all* CPUs. So I'd like to drop it now.

> 
> > If possible, could you plz test after forcing CA53 offline or test on
> > non big.little platform. Anyway, I will test CA73 next week too.
> > 
> > > clean test env is important to avoid noise, and I also agree that the
> > > current results already show positive signals.
> > > 
> > > Thanks,
> > > Leo
