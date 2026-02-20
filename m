Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DE221FCD;
	Fri, 20 Feb 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606062; cv=none; b=YN9IwJjclFhEPbTOryC+zgxcavmqYeevQZv7OB/Wz7mN9RmVbVjRBFSXEFk1o73lTFgWMETu+O/zEM/sVsiSluuROqBrDmjt95DLALU89hhUqekcip/t5tIxjjNr+jZZVUYoxwDJghyM9UIXPBiJturF2ZqL+2ZQTTUym0svMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606062; c=relaxed/simple;
	bh=fdZT2EuWOSNtQ/ikYUtpmLQSIkQ5edy+knz/3z/tq8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVKRd4DYRAIJBpjs8uwZODfTbiJ+PHlvD9X/qEVFAsBZ9v7H3p1Pr11h7rbarPgms0DF8JlZ6m1q7dIFYQ32aDgTXxGZoqnt18ghxyf1/H3F62Kn/K/lnJrqM50WZaxtp4yPWSw2K3ni18ZbnRlJ86gAmlvJ+EvwdosjQhBsM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542A4339;
	Fri, 20 Feb 2026 08:47:34 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DEE53F62B;
	Fri, 20 Feb 2026 08:47:40 -0800 (PST)
Date: Fri, 20 Feb 2026 16:47:38 +0000
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
Message-ID: <20260220164738.GH136967@e132581.arm.com>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-4-jszhang@kernel.org>
 <20260220123414.GF136967@e132581.arm.com>
 <aZheqINXslxlrmTt@xhacker>
 <aZhi1p0NJH5ug8CA@xhacker>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZhi1p0NJH5ug8CA@xhacker>

On Fri, Feb 20, 2026 at 09:34:14PM +0800, Jisheng Zhang wrote:

[...]

> > > Run 3 iterations, and measures three metrics (messaging/pipe/seccomp)
> > > and results in seconds. Less is better.
> > > 
> > >   +---------------------+--------+--------+--------+--------+
> > >   |Without change       |   run1 |   run2 |   run3 |    avg |
> > >   +---------------------+--------+--------+--------+--------+
> > >   |messaging (sec)      |  4.546 |  4.508 |  4.591 |  4.548 |
> > >   |pipe (sec)           | 24.258 | 24.224 | 24.017 | 24.166 |
> > >   |seccomp-notify (sec) | 48.393 | 48.457 | 48.232 | 48.361 |
> > >   +---------------------+--------+--------+--------+--------+
> > > 
> > >   +---------------------+--------+--------+--------+--------+--------+
> > >   |With change          |   run1 |   run2 |   run3 |    avg |   diff |
> > >   +---------------------+--------+--------+--------+--------+--------+
> > >   |messaging (sec)      |  4.493 |  4.523 |  4.556 |  4.524 | +0.52% |
> > >   |pipe (sec)           | 23.159 | 23.702 | 28.649 | 25.170 | -4.15% |
> > 
> > If you check the result, this result variance is abnormal, it means
> > your OS is noiser.
> 
> BTW: if you remove the abnormal run3 result, you'll find that the
> benchmark is improved by ~3.5% on CA73:
> (23.159 + 23.702) / 2 = 23.43
> (24.258 + 24.224) / 2 = 24.24
> (24.24 - 23.43)*100 / 23.43 = ~3.5

TBH, I don't think we should subjectively select data.  But I agree a
clean test env is important to avoid noise, and I also agree that the
current results already show positive signals.

Thanks,
Leo
