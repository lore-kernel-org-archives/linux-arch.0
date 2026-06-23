Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E171B2FBDFD
	for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229761; cv=none; b=Jwzp/KTT+N+VqpC6OSG4KW4o0fJ3aXoTdfFdYPgi0IzeFrG11fE053XG7t9maurl9ZV7XuGrxyjkuf0qWZOqUyYqmSa0wnY6A6VAmMvfVQup+OVqazaRQxED9rxP1nBOAV2tl+rao1SOvI2h8Mc9RWpSXnKP5sjLpe6dFfKl7bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229761; c=relaxed/simple;
	bh=g9OjuwiWr9vNABcvV89aTygb82dl7YZP7O2hr7eKPA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNmsof32e9f1VnuQWnNtJmYQS+Wqe8c3VJwnD6tt9xDtlBo7VpWu98fCFq7hw5h/QnrgSbEDumRH4N+JF/MuA2S/GpgoGRO0e08K5HcCfBqSiM+6D/2kULWtrzNWPXtsERGR9+xs/U9ajKoMIxzLrVA3rHXEf0qOih/co88PG9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WToBBs/c; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WToBBs/c"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4645995069bso32844f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2026 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782229757; x=1782834557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nEBncOkZvwmf0mpGBSEvmRcxysNfgxHVM0De27/H3fk=;
        b=WToBBs/c481BBnRlI6zyEPk0kQ3GKh0VamraAzOyB0K8zhHa3/SEFf7YCy1hi2j2wz
         ufJzLTbx0HSi+LDZnpvu8s7MYO0mQUG8FmZONXY2af8LD8fLcbzFaMwbsBKZheMWrJsZ
         qGucYVf7mNAYF/VwfLHL93sMzOWEGeNzbQ3cGEXIZpfcdQrKPwj4JJUjdma3z2tzAr92
         gJQonpEpgsEMf44ADuP4Ne+QkFiZ6Wdtc1OjfPXVyO3V0c2sWnqY4mU38dQHYhTfpY+C
         FvK8qvA2i5YdSBB7g6hU0YiN/77M113ArQz1gyYl5DAzolwR5c4ZXuW8oIM+rOJayHNE
         V1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229757; x=1782834557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEBncOkZvwmf0mpGBSEvmRcxysNfgxHVM0De27/H3fk=;
        b=tQFoh0RiPXD3Ehf7gHXePEuWboS0rLWMzMtVf7TAZuRaQvbM1oJ7T3IA6VMaQ+bZqk
         b76uZt5Mmb/FjTGNChAtLKdtJb1opei17EjJW2u1U7y7KVE0BLhUgTFhmJqu9EjBj00n
         vIiqGukN+r7IC/9N+Mqdr8j8hOjP0F8vSdnwbhxhxk+ja99UerMc83+gJI6/9QmU+I22
         7mTRz4DfHy84jRLvOi7R3RAFZzBGcS1xZeqLWDcYTA7YRxy2kNBNwfPtsxFScfXjM5Or
         uxzakLdWSYA++UkLB2feVX0pgpg+WkeTJK0ebGqkDFUGxjUdO6FgQCidT3+VFBvW0x1Z
         z0Mw==
X-Forwarded-Encrypted: i=1; AFNElJ+RoGHMvE+PW7oEK1wJ3z6MW5GWpMG9AwgLk8bugbW+iD0LskAH6AdZiuKDS15SVlV+4gQticR8WV5R@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAiPI9Xf85YALCm+JpqJFrKRqwUd8j9bPM1ra+kc6X+LtMBpN
	6Du3AjM0FAVesGoEuAEaS8HW/sCbDEPx7nqR+rjSdjAJ4G5n+I2u0Y3B2few+KcpaUM=
X-Gm-Gg: AfdE7cm3wzvd5ozTnplh+6GyLbGImHLW54ui6ZedvBN6nEdLi/n6I8rAUe99ibRoDqT
	LQwcqnTIjD67DGD7O9v/8483znkSofVBitnCC1uEU+5ueavbdRxdSi48HpoFA3i4Vjzj6lbK/oZ
	xWZRHcLmgfDNPgCzhW6nkAtOQ3o8kZ94rzTlBeIzaONffYBtHZ8SsiT4BcP7brawzO2q1wG0W7n
	O3mkvL1rxdmLBOB1HMN4qeQ3j7kFfPoPP5UOjFBUr97hz4dcys0OIB1s00FLslJoeBSagfhjAj+
	s0URylItVaAcfpAbgwghPIUf81NsMdviws3aphloWkxRD5z5vKsp6eDDlroa9kkS3IibGmRPaK5
	SBlIT+luD4vrj2ViF4djz/8MjvmT4YlqXnapkuDGqr5aJnN18luoKCReFWus9d/5yzDlWJbfAC7
	v1hoKnQQZhT3kwXk2kgtmejQWw4g==
X-Received: by 2002:a05:600c:3495:b0:490:e196:e8df with SMTP id 5b1f17b1804b1-4925b3aa15bmr52076835e9.23.1782229757310;
        Tue, 23 Jun 2026 08:49:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923914fsm313673405e9.6.2026.06.23.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:49:16 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:49:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Ben Segall <bsegall@google.com>, Breno Leitao <leitao@debian.org>,
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
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <ajqq-ihAiU2VEaOp@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <20260623081258.580e034fdb5b98f4f8dba44a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623081258.580e034fdb5b98f4f8dba44a@linux-foundation.org>

On Tue 2026-06-23 08:12:58, Andrew Morton wrote:
> On Tue, 23 Jun 2026 16:26:49 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Provide a deferred version of the WARN_ON() macro. It will delay
> > flushing the console until a later context. It is needed in a context
> > where the caller holds locks which can lead to a deadlock content is
> > flushed to the console driver.
> > An example would from a warning from within the scheduler resulting in a
> > wake-up of a task.
> > 
> > Deferring the output works by using printk_deferred_enter/ exit() around
> > the printing output. This must be used in a context where the task can't
> > migrate to another CPU. This should be the case usually, since the
> > scheduler would acquire the rq lock whith disabled interrupts, but to be
> > safe preemption is disabled to guarantee this.
> > 
> > In order not to bloat the code on architectures which provide an
> > optimized __WARN_FLAGS() define BUGFLAG_DEFERRED which is handled by
> > __report_bug() and does not increase the code size.
> > 
> > Provide the DEFERRED macros based on __WARN_FLAGS and __WARN_FLAGS
> > macros. Extend __report_bug() to handle the deferred case.
> > 
> > ...
> >
> > --- a/include/asm-generic/bug.h
> > +++ b/include/asm-generic/bug.h
> > @@ -229,7 +230,10 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
> >  		 */
> >  		bug->flags |= BUGFLAG_DONE;
> >  	}
> > -
> > +	if (deferred) {
> > +		preempt_disable_notrace();
> > +		printk_deferred_enter();
> > +	}
> 
> For some reason the comment over printk_deferred_enter() says
> "Interrupts must be disabled for the deferred duration".  Is that the
> case for all the printk_deferred_enter() calls which this patch adds?

Strictly speaking, "only" CPU migration must be disabled around
printk_deferred_enter()/exit() call because the state is stored
in a per-CPU variable.

It means that preempt_disable() would work.

I do not recall whether we mentioned interrupts by mistake or
on purpose. It is possible that we suggested to disable interrupts
because we did not want to deffer messages from unrelated (interrupt)
context.

Best Regards,
Petr
