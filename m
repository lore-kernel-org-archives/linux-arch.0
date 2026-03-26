Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7441AB6F1;
	Thu, 26 Mar 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539606; cv=none; b=gQyOLnFOJI0qkk1iv0nk9TdWRRxLzZTdxCcao9ziwKMAFPbCHVbgrmP3HwYl4hzgNRVbEAYm8SDgYSsk3N1baWA45lLVKfbpGOfBdCCOygGne2Li6QcfEtG8z7Ndr/263g0gNqulbSr4f+LE1qC9l517VED/JHc6+3g3eXSvt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539606; c=relaxed/simple;
	bh=Q0dXKMwvqUVibjNiOVBckvLKDWg553EueB8+WMLxmc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+FID+MQ6tQkAcPsw42QfmFdE2v2RZOpNGzBLfH2F2D/O/OiSTrvH0/tr9vqXwThJLV8D6kBz8RtYDGRr3SdzVfSu1UCkn1izkgH3Rv4jP7kWiBuVfiTxnd3HOk4mLL4Dbe0NrPn01UpAAMCP5zUpjHPfvwSM29exR41MI3AaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mc4lcYVY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mc4lcYVY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD94D1E8D;
	Thu, 26 Mar 2026 08:39:57 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EABDB3F641;
	Thu, 26 Mar 2026 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774539603; bh=Q0dXKMwvqUVibjNiOVBckvLKDWg553EueB8+WMLxmc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mc4lcYVYUHKT2M7If7nhAWGnZP/hhh3sCwS0HbRbciFw5wsasz3C/I3bFUxD59SRT
	 XrtbThR6As6fI/3wYPm16LoQDN+8TdK6wkg5JDRXsQ3uXh1fduUKdo504SF8KLGg5M
	 NI0FNHJR4eVatqynexCUxM4hF5xdex24OOKPoqCQ=
Date: Thu, 26 Mar 2026 15:39:58 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
	cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
	daniel.lezcano@linaro.org, memxor@gmail.com,
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
	rdunlap@infradead.org, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <acVTTmGCZL4QPln2@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
 <874imftol4.fsf@oracle.com>
 <20260316233712.7cbfac27@pumpkin>
 <87ms07rlp9.fsf@oracle.com>
 <20260317091705.5a64fc56@pumpkin>
 <acPo7l_pd5rnHpSX@arm.com>
 <20260325154210.79a621df@pumpkin>
 <acQOMZMk0OMfIgFO@arm.com>
 <20260325202357.3e203314@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325202357.3e203314@pumpkin>

On Wed, Mar 25, 2026 at 08:23:57PM +0000, David Laight wrote:
> On Wed, 25 Mar 2026 16:32:49 +0000
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > On Wed, Mar 25, 2026 at 03:42:10PM +0000, David Laight wrote:
> ...
> > > Looking at the code I think the "sevl; wfe" pair should be higher up.  
> > 
> > Yes, I replied to your other message. We could move it higher indeed,
> > before the condition check, but I can't get my head around the ordering.
> > Can need_resched() check be speculated before the WFE? I need to think
> > some more.
> 
> I don't think speculation can matter.
> Both SEVL and WFE must be serialised against any other instructions
> that can change the event flag (as well as each other) otherwise
> everything is broken.

Welcome to the Arm memory model. We don't have any guarantee that an LDR
will only access memory after SEVL+WFE. They are not serialising.

> Apart from that it doesn't matter, what matters is the instruction
> boundary the interrupt happens at.

True. If an interrupt is taken before the LDR (that would be a
need_resched() check for example), then a prior WFE would not matter.
This won't work if we replace the IPI with a SEV though (suggested
somewhere in this thread).

> Actually both SEVL and WFE may be synchronising instructions and very slow.

Most likely not.

> So you may not want to put them in the fast path where the condition
> is true on entry (or even true after a retry).
> So the code might have to look like:
> 	for (;;) {
> 		VAL = mem;

If we only waited on the location passed to LDXR, things would have been
much simpler. But the osq_lock() also wants to wait on the TIF flags via
need_resched() (and vcpu_is_preempted()).

> 		if (cond(VAL)) return;

So the cond(VAL) here is actually a series of other memory loads
unrelated to 'mem'

> 		SEVL; WFE;
> 		if (cond(VAL)) return;

I think this will work in principle even if 'cond' accesses other memory
locations, though I wouldn't bother with an additional 'cond' call, I'd
expect SEVL+WFE to be mostly NOPs. However, 'cond' must not set a local
event, otherwise the power saving on waiting is gone.

> 		v1 = LDX(mem);
> 		if (v1 == VAL)
> 			WFE;
> 	}

I think it's cleaner to use Ankur's timeout API here for the very rare
case where an IPI hits at the wrong time. We then keep
smp_cond_load_relaxed() intact as it's really not meant to wait on
multiple memory locations to change. Any changes of
smp_cond_load_relaxed() with moving the WFE around are just hacks, not
the intended use of this API.

-- 
Catalin
