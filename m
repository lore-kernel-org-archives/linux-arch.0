Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0313D891;
	Mon, 23 Feb 2026 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838154; cv=none; b=UrG//AVgasHwMznC9GOOTzJMXDGzSVJM2WbsZLS/hyvGP8nMOCq1xR/vMvgyqKHcYU7j0XE80PdIYOSgWlEs58M79I+l/2ngOIrT7Kqs7wlfAokMAIcrFXIZOJqbmYpzSFEbLiKggaTRjEV5Yr0Mnu3FQwXTXpmr7stmYpqsRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838154; c=relaxed/simple;
	bh=6udqOftI4y08g8IexuZmqUZ6jWyjJMTADJKWbvH4DqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrygEw1yE0KVG6oBU34atxaAlvCrTE2pJm60IQk2DUbTtC9nWh6BXkYjeEK7RsQMqFa93/jx41aiGcNhqDGqXqEjaokebuAGTrsY/c1RCrmWNMsJ7YOlKVkQZwwKe9HywBg24LyajPGsOjGYcZJV4Q6xvPTYEsqkLg/QifFvM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04162339;
	Mon, 23 Feb 2026 01:15:44 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D54243F62B;
	Mon, 23 Feb 2026 01:15:49 -0800 (PST)
Date: Mon, 23 Feb 2026 09:15:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
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
Message-ID: <20260223091547.GJ136967@e132581.arm.com>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-4-jszhang@kernel.org>
 <20260220123414.GF136967@e132581.arm.com>
 <aZheqINXslxlrmTt@xhacker>
 <aZhi1p0NJH5ug8CA@xhacker>
 <20260220164738.GH136967@e132581.arm.com>
 <aZj42cyIHADECszW@xhacker>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZj42cyIHADECszW@xhacker>

On Sat, Feb 21, 2026 at 08:14:17AM +0800, Jisheng Zhang wrote:

[...]

> On Fri, Feb 20, 2026 at 04:47:38PM +0000, Leo Yan wrote:
> > On Fri, Feb 20, 2026 at 09:34:14PM +0800, Jisheng Zhang wrote:
> > 
> > [...]
> > 
> > > > > Run 3 iterations, and measures three metrics (messaging/pipe/seccomp)
> > > > > and results in seconds. Less is better.
> > > > > 
> > > > >   +---------------------+--------+--------+--------+--------+
> > > > >   |Without change       |   run1 |   run2 |   run3 |    avg |
> > > > >   +---------------------+--------+--------+--------+--------+
> > > > >   |messaging (sec)      |  4.546 |  4.508 |  4.591 |  4.548 |
> > > > >   |pipe (sec)           | 24.258 | 24.224 | 24.017 | 24.166 |
> > > > >   |seccomp-notify (sec) | 48.393 | 48.457 | 48.232 | 48.361 |
> > > > >   +---------------------+--------+--------+--------+--------+
> > > > > 
> > > > >   +---------------------+--------+--------+--------+--------+--------+
> > > > >   |With change          |   run1 |   run2 |   run3 |    avg |   diff |
> > > > >   +---------------------+--------+--------+--------+--------+--------+
> > > > >   |messaging (sec)      |  4.493 |  4.523 |  4.556 |  4.524 | +0.52% |
> > > > >   |pipe (sec)           | 23.159 | 23.702 | 28.649 | 25.170 | -4.15% |
> > > > 
> > > > If you check the result, this result variance is abnormal, it means
> > > > your OS is noiser.
> > > 
> > > BTW: if you remove the abnormal run3 result, you'll find that the
> > > benchmark is improved by ~3.5% on CA73:
> > > (23.159 + 23.702) / 2 = 23.43
> > > (24.258 + 24.224) / 2 = 24.24
> > > (24.24 - 23.43)*100 / 23.43 = ~3.5
> > 
> > TBH, I don't think we should subjectively select data.  But I agree a
> 
> The precondition of this is testing the benchmark properly. And I just
> tried perf bench sched in noisy OS, I didn't get the similar abnormal
> variance as you got, so I think your run3 result was CA53's result.
> This isn't an apple-to-apple comparison.

Not true.  As said, I tested on CA73.  I should say explicitly that I
have hotplugged off CA53 CPUs and run test only on CA73 CPUs.

> If possible, could you plz test after forcing CA53 offline or test on
> non big.little platform. Anyway, I will test CA73 next week too.
> 
> > clean test env is important to avoid noise, and I also agree that the
> > current results already show positive signals.
> > 
> > Thanks,
> > Leo
