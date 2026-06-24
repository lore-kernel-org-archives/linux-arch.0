Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149F3B8BBF;
	Wed, 24 Jun 2026 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293624; cv=none; b=hIO4JB1oWVaJMgK2IbnMpxI6sYJ38DSdS/tVzBJn4SRQOkyru8ltulkSAmA+u/JF6430fy8abzYcgt+W3ZuyCDFHqqPgYjHVJ1abpoGH9x7gwyhJQ/slGz6MfmlHavVlWjRuxGzcTWnF6jVQx/HQd36MRF+Mt/WnmNpS7DJlfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293624; c=relaxed/simple;
	bh=V4vMrLF5C917jIRL0H6Sc3xfE5TkB1yz3QjooYWMHWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsVAPv0HCc4JquiCCDMI28h1oL1ft+vqrs7UMdiYIifjmUQgriEoE4nsgXZ/R1UulP1CBcfcPZgdUi1Uqr3QMqd7kD8n2ocAm30m4P/ttYmdLp/LsTDqshC8zCnDsh4TRbEfqseTyuJL04B3Vz08tBxCFEoZVzjftMwWKBPyhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ggrrtMIn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ggrrtMIn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sVRuQnNxdi3tJrHHgcSarysIVdxQK98sXhem72xXjy0=; b=ggrrtMInP9TTthnUgcWBoro+wQ
	BBkKjlj8LcZuG34xXkPE23doalYvTsTPsKw4AVm0qht4vsjrttsvcvf94I9KQS0fmdJ+ohWmalzm1
	TzVuztK9AOknuMOt8vDAHlAcJ+CYcutqLRaZUm3x3BA4mWTlv07e36+NEUDhRnmoiw8BFOsPVFfz7
	mFdimNYjlh7kOndRAvTH8lASWCFgcw9AbiyqPmqMrRS1TZ2qw2NyqnfeqyzStBl3w+iZC9SevFQAN
	CcT2I2qruCmkg99UzMJ+wEwqSi5F0Hx5nSyo/LAmrZ0nB48J3MTVjhnLVmaiLimVHNz0kEogPZaM8
	4qN15aqg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcJz7-00000007mrK-1mY0;
	Wed, 24 Jun 2026 09:33:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 430E0300400; Wed, 24 Jun 2026 11:33:29 +0200 (CEST)
Date: Wed, 24 Jun 2026 11:33:29 +0200
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
Subject: Re: [PATCH 0/2] sched: Introduce and use deferred WARNs in sched
Message-ID: <20260624093329.GZ48970@noisy.programming.kicks-ass.net>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623142650.265721-1-bigeasy@linutronix.de>

On Tue, Jun 23, 2026 at 04:26:48PM +0200, Sebastian Andrzej Siewior wrote:
> This is a follow-up to the netconsole lockup reported
> 	https://lore.kernel.org/all/20260610183621.3915271-1-vlad.wing@gmail.com/
> 
> The idea is to use deferred printing for WARNs and use them in sched. I
> tried to use only where it looks that the rq lock acquired instead a
> plain s/WARN_ON/WARN_ON_DEFFERED which would be simpler.
> 
> This unholy deferred mess can be removed once we don't have legacy
> consoles anymore _or_ force force_legacy_kthread=true.

So I really don't see why we should do this. This has been a 'problem'
forever, and printk() is actually being fixed.


