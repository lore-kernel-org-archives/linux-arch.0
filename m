Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8633CAA50;
	Tue, 23 Jun 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227581; cv=none; b=GZ1KLl233sjNsDH1ycIWO4pLSe/ofIy2zz1lUM/0054cAo0ojKbuj8YdgWypBUJIdq09xDYHgGzs+kiVWnsLONpJhIMbaBFE+OzNVQP1w8u06TMoMcMrtqgvWU0B8bgiPxADUmuaZ+cxqKUsqDa7hQZmEOcKGwSwZMQBJaQM5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227581; c=relaxed/simple;
	bh=UvRb/hJ75yqmD7KOHsYc8RNxW1ISLUNyRcOHSB+mnKg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XiKofQJ5VqdGEtISxMYpNOCw1lhug6JEkI7G+KWKd2b04EWozOYSOnV7BcKuFhXtpav8niuz/3qXqA5iqRu/LpO6V/WTkispeM7QLNtEEywBoOxX3B6HhXJFysBYr+zD0ZE67yPvcWnH4GOns0PPTCZKV1UXAY9nSJ+ICs1XQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=erYQ52Vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="erYQ52Vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9731F000E9;
	Tue, 23 Jun 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782227579;
	bh=AtvjKrQjn0yaOECYG651fhjPbVJqsgT1jFVa8oh13/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=erYQ52Vc0wahfFEjC5jkxkoH7jgtKIkO3enH8kHCLnp8lS8V9OfV6cyOeFWe4dBhG
	 BLIDAtScWu3JcuLHnoltUE340UnQIkmw+LJEVKLoKL3xetwwmBLsozVNK0N+Ba4MhS
	 3exzCzkutIxDMbY4VA11dhwknIjPrSRAFHue0FSM=
Date: Tue, 23 Jun 2026 08:12:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Andrea Righi <arighi@nvidia.com>, Arnd Bergmann
 <arnd@arndb.de>, Ben Segall <bsegall@google.com>, Breno Leitao
 <leitao@debian.org>, Changwoo Min <changwoo@igalia.com>, David Vernet
 <void@manifault.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Eric
 Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, John Ogness <john.ogness@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Simon Horman <horms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-Id: <20260623081258.580e034fdb5b98f4f8dba44a@linux-foundation.org>
In-Reply-To: <20260623142650.265721-2-bigeasy@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
	<20260623142650.265721-2-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 16:26:49 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Provide a deferred version of the WARN_ON() macro. It will delay
> flushing the console until a later context. It is needed in a context
> where the caller holds locks which can lead to a deadlock content is
> flushed to the console driver.
> An example would from a warning from within the scheduler resulting in a
> wake-up of a task.
> 
> Deferring the output works by using printk_deferred_enter/ exit() around
> the printing output. This must be used in a context where the task can't
> migrate to another CPU. This should be the case usually, since the
> scheduler would acquire the rq lock whith disabled interrupts, but to be
> safe preemption is disabled to guarantee this.
> 
> In order not to bloat the code on architectures which provide an
> optimized __WARN_FLAGS() define BUGFLAG_DEFERRED which is handled by
> __report_bug() and does not increase the code size.
> 
> Provide the DEFERRED macros based on __WARN_FLAGS and __WARN_FLAGS
> macros. Extend __report_bug() to handle the deferred case.
> 
> ...
>
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -229,7 +230,10 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>  		 */
>  		bug->flags |= BUGFLAG_DONE;
>  	}
> -
> +	if (deferred) {
> +		preempt_disable_notrace();
> +		printk_deferred_enter();
> +	}

For some reason the comment over printk_deferred_enter() says
"Interrupts must be disabled for the deferred duration".  Is that the
case for all the printk_deferred_enter() calls which this patch adds?


