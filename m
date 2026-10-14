Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A725304BC;
	Wed, 14 Oct 2026 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991408; cv=none; b=AK6IMgLSj1jYya+g41D6shXH+CpRdnVUg3rDKzNryQcgUy/uXP7zFhlQi3FOvLJVyW5p6JnedxSG9SVdbzpCnT6YdvOC7jH20+gTwlZGuOTNyxR1qXqZSq74R2jwX+uJZ6yCyiBg66S136pYDBA1rxg+Ti7dPB3TDlRAGWW9TKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991408; c=relaxed/simple;
	bh=1DLWRMbZyOAA0rVioqQfDUzvKGaVa837pvjO2TrdaZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcSfQgzxsLW1PSZnjoH0/kWxsj3Qt97LTXL9FgNd9H35WNX1srb+Clm+PqkzWUEJMwzRq5A/6tbtmaw58da1Oweo7Eio1SobBDkR7APJCNJN9bRLzWQzV6kABiCLTc13rh0wvBu2QWDvxBIjpXwszVQQ/6/7fPQww2jfyQUoArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BiwEjp9u; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BiwEjp9u"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF9B61570;
	Wed, 14 Oct 2026 08:23:21 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32C683F7B4;
	Wed, 14 Oct 2026 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791991405; bh=1DLWRMbZyOAA0rVioqQfDUzvKGaVa837pvjO2TrdaZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BiwEjp9uaNUxIi5ciO5EDAG5qEO3ENWk/lYMARr7Uggqz/ut2q3CTw8kTspOFi1zo
	 lHQZGmwZP0ZENsvMT+FmZV5rbyvIcKrLhkmCA8C0J04SvgcNDM5XXlrPenFvd6Mrkj
	 BUk3lDOPxmpqk7uJw7yqDFTdYVgi5JOvXJrteTiw=
Date: Wed, 14 Oct 2026 16:23:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Haris Okanovic <harisokn@amazon.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
	will@kernel.org, akpm@linux-foundation.org, mark.rutland@arm.com,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, rdunlap@infradead.org,
	david.laight.linux@gmail.com, broonie@kernel.org,
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Message-ID: <as-eaNfjOAUnfvVF@arm.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
 <178908146776.2725577.2613699832033292946.b4-review@b4>
 <878q58z2ej.fsf@oracle.com>
 <3e8bda45-0aa7-d0be-8aad-dab95902dcde@gentwo.org>
 <as9EospGcR2e1mpO@arm.com>
 <20261014130306.GK2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014130306.GK2009045@noisy.programming.kicks-ass.net>

On Wed, Oct 14, 2026 at 03:03:06PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 14, 2026 at 10:00:18AM +0100, Catalin Marinas wrote:
> > It
> > would also be nice to get some acks from the atomic infrastructure
> > maintainers.
> 
> That'd be Mark and me I suppose. I don't see anything substantial
> happening, just plumbing the new function.

Thanks!

> Now, I really rather dislike timeout based schemes, but given we have
> users, I suppose this does improve things. We should however be weary of
> new ones I suppose.

There's some arm64 precedent in commit ebababcd0372 ("rqspinlock:
Hardcode cond_acquire loops for arm64"). This one went in without any of
the arm64 maintainers' ack and we've since been trying to come up with a
generic interface instead of reverting it. It was fixing a bug where
arm64 smp_cond_load_acquire() does not evaluate cond_expr unless the
pointer is also written by another CPU. Arguably the bug was in the
rqspinlock code for not using a plain cpu_relax() loop.

Anyway, we had several incarnations of this series, some with a default
timeout but others objected to it (Arnd and Rafael IIRC), hence the
proposal here that pleased most people (not all though ;)).

-- 
Catalin
