Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD6370D67;
	Sun, 22 Mar 2026 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181438; cv=none; b=OJpG3XOGmXb5IF0S5yvrKuy4OS/YdM5jzbgkeX6mw0b4H9RfQAMD19w7tNHKLIj/57pmWJDxN3hoZnKClIfWNZLCXILnObsd5qkR20SiOuD2Yurtf9F3b6avvTqCqKbWodVheqNH4JqpRSJSNQN1onjXpSrAXT/PeX2RAt9Rd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181438; c=relaxed/simple;
	bh=5JTnUGZawo+Z02zP1PhuzkrmfnOW2fXFFIfuYQWAgaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMFmkjCBxr0I76yYzIX7vLTzuFc8odxl3Axb/tH6CjkJKvaMHjbu7Ls1F0rCzgCUida5bxi21MTHx2lti0dRWnJ8RwOxRb8+BkTn7yMiFhFqw7379B4fxlHKpwiW+XXaIY/b8MyyaZqrBtK2kp2pmQG5+W5+pBtRw+qGPsUDH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=Qcl0bP2o; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="Qcl0bP2o"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 10454BDA4F;
	Sun, 22 Mar 2026 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1774181429;
	bh=LZjLCTldoHNqdz7JJ8YsS0zAIrQjXi1m5vYpjv5kdFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qcl0bP2oBpatlqvNm+yjEXVuc6UoiIXQkM5IbecThXTA1g96cn8Xaky6uOovqm5Ei
	 O98Z5/R2ASEx/w1YBH0Ha8pC/WHJymTUxEgeIekclEX2xtx7ttdYBECVkOx6epzdcb
	 bv0yTzJOVwvT8gotogq/m0+/EYJ/3o3NJF3ZjhDY=
Date: Sun, 22 Mar 2026 12:10:25 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/4] locking: contended_release tracepoint
 instrumentation
Message-ID: <ab_cMTd7yN36kF15@shell.ilvokhin.com>
References: <cover.1773858853.git.d@ilvokhin.com>
 <20260321171002.013ee5a9d8c789e2a4a53afc@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321171002.013ee5a9d8c789e2a4a53afc@linux-foundation.org>

On Sat, Mar 21, 2026 at 05:10:02PM -0700, Andrew Morton wrote:
> On Wed, 18 Mar 2026 18:45:17 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > The existing contention_begin/contention_end tracepoints fire on the
> > waiter side. The lock holder's identity and stack can be captured at
> > contention_begin time (e.g. perf lock contention --lock-owner), but
> > this reflects the holder's state when a waiter arrives, not when the
> > lock is actually released.
> > 
> > This series adds a contended_release tracepoint that fires on the
> > holder side when a lock with waiters is released. This provides:
> > 
> > - Hold time estimation: when the holder's own acquisition was
> >   contended, its contention_end (acquisition) and contended_release
> >   can be correlated to measure how long the lock was held under
> >   contention.
> > 
> > - The holder's stack at release time, which may differ from what perf lock
> >   contention --lock-owner captures if the holder does significant work between
> >   the waiter's arrival and the unlock.
> > 
> > The series is structured as follows:
> > 
> > 1. Remove unnecessary linux/sched.h include from trace/events/lock.h.
> > 2. Extract __percpu_up_read() out of the inline percpu_up_read() to
> >    avoid binary size increase from adding a tracepoint.
> > 3. Add contended_release tracepoint and instrument sleepable locks:
> >    mutex, rtmutex, semaphore, rwsem, percpu-rwsem, and rwbase_rt.
> 
> AI review:
> 	https://sashiko.dev/#/patchset/cover.1773858853.git.d@ilvokhin.com

Thanks, Andrew, appreciate you sharing the link.

The AI review looks reasonable. I'll go through it and address the
feedback in the next revision. The kernel test robot is also reporting
failures on some configs, which seem related to the Sashiko comments.
