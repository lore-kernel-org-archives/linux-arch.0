Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7420221540;
	Mon, 23 Feb 2026 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854080; cv=none; b=k+uAXhwrEKi/1P9wu35KtAiIV0slZuS4UhZgjZC3WsaBP1w06H3PRS+hH0qLXhNVnnKjErnobBPEvcUT1wHppTYgvFvZSCXTefufLgNfUNPzLTmwlanC1BZ9Y4b5tLtoK9pK+o+kWdB6OVc9vsoo0w9HxyuKnwOgeUfS7Nvv/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854080; c=relaxed/simple;
	bh=G4xM/SndGrcKzoMti1IbjGgUXMX7iGWpd7VzF1HsCkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNkgfwEQSkb3QSsyxHj6Uf81xvmq+8I5vOi919pS/ejEXyR5tcIKTkfNreW1ijgzg8mL4s+BKx6MNc0oKjdVDKm3smjVP4xuzQzbO8L72ZtDmX4TAp4YbEZn3IQfd36NuEYen8CpHTKz8affV5XhdQKlqPPP64PFN2J2kGW3zzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quWJDzXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quWJDzXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA27C116C6;
	Mon, 23 Feb 2026 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771854079;
	bh=G4xM/SndGrcKzoMti1IbjGgUXMX7iGWpd7VzF1HsCkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quWJDzXDfK47UBN+js1H5DHlQFCyUPIGriWbWe90osVL2fapOYnlgi+UPZu7eq/bl
	 4i5ThdsOz1/+WuVGxLqMCKltbhgHt7bjxI7sUmKGsMAE3dzcEKdJqvO8Azz1CY32Mj
	 TWaHh4cZbW48qFYjP1vYjWws7K1UNdsdNPpBESXnFynEzf8V9zjoRqcM6iLSsnrLWd
	 8pLsXdKf2ubyGcvpCIe3JfqRteKH4DC3HW+obTzhsv13AN0N/EBxMm85fUuodbA2vK
	 9/qxJThq5lNjp9V1zLbkm49fcoyvl4WOkBCsux0bzb3c1IMO0n72oozYaJbKy5bPYu
	 6u6uYvFxT927A==
Date: Mon, 23 Feb 2026 21:22:44 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, ardb@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 2/3] genirq: use runtime constant to optimize
 handle_arch_irq access
Message-ID: <aZxUpATkNI5_PbNl@xhacker>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-3-jszhang@kernel.org>
 <877bs4wi0c.ffs@tglx>
 <aZxLE-wNGaEGDHGI@xhacker>
 <aZxSEoFkXMg18qLV@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZxSEoFkXMg18qLV@J2N7QTR9R3>

On Mon, Feb 23, 2026 at 01:11:46PM +0000, Mark Rutland wrote:
> On Mon, Feb 23, 2026 at 08:41:55PM +0800, Jisheng Zhang wrote:
> > On Sun, Feb 22, 2026 at 11:06:11PM +0100, Thomas Gleixner wrote:
> > > On Fri, Feb 20 2026 at 17:09, Jisheng Zhang wrote:
> > > > Currently, on GENERIC_IRQ_MULTI_HANDLER platforms, the handle_arch_irq
> > > > is a pointer which is set during booting, and every irq processing needs
> > > > to access it, so it sits in hot code path. We can use the
> > > > runtime constant mechanism which was introduced by Linus to speed up
> > > > its accessing.
> > > 
> > > The proper solution is to use a static call and update it in
> > > set_handle_irq().  That removes the complete indirect call issue from
> > > the hot path.
> > 
> > + Ard, Mark,
> > 
> > Good idea. The remaining problem is no static call support for current
> > GENERIC_IRQ_MULTI_HANDLER (or similar, arm64 e.g) platforms.
> 
> There are various reasons for not supporting static calls, and in
> general we end up having to have a fall-back path that's *more*
> expensive than just loading the pointer.

indeed, if arch doesn't support static call, the fall-back addes one
more loading overhead.

> 
> > For arm64, Ard tried to add the static call support[1] in 2021, but
> > Mark concerned "compiler could easily violate our expectations in
> > future"[2],
> 
> To be clear, that's ONE specific concern, not the ONLY reason.
> 
> > and asked for static calls "critical rather than a nice-to-have"
> > usage.
> > 
> > Hi Ard, Mark,
> > 
> > Could this irq performance improvement be used as a "critical" usage for
> > arm64 static call? Per my test, about 6.5% improvement was seen on quad CA55.
> 
> As per my other mail, does this meaningfully affect a real workload?

This improves generic irq processcing, I think all real workload is affected.

> 
> > Another alternative: disable static call if CFI is enabled, and give
> > the platform/SoC users chance to enable static call to benefit from
> > it.
> 
> Who is this actually going to matter to?
> 
