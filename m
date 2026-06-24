Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC2CA52;
	Wed, 24 Jun 2026 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299015; cv=none; b=ZckWWczgMRIndvRFngkKEEaEuq/bBbfrwJt/Tms81iexvT2Mk/IeiNPMgVCqVmGD7Og0NhX3CdBu2nrNKdyJJhgRWbIFpDySDUa7pR58y1rhpkJfg4WvCjXBbEYTzHtIPXCHmbw+yq40+DXaM5J6018bsuGLPHk6XwX9SivOJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299015; c=relaxed/simple;
	bh=hUGzCg4pLTxuBArxKUQImUWhWgqWcxFVhlDSFamFQdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWpIz/iTNNFTtnPKbaAwzXTHeEk5HTTAwDiRKchSc+cJf63ZoEMOpKi9neQZLEzYMqUWcCvxotW9xqGESrWth1nSaEsjqJLW07cnpRoAhTzmE/FYvcdKmeTUsFvzBDjIlXNQmTukuPjm74VIT81zQHiwhu+V3bzgqfB412+6KZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZUNSRun/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qKouf1AV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZUNSRun/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qKouf1AV"
Date: Wed, 24 Jun 2026 13:03:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782299013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1to4aN27mXUg6e3//FhiOnDtrnDrsfOW2HNyWBwR80g=;
	b=ZUNSRun/KgPTj+yok/k3XNRhYqfDg34NbQWQximnyMtK4oj2KJOqTTSt/56peOhiLoVFAP
	BD2C7/hs+paMj1uketRIKjHkCl0bGy9hRONm/u3q9kpQDQJvV5INYZREMeL3ui3/jYjvbm
	bKOu/VDZhvqdvRp8AT8LrBdN/oXPsbQ0gc30pYfWoXdjhBpkvT9X4ykaUGp7+IugGzJGGZ
	e5iKB/Kj0cMqyceBtGBbq1KY3V0L1YKm6quKw4J5rDKTkhLgvT4jKj1G91dCeGDjW406h0
	sr19aOPa9smhnOdWM9BJYeuH2Jl5gAPSXgVtkPVuRbAgfOnsYVM59B/AeT3iww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782299013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1to4aN27mXUg6e3//FhiOnDtrnDrsfOW2HNyWBwR80g=;
	b=qKouf1AVMwkpseA87WaquDtq2H4f8a+je/52pZlZYEG5kcBNKEzU3NkoVOEsrFDuQ61fWx
	+3BxS7ihbWvAh3BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Breno Leitao <leitao@debian.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <20260624110331.iHt4U2xo@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <ajuWnKsQR0Z825Wn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajuWnKsQR0Z825Wn@gmail.com>

On 2026-06-24 01:37:53 [-0700], Breno Leitao wrote:
Hi Breno,

> Have you considered an approach similar to printk_deferred_enter(),
> where you mark the code region that needs deferral and all WARN() calls
> within that region are automatically deferred?

Doing this at rq-lock site is not something the scheduler department
takes. It increases/ bloats the code sides more than what we have now.

Not everything is in __sched section so we can't check for this from
within printk. So this turd was the only idea I had.

> The current proposal requires changing individual WARN() call sites,
> but whether they need deferral might depend on the calling context. This
> means you'd need to convert many call sites and ensure all nested
> warnings are also converted to the deferred variant.

I hope for the forced-threaded-legacy the default but this camp has not
a lot members. It would increase the pressure to provide nbcon so it
could be a good thing.

To accept this series and make it more bullet-proof we could do
s/WARN_ON\>/WARN_ON_DEFERRED/ for all sched/ and require it regardless
if the rq-lock is held. So you wouldn't have to audit it each and every
time. Due to that preempt-disable thingy it can be used in preemptible
sections without breaking anything.

> 
> Thanks,
> --breno

Sebastian
