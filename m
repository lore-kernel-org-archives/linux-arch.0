Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271B935B655;
	Mon, 23 Feb 2026 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852313; cv=none; b=Hi/joVXllhghjw7XpIogc+f0fENmNUM9jRoTq3hZUPRzNYe3eX0hgVWdwK/QlbzKDLetNqgYG4adp5xAepPStOQpeGIXHJyjl8JqD6o8vjlgLgSKqrPxeKIzEdWLpxwWByEwaRg+PTmAPtRdn4+YAuABx6UC06M2FDnaoqTkX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852313; c=relaxed/simple;
	bh=36B/c5RxjthmwyfGCDF4pMj0LE8qAOaKBlK3Br+6Ib4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLPZpcgiwdgau8wPkgfvvZlQ8SkJhvW7vSpLHplzp3mPKzE0efzqcl9eyXZBhN0mT5jRNj8zCtP+b/+UWmapSmJu1ZAg7kcgKKdbYf5eOVCpnILU4mAjLbIVlttrN/978O4bmo2TK+PFkQVhdW06KbGqR06vfUVdERq8VSHA81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C1C2339;
	Mon, 23 Feb 2026 05:11:45 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28AA73F59E;
	Mon, 23 Feb 2026 05:11:49 -0800 (PST)
Date: Mon, 23 Feb 2026 13:11:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
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
Message-ID: <aZxSEoFkXMg18qLV@J2N7QTR9R3>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-3-jszhang@kernel.org>
 <877bs4wi0c.ffs@tglx>
 <aZxLE-wNGaEGDHGI@xhacker>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxLE-wNGaEGDHGI@xhacker>

On Mon, Feb 23, 2026 at 08:41:55PM +0800, Jisheng Zhang wrote:
> On Sun, Feb 22, 2026 at 11:06:11PM +0100, Thomas Gleixner wrote:
> > On Fri, Feb 20 2026 at 17:09, Jisheng Zhang wrote:
> > > Currently, on GENERIC_IRQ_MULTI_HANDLER platforms, the handle_arch_irq
> > > is a pointer which is set during booting, and every irq processing needs
> > > to access it, so it sits in hot code path. We can use the
> > > runtime constant mechanism which was introduced by Linus to speed up
> > > its accessing.
> > 
> > The proper solution is to use a static call and update it in
> > set_handle_irq().  That removes the complete indirect call issue from
> > the hot path.
> 
> + Ard, Mark,
> 
> Good idea. The remaining problem is no static call support for current
> GENERIC_IRQ_MULTI_HANDLER (or similar, arm64 e.g) platforms.

There are various reasons for not supporting static calls, and in
general we end up having to have a fall-back path that's *more*
expensive than just loading the pointer.

> For arm64, Ard tried to add the static call support[1] in 2021, but
> Mark concerned "compiler could easily violate our expectations in
> future"[2],

To be clear, that's ONE specific concern, not the ONLY reason.

> and asked for static calls "critical rather than a nice-to-have"
> usage.
> 
> Hi Ard, Mark,
> 
> Could this irq performance improvement be used as a "critical" usage for
> arm64 static call? Per my test, about 6.5% improvement was seen on quad CA55.

As per my other mail, does this meaningfully affect a real workload?

> Another alternative: disable static call if CFI is enabled, and give
> the platform/SoC users chance to enable static call to benefit from
> it.

Who is this actually going to matter to?

Mark.

> 
> Any comment is appreciated.
> 
> Thanks
> 
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg931861.html
> 
> [2] https://www.spinics.net/lists/arm-kernel/msg932481.html
> 
> > 
> > Thanks,
> > 
> >         tglx
> 
