Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319752405EB;
	Mon, 23 Feb 2026 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854939; cv=none; b=MDnhlqk2sWFG44612U5zxv6LaYh1U8kPthz74FRc1rZ+cDol9vIymlvloJ7DAiEx5ccRVnFpYMXhaTqNlfRi85MLnC19c0cxE4iOHIHNeQkAPlX0lq4rJSP54qgfdB8hsJVbrN6q5Sq6Z9jxMzVgFO02K50CIO9yD4MeKMNEQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854939; c=relaxed/simple;
	bh=MUqyyDuyROPgCYq4PEnQ/dMUcpdsYiJuqSkUTV/wa9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOvVWVoNonV7vKH9VKwKUuQVOZaxgQHDhbejc1Y+gg4e/gTfO6UOg9bbqx7PxtzT51UoP10YPlP88VRCbrbhErbQ3bUaoXaHalCWZwl+Yn2mrKRXJGoqTe/M4gLGw6554zEw1FcHKr+IYAf1mt8LOIR/kAJcPSSh0fJsf65Yw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E6F6339;
	Mon, 23 Feb 2026 05:55:31 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240543F59E;
	Mon, 23 Feb 2026 05:55:35 -0800 (PST)
Date: Mon, 23 Feb 2026 13:55:32 +0000
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
Message-ID: <aZxcVGr47wYM--nr@J2N7QTR9R3>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-3-jszhang@kernel.org>
 <877bs4wi0c.ffs@tglx>
 <aZxLE-wNGaEGDHGI@xhacker>
 <aZxSEoFkXMg18qLV@J2N7QTR9R3>
 <aZxUpATkNI5_PbNl@xhacker>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxUpATkNI5_PbNl@xhacker>

On Mon, Feb 23, 2026 at 09:22:44PM +0800, Jisheng Zhang wrote:
> On Mon, Feb 23, 2026 at 01:11:46PM +0000, Mark Rutland wrote:
> > There are various reasons for not supporting static calls, and in
> > general we end up having to have a fall-back path that's *more*
> > expensive than just loading the pointer.
> 
> indeed, if arch doesn't support static call, the fall-back addes one
> more loading overhead.

I think you've misunderstood my point.

I'm saying that *even if* arm64 supported static calls, we'd have to
have dynamic fallback paths that are more expensive. For example, where
branch range limitations force indirection via an out-of-line stub,
adding an extra BL+RET pair. Note that was the case in the patches you
linked from Ard.

[...]

> > > and asked for static calls "critical rather than a nice-to-have"
> > > usage.
> > > 
> > > Hi Ard, Mark,
> > > 
> > > Could this irq performance improvement be used as a "critical" usage for
> > > arm64 static call? Per my test, about 6.5% improvement was seen on quad CA55.
> > 
> > As per my other mail, does this meaningfully affect a real workload?
> 
> This improves generic irq processcing, I think all real workload is affected.

I asked about meaningful impact. For a real workload, does this show up
at all, or does this fall within the noise?

At present, I don't think your singular microbenchmark result changes
our previous decisions regarding static calls. For various reasons, on
arm64 static calls are nowhere near as significant an optimization (and
can be worse).

I'd be happy to use a runtime constant (modulo my concerns about the
initial value) given that the we already have the infrastructure and the
maintenanace impact is minimal.

Mark.
