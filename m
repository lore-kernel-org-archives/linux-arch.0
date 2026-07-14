Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5423F6C50;
	Tue, 14 Jul 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016702; cv=none; b=FB0N/dG88jvxgGdG2kG6TU8fmA7Z7VjP/OSPKPF8H5Ai52Y6HjRSzxJEYflg0er6R0Fl0fj0xN0xcqFwNbJZ27Rr9f04AymJ8pgXPPtBbWELO3k821hoIJtdDmuENDPMlSSV/VBDEZ4BcX8N0URyLV8O5IAdV44duPDcKnN6tnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016702; c=relaxed/simple;
	bh=bnjuwdyt/d3eGXO/PeTGV6pO/pJhRDl+5bvKJb/s79k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z2bg6vgp11dESUIL6GY+2aQEW/UHlPzCyGrEh6RYEbuvjwdGf7ju6Vm+GpXHayrQudV0UufLHoy1exx3GzV86mR435GG7bajaW3vJ3MzZ0JxbtPR106JVulzf5OW9F0Ro4vSkajX3MLooISYXo/s/e5ifCJaxwWMdXUms8yY+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEu5WEeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEu5WEeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2222C1F00A3A;
	Tue, 14 Jul 2026 08:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016700;
	bh=NhPNnCyAK5l7wJj/UbQ5T+WzfEpV9TEs0RlWJOryv3U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mEu5WEeYZ+EaFFly2xY40Ho0KJUvLnP0/EWZpn49iNCQ8ymDh2iLUI2LIWB7WKJp0
	 /5+3z2XACnfNiO1ky/amBdvG897xtIEg1CL7eZJBG7/YqGnMOlEtu1ntFyYdfV55TT
	 qadWji0P2Aq9Kw13yEnx0eH+wdbQDJILPZ8xQh55fPxtF7rSJwLsVnAbhH9SyilsPF
	 6dk14iq9oa6j+jaW11R0R6ny64JaFyWVUBPJc2p2+TOzd9AEaEZeKy/+/sCTif6Geh
	 XQblCpAy6mtfUMB7PHJ8wD2BGoyA645KIyMHtT6o18nkL66U/4+ri3LEdkIdrcKm5q
	 C3TImVkxrgPfA==
Content-Type: multipart/mixed; boundary="===============8529905552442563276=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4281974d1859d47c58f0e44ff33d654eaa98eee84be65d2ae72e22b5e24b4b04@mail.kernel.org>
In-Reply-To: <20260714073041.40250-13-ankur.a.arora@oracle.com>
References: <20260714073041.40250-13-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v14 12/15] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Jul 2026 08:11:40 +0000 (UTC)

--===============8529905552442563276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
>
>     The inner loop in poll_idle() polls over the thread_info flags,
>     waiting to see if the thread has TIF_NEED_RESCHED set. The loop
>     exits once the condition is met, or if the poll time limit has
>     been exceeded.
>
>     To minimize the number of instructions executed in each iteration,
>     the time check is rate-limited. In addition, each loop iteration
>     executes cpu_relax() which on certain platforms provides a hint to
>     the pipeline that the loop busy-waits, allowing the processor to
>     reduce power consumption.
>
>     Switch over to tif_need_resched_relaxed_wait() instead, since that
>     provides exactly that.
>
>     However, since we want to minimize power consumption in idle, building
>     of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
>     as that serves as an indicator that the platform supports an optimized
>     version of tif_need_resched_relaxed_wait() (via
>     smp_cond_load_acquire_timeout()).

This isn't a bug, but the changelog names smp_cond_load_acquire_timeout() as
the backing primitive, while the code path looks like it uses the relaxed
variant:

include/linux/sched/idle.h:tif_need_resched_relaxed_wait() {
    return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
}

include/linux/sched/idle.h:tif_bitset_relaxed_wait() {
    flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
                                          (VAL & BIT(tif)),
                                          local_clock_noinstr(),
                                          timeout_ns);
    ...
}

Should this reference smp_cond_load_relaxed_timeout() instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29315652884
--===============8529905552442563276==--
