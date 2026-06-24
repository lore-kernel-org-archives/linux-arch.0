Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BC3AB47A;
	Wed, 24 Jun 2026 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293502; cv=none; b=YL3j3bCcskjRPH2W1xjYboZur9TR0kGHnKKKtcOph3odW7I3tpDu9v3fEyVBVEa+JiEhxONSQ3JCt+N9boQK7o6i/ndAXpJLvaOHFkaUJgOlvxkfeJAqfSMyza4hqUDSdvpkkABXfQK+Ff820+fSwgKZWKKDy/d1kNHxiaiZKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293502; c=relaxed/simple;
	bh=LXAhiv9uMDR5KZUpJYWfBKgBStf79Ym8y8D0o9y6Ig8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1N1RqIrFi8RM8Tq69pN4Og079HQTNDdQAP5CvGBx/NBQ77/1OfRJ2o3pSA0cIji0BhxU9gm6f0oH9DvkxUIIjYFvraTIfvDPzaWbrlDw7U9vUXxUHNsj88X2DlD9pd76zd6J7Hh2901C3Xmeizl3mPBxZNGAz6AytbsQXkhSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t8/Yy0mI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t8/Yy0mI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kLqXXZs9onJoXzsYuF3jxG2RendiUVx/zExDnofxiR0=; b=t8/Yy0mI0pa8bagHbsK7o/+V4K
	9o3VIlIjZlPUrAjdJiOc8cJB1e/HL7DhchwIC5Nyjh3Bbtl24eyuCEoQqpRgtzvWY1Qjb/aW9+2DJ
	gjUuGXSv45P9/gGZJn0dl70H2Hyo8TUrz6RMjKU04grFArQ6aGa2Cdv1DXyAV9aLHfPyNACxy4KiM
	af3QQfMClBHSnMbSKdFGZlJO+zpNenFGMW+Tf0/r37nV5jNPocnNz4H6j9dtFc5WLjPwwL4Y6LPNy
	SDVHqcKB8vA0I/ktct48yI5ggDmjYOhbXxHKNPPlfmRoHBacOd8Ni1gntuz4i4CiBBfFZFqSnQJoz
	kU8O9/QA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcJwz-00000007mkC-3b66;
	Wed, 24 Jun 2026 09:31:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 67AB7300400; Wed, 24 Jun 2026 11:31:17 +0200 (CEST)
Date: Wed, 24 Jun 2026 11:31:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20260624093117.GY48970@noisy.programming.kicks-ass.net>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623142650.265721-2-bigeasy@linutronix.de>

On Tue, Jun 23, 2026 at 04:26:49PM +0200, Sebastian Andrzej Siewior wrote:

> +#ifndef WARN_ON_DEFERRED
> +#define WARN_ON_DEFERRED(condition) ({					\
> +	int __ret_warn_on = !!(condition);				\
> +	if (unlikely(__ret_warn_on)) {					\
> +		guard(preempt)();					\
> +		printk_deferred_enter()					\
> +		__WARN();						\
> +		printk_deferred_exit()					\
> +	}								\
> +	unlikely(__ret_warn_on);					\
> +})
> +#endif

This will generate atrocious shite at the WARN sites.
