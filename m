Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9013B71C6;
	Wed, 24 Jun 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295726; cv=none; b=RMsRIH0oUbty6/bTyrP3BblKQWjhVn96yd6ejaqHppnb1JgUlPUQBiUmumqltzQ01zmDczhpFDtd6B9vQZalwWf1qPO+4g2iDYsGeYLPmkeWW+MlDosI2FGRylxvUnnngFcFPjNQ361VGCaBmA//venLUnY9N7/DCvO+ZMrnbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295726; c=relaxed/simple;
	bh=Zgq0HceP4qnVEiXOOc7bhS8RStlam2Jmor0wsOciRiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZwf3vGEcCxMNjkrUhPm5A0pDw+vtyPn0sGVVtBq77MOoGOUa6+2ZYa6u6YYy/jsm3ZRXtTX9evWaKBvULd8/1OmOnDCiqwaj8N3RivLBoypbgFYXPoiL1jkaG8XNm6tyRPxSG3QLJKyx9DxCxX26uCIbSZYSm33wfEk8MXNEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ie+Gx05T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ObC5D9bb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ie+Gx05T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ObC5D9bb"
Date: Wed, 24 Jun 2026 12:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782295722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn0h6VOL/cdoKYPxSepbduPQBw6kBDF1WxhF/z0UW7Y=;
	b=Ie+Gx05T8M23x7bJzrMK2MWptU0vHip0oyTQvuPFUgWsDKpCmZksVEcVfnxxA6d/PQLScl
	rI45s4KZMsDfMRY8ysL3w9fRA/NtG7VK+g6I1xz3/gMLJttFFL2WFnXXUV8/YJTe8thBQY
	Qf5y4rRLeauo/kJaUBrjHulczdTlHum1Pjyu9d1ikel9LA9G9pqns+8gi5gfkDw/0fPW+p
	HAOBcDvlaw0j/brtNJ/63ueQ4HHzgcBIY7sztfCfVmK/HMSmgbrSONvH5mf4267F9Vl+Jv
	ZtKzYWIAQK8vuJRTynGfqP/W/wIX2uqXhNg13ZzoUKWh2zio38ymGp9tbDVb0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782295722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn0h6VOL/cdoKYPxSepbduPQBw6kBDF1WxhF/z0UW7Y=;
	b=ObC5D9bbUWMoq2zqZJkHwNc6RZ8DTjjcUpKSr3VjK2xHvs0BzkFlm3YAJYg/fJF7Ba6atC
	0iZH/dKSumbrHwDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <20260624100839.XS5R23mk@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <20260624093117.GY48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624093117.GY48970@noisy.programming.kicks-ass.net>

On 2026-06-24 11:31:17 [+0200], Peter Zijlstra wrote:
> On Tue, Jun 23, 2026 at 04:26:49PM +0200, Sebastian Andrzej Siewior wrote:
> 
> > +#ifndef WARN_ON_DEFERRED
> > +#define WARN_ON_DEFERRED(condition) ({					\
> > +	int __ret_warn_on = !!(condition);				\
> > +	if (unlikely(__ret_warn_on)) {					\
> > +		guard(preempt)();					\
> > +		printk_deferred_enter()					\
> > +		__WARN();						\
> > +		printk_deferred_exit()					\
> > +	}								\
> > +	unlikely(__ret_warn_on);					\
> > +})
> > +#endif
> 
> This will generate atrocious shite at the WARN sites.

You mean the missing semicolon and huge size increase?
On x86 with these guard+deffered in the upper variant, before:
    text    data     bss     dec   filename
   93910   37424     832  132166   kernel/sched/core.o
   61802    4945     152   66899   kernel/sched/fair.o
  215108   24453    3768  243329   kernel/sched/build_policy.o
   86128   30092   12704  128924   kernel/sched/build_utility.o
  456948   96914   17456  571318   total
After:
   96140   37408     832  134380   kernel/sched/core.o
   64490    4937     152   69579   kernel/sched/fair.o
  222980   24157    3768  250905   kernel/sched/build_policy.o
   86544   30100   12704  129348   kernel/sched/build_utility.o
  470154   96602   17456  584212   total + 1.3%

total went up by 1.3% or 12.59KiB.
This effects:  alpha, arc, arm, csky, hexagon, m68k, microblaze, mips,
nios2, openrisc, sparc, um, xtensa
and could motivate them to implement __WARN_FLAGS which would lower size
in general and this stunt would have no effect.

Just looked at arm and it has support for invalid opcodes somehow but
not for this.

Sebastian
