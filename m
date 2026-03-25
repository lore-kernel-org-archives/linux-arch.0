Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995A3FA5C9;
	Wed, 25 Mar 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456377; cv=none; b=a4oBzkXvw/BD+VoEOL21XN4yK0iEjFmQ9KVJPHkEMhtFU0kXoo1CvzmQtTqL/0KYCfnMbJxaDHu2kr/q3zqBly4RZkfiCWwM13iRVMQIYnw5fozr9SNOc33bzxMQNbjtUkdp2NLqNRq12vTkY9ah9Y3NIRfbjxs+KzKAsq+TNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456377; c=relaxed/simple;
	bh=8KromqTmRdEzC0f/nh0v6DgYME2PY+4qjNyQaiTrV7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAmxx0YQkSmhx/guy9alHzQd9IRTlMOr1VobeAa0XcHz3uk8Hq8Nn5U0Rgv18Z4g+63wn/J/TqbDHw/K60PZWz4CxWMSwaj1Gbt3lHSoDuXhzNYVNqeWPPElhrPjoXi2yQXfGB0RP69EX8jxXpnexiipzwlBGwkUNn7eiLfYsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ALxPshRs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ALxPshRs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C378C25DD;
	Wed, 25 Mar 2026 09:32:49 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59D2A3F915;
	Wed, 25 Mar 2026 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774456375; bh=8KromqTmRdEzC0f/nh0v6DgYME2PY+4qjNyQaiTrV7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ALxPshRsDFuzUUSrAQLYb5oMb0tvtkxDp5jIXxdqmiTlZeXMf5KdiIGX4O1ZRzOAl
	 aVHoJK/TwY8rW5hry6myIKboXKXRBeNCqnA6deW64JfWx1LBRlJOFK+43TxYKT1ESK
	 YVwBkC6CymUCz98Qtl2lU+AYLcsJQEAvlp9zfpWc=
Date: Wed, 25 Mar 2026 16:32:49 +0000
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
Message-ID: <acQOMZMk0OMfIgFO@arm.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
 <20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
 <874imftol4.fsf@oracle.com>
 <20260316233712.7cbfac27@pumpkin>
 <87ms07rlp9.fsf@oracle.com>
 <20260317091705.5a64fc56@pumpkin>
 <acPo7l_pd5rnHpSX@arm.com>
 <20260325154210.79a621df@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325154210.79a621df@pumpkin>

On Wed, Mar 25, 2026 at 03:42:10PM +0000, David Laight wrote:
> On Wed, 25 Mar 2026 13:53:50 +0000
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > On Tue, Mar 17, 2026 at 09:17:05AM +0000, David Laight wrote:
> > > On Mon, 16 Mar 2026 23:53:22 -0700
> > > Ankur Arora <ankur.a.arora@oracle.com> wrote:  
> > > > David Laight <david.laight.linux@gmail.com> writes:  
> > > > > On arm64 I think you could use explicit sev and wfe - but that will wake all
> > > > > 'sleeping' cpu; and you may not want the 'thundering herd'.    
> > > > 
> > > > Wouldn't we still have the same narrow window where the CPU disregards the IPI?  
> > > 
> > > You need a 'sevl' in the interrupt exit path.  
> > 
> > No need to, see the rule below in
> > https://developer.arm.com/documentation/ddi0487/maa/2983-beijhbbd:
> > 
> > R_XRZRK
> >   The Event Register for a PE is set by any of the following:
> >   [...]
> >   - An exception return.
> > 
> 
> It is a shame the pages for the SEV and WFE instructions don't mention that.
> And the copy I found doesn't have working hyperlinks to any other sections.
> (Not even references to related instructions...)

The latest architecture spec (M.a.a) has working hyperlinks.

> You do need to at least comment that the "msr s0_3_c1_c0_0, %[ecycles]" is
> actually WFET.
> Is that using an absolute cycle count?

Yes, compared to CNTVCT.

> If so does it work if the time has already passed?

Yes, it exits immediately. These counters are not going to wrap in our
(or device's) lifetime.

> If it is absolute do you need to recalculate it every time around the loop?

No but you do need to read CNTVCT, that's what __delay_cycles() does (it
does not wait).

> __delay_cycles() contains guard(preempt_notrace()). I haven't looked what
> that does but is it needed here since preemption is disabled?

The guard was added recently by commit e5cb94ba5f96 ("arm64: Fix
sampling the "stable" virtual counter in preemptible section"). It's
needed for the udelay() case but probably not for Ankur's series. Maybe
we can move the guard in the caller?

> Looking at the code I think the "sevl; wfe" pair should be higher up.

Yes, I replied to your other message. We could move it higher indeed,
before the condition check, but I can't get my head around the ordering.
Can need_resched() check be speculated before the WFE? I need to think
some more.

> I also wonder how long it takes the cpu to leave any low power state.
> We definitely found that was an issue on some x86 cpu and had to both
> disable the lowest low power state and completely rework some wakeup
> code that really wanted a 'thundering herd' rather than the very gentle
> 'bring each cpu out of low power one at a time' that cv_broadcast()
> gave it.

WFE is a very shallow power state where all hardware state is retained.
We have an even stream broadcast to all CPUs regularly already (10KHz)
and I haven't heard people complaining about power degradation. If a CPU
is a WFI state or even deeper into firmware (following a PSCI call), an
exclusive monitor event won't wake it up. It's only for those cores
waiting in WFE.

-- 
Catalin
