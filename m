Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30EF3845A7;
	Tue, 21 Apr 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755717; cv=none; b=bS03R5X375pYg5eEKww0z824rSfYHK+Fzu8zpt8DxRvYEOaAnX/6tjis1aJ+dUvvp/HkR4f85tDl+fOqShgnSBKsn3u+1TQgZSH0zVjf/6D+YjET87BthtdsqVMReSa/YfAqdlPjMM3pTOJlzujWyvnlUu/NCBp4H8WEa87jL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755717; c=relaxed/simple;
	bh=1NNOk+eJmvh1fUcjXPKrED58fI60eQJmGrCvZy20t20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiF2w46LCh2EjcmdIykShgNVly0ScuztrnFzd+0n/5Gq2KNYMN2+A8gc6q43iaQGnAx17CQwZkTWKWQS3LsOUQFUh7XWEQpwAsMakfWNjMMsHSmPk/BVBP58DGEOl/Rg1GGSNCuWABFdxCbWcDGpbqwehwkbWv0vICQvtCoQL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NWOrOna/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NWOrOna/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D75825E0;
	Tue, 21 Apr 2026 00:15:09 -0700 (PDT)
Received: from arm.com (unknown [10.57.89.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AC763F641;
	Tue, 21 Apr 2026 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776755714; bh=1NNOk+eJmvh1fUcjXPKrED58fI60eQJmGrCvZy20t20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWOrOna/dqHHHBSoqj2cEZEw0sLpi1/1pm0lCfVz8K6R2FiWuRNyoI7Z20V4DhUuF
	 ympOETtLPJZy5MwKNn7U8N/X6X/httaAaprbWCkpbjb5xPt9BX7gdKminZXWiXFKeY
	 CkVLJXELaKau+8XS2XwBwOafpy1r0idm19UWq/Gs=
Date: Tue, 21 Apr 2026 08:15:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: "Okanovic, Haris" <harisokn@amazon.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
	"memxor@gmail.com" <memxor@gmail.com>,
	"ashok.bhat@arm.com" <ashok.bhat@arm.com>,
	"zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"cl@gentwo.org" <cl@gentwo.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v11 12/14] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Message-ID: <aecj-8In0A-G9OGN@arm.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
 <20260408122538.3610871-13-ankur.a.arora@oracle.com>
 <a374b23f8b03f850a874d46bc78411fb99483ca2.camel@amazon.com>
 <87mryxh67j.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mryxh67j.fsf@oracle.com>

On Mon, Apr 20, 2026 at 10:50:08AM -0700, Ankur Arora wrote:
> Okanovic, Haris <harisokn@amazon.com> writes:
> > On Wed, 2026-04-08 at 17:55 +0530, Ankur Arora wrote:
> >> The inner loop in poll_idle() polls over the thread_info flags,
> >> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
> >> exits once the condition is met, or if the poll time limit has
> >> been exceeded.
> >>
> >> To minimize the number of instructions executed in each iteration,
> >> the time check is rate-limited. In addition, each loop iteration
> >> executes cpu_relax() which on certain platforms provides a hint to
> >> the pipeline that the loop busy-waits, allowing the processor to
> >> reduce power consumption.
> >>
> >> Switch over to tif_need_resched_relaxed_wait() instead, since that
> >> provides exactly that.
> >>
> >> However, since we want to minimize power consumption in idle, building
> >> of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
> >> as that serves as an indicator that the platform supports an optimized
> >> version of tif_need_resched_relaxed_wait() (via
> >> smp_cond_load_acquire_timeout()).
> >>
> >> Cc: Rafael J. Wysocki <rafael@kernel.org>
> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Cc: linux-pm@vger.kernel.org
> >> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> >> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
[...]
> > Tested atop latest mainline d60bc1401 with the rest of your haltpoll
> > changes from separate thread: ~10% improvement in `perf sched bench
> > pipe` micro and ~4-6% throughput improvements in mysql, postgresql,
> > cassandra, and memcached in under-loaded configurations. Tested on
> > AWS Graviton3 and Graviton4, ARM Neoverse V1 and V2 cores
> > respectively.
> >
> > I hope this series can merge soon. It's been stuck in review for more
> > than 2 years.
> >
> > Tested-by: Haris Okanovic <harisokn@amazon.com>
> 
> Thanks Haris. Yeah, I don't think there are any open issues left on
> this.

I agree, though an ack from the atomic infrastructure people on the
generic bits would be nice.

-- 
Catalin
