Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166473FBEBC;
	Thu, 11 Jun 2026 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185509; cv=none; b=UxdEoKvV+APV+VffqgSggF2jwAJXfAuHDb8nVfT/zfyYGswq5Mu/80DVcvjaPrB+458w2KC6PJMfwingSX0eebME9RyLJIZ1ro7qAnlCV3GUKtWKTQLz3c4rUsbau2ENXiOC08IvkkB4B13gmY8jVmrlw3veeuwG4Y4gla9GPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185509; c=relaxed/simple;
	bh=kUIwqYLzboTXSW9mocUnEjpqnAKtc9Q3KI2UV2OLx0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5DWruKl6rGFWLqoSTUu5V984+xtht/7FiC2XTs5LiBCq14bENWnu7/VWepVS+myI6vBr1/6l+0AbNt0+k9QghSMK474oc2O+UXjpIqIz10rJpjfgRg8nqtrQORcNBm9mx7Q5SEzt994vKhaKyzihaswMEHV+DYZdS8b5ODXI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ibs/lTWy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ibs/lTWy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m0fD9KCk/6I6qo6Wg6wfui77ADSGp/LJkYfEAup3lwY=; b=ibs/lTWyAjLVWXS3n4wPjA79OS
	ITb//Iv1CxtQUrx/67IL+hYSamUfqJOQPft+Dglj3UFpe6AehWYKHnyrdmyQlnLCCHnR37eSF04YY
	BV8xlmAh95887QUefrFHmh4w0rqaGST435zBbQpMYZ8US3gRQg+HjRI0XuAaxBi7gclydQf69ZDM5
	k61d3A3iRRXuQJHaZacf+KNxVaTzU7pWHtqGjdFKnziZBtLLfi6vKmz1i2qN9G7/mZEKcluKIADZP
	arbxTyUtAa9KswEQnkGYCnK7u+EJaXbbI3n2nupMq3G+mbNR2VmbwbcZlBXNHkE7grhJz1GNpvuDh
	FnJVAQdw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXfi7-00000001ydR-0GUg;
	Thu, 11 Jun 2026 13:44:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0B6CD3002F0; Thu, 11 Jun 2026 15:44:42 +0200 (CEST)
Date: Thu, 11 Jun 2026 15:44:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 5/7] locking: Add contended_release tracepoint to
 qspinlock
Message-ID: <20260611134442.GJ48970@noisy.programming.kicks-ass.net>
References: <cover.1777999826.git.d@ilvokhin.com>
 <5d7ea75ffe74a785e6b234ada9f23c6373d4b4c1.1777999826.git.d@ilvokhin.com>
 <20260513193342.GB2545104@noisy.programming.kicks-ass.net>
 <agXBb0ga_6HJrrnm@shell.ilvokhin.com>
 <20260603120811.GW3493090@noisy.programming.kicks-ass.net>
 <aiphFXe_TPNPxZ_n@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiphFXe_TPNPxZ_n@shell.ilvokhin.com>

On Thu, Jun 11, 2026 at 07:17:41AM +0000, Dmitry Ilvokhin wrote:
> On Wed, Jun 03, 2026 at 02:08:11PM +0200, Peter Zijlstra wrote:
> > Also, I think someone should go do some performance runs with
> > ARCH_INLINE_SPIN_* set for x86 just like for s390.
> 
> As promised, I set ARCH_INLINE_SPIN_UNLOCK{,_BH,_IRQ,_IRQRESTORE} for
> x86 and measured the effect on a few real workloads.
> 
> Short version: inlining of _raw_spin_unlock() adds measurable kernel
> i-cache pressure on every workload I tried, and on a
> kernel-i-cache-bound one (nginx connection churn) it costs ~1.27%
> throughput. I did not find a workload where it helps.

Thanks for checking!
