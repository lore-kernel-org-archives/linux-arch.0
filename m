Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD033F8C7;
	Fri, 20 Feb 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590860; cv=none; b=FmLWqY+Gqx0BDBg4Sf90BhpsmLcQjiiLR5vPtt3sXi7loWS57ol0yqI26Dli199AbtBINiWsRAAshKlDVOJMstrE29Vc9i7Kut/NBnnecyhkOBAdXCjGxsfR8B5ZtCTh/LYRr3dKHKX2pdjpgjBB/iM7Vk7spVs0IoAvSfpWUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590860; c=relaxed/simple;
	bh=KAZwEbjwCWpM69PmGYgz9CiXHIrMnTAbgB16BaijiKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV6IYyVglibtPZ2LsN2Dchdpe9HPhdutheMKHPbD0Og4bwcwHvin2MH3NpgayzBA03AYGmV4KyJc+bu1nxG5PiHZXkG9o8jt0uCRx+MVNc1HjZ9zqmcPJHmETENKb0MAzCxNfLmEGxwb8tyJgpa6NmZoC/F+nJ2HrMvMp/qMjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65805339;
	Fri, 20 Feb 2026 04:34:10 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B0F3F62B;
	Fri, 20 Feb 2026 04:34:16 -0800 (PST)
Date: Fri, 20 Feb 2026 12:34:14 +0000
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
Message-ID: <20260220123414.GF136967@e132581.arm.com>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220090922.1506-4-jszhang@kernel.org>

Hi Jisheng,

On Fri, Feb 20, 2026 at 05:09:22PM +0800, Jisheng Zhang wrote:
> Currently, on arm64 platforms, the handle_arch_irq is a pointer which
> is set during booting, and every irq processing needs to access it,
> so it sits in hot code path. We can use the runtime constant mechanism
> which was introduced by Linus to speed up its accessing.
> 
> Tested on Quad CA55 platform, the perf sched benchmark is improved
> by ~6.5%

6.5% is a quite high margin, especially for only one pointer's change.
Maybe it is good to share more info for which compiler you are using,
how you tested and the detailed results.

I played a bit on my juno board on CA73 cores with the command:

  perf bench sched all

Run 3 iterations, and measures three metrics (messaging/pipe/seccomp)
and results in seconds. Less is better.

  +---------------------+--------+--------+--------+--------+
  |Without change       |   run1 |   run2 |   run3 |    avg |
  +---------------------+--------+--------+--------+--------+
  |messaging (sec)      |  4.546 |  4.508 |  4.591 |  4.548 |
  |pipe (sec)           | 24.258 | 24.224 | 24.017 | 24.166 |
  |seccomp-notify (sec) | 48.393 | 48.457 | 48.232 | 48.361 |
  +---------------------+--------+--------+--------+--------+

  +---------------------+--------+--------+--------+--------+--------+
  |With change          |   run1 |   run2 |   run3 |    avg |   diff |
  +---------------------+--------+--------+--------+--------+--------+
  |messaging (sec)      |  4.493 |  4.523 |  4.556 |  4.524 | +0.52% |
  |pipe (sec)           | 23.159 | 23.702 | 28.649 | 25.170 | -4.15% |
  |seccomp-notify (sec) | 46.848 | 46.938 | 46.973 | 46.920 | +2.98% |
  +---------------------+--------+--------+--------+--------+--------+

With this patch, the messaging test shows a minor improvement (0.52%).

The pipe test performs worse (-4.15%) after applying the patch. However,
one positive signal is that the minimum latency is 23.159, which is
lower than without the change (24.017).

For seccomp, the results indicate a benefit (2.98%) from the change.

Hope this is helpful for maintainers to judge the change.

I'd leave maintainers to review the code.

Thanks,
Leo
