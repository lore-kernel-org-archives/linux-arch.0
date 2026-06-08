Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F62192F4;
	Mon,  8 Jun 2026 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909492; cv=none; b=YHuiI7RolPTqw7NwTtQ2XPp3pf0IuRu887QzaoJved2p/ttpO0T5d3lYyHBgcq6IQ8ox/FzcNQdMXBKr4V0hePQ3sGSf0KtXC54/8MDqTGMbAVoSpyQ6almDmgcMoLC/oH7I96t4jvFGs9+1TIeimFeXwANPjKDXf88kMW4Yzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909492; c=relaxed/simple;
	bh=toJk1ctZErkqLyuS7bbJhiSfbHVht1LdmOkBJGDBC9Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XzEUFZBUf+1gEF7hF73esve7RLjTAF9at+egvM9I3HvYH70ANiSM7sMgScfUNS7YfyNzTTSV7OCzpkVgYr7AI4/FbisGsjH5eUAZlLGBv2rdh1Rozx9C3B2+3njawh0Q2miORZFqmG0vaZ6/EJoBNIlgHoR6HQNgy+VekO8Y8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ1Gqx3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ1Gqx3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31A61F00893;
	Mon,  8 Jun 2026 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780909490;
	bh=Gaxzxjs/vW8KUnXlGRbEJH8BuwjUHLEEzwHgn4vcNq8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SQ1Gqx3lfMg1hXe2Mb/ikw+gqB4wOZOyqjjovAYrXAeEsXeF1jK+guNjO5eGNGgo3
	 Ua69ha6cNJlcOHmqQqGVviip9bSqm5kgnPgRtjVIpE0mFjsNWa82qbnV0UNUDcLnZD
	 JvhfX6WW1qx5wmM13Xp24kzC7ArgAk5YtsnjF5ukKNAK5BDnD/a8A9PIQt1YHfu7FU
	 n+nzjbnyVIo1jUpENZ48U7MrSuJ3svSENTZPp4eM3CYy8ExExiFO11uVKKmRoUeS4b
	 okcmC8gz+smucdPSuFAFdXWyfUV46uXXG0rud4CX4NzWNh0Tp8SNGXRqPUDz+POEJ/
	 VdEy+KASUxFXQ==
Content-Type: multipart/mixed; boundary="===============6094207814609945116=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <05f7ab2eeaf872990f9f43125fe21311719d65271c2b1ef3c40bb2ca2e8c679b@mail.kernel.org>
In-Reply-To: <20260608080440.127491-11-ankur.a.arora@oracle.com>
References: <20260608080440.127491-11-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v12 10/15] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 09:04:49 +0000 (UTC)

--===============6094207814609945116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
>
> Switch out the conditional load interfaces used by rqspinlock
> to smp_cond_read_acquire_timeout() and its wrapper,
> atomic_cond_read_acquire_timeout().
>
> Both these handle the timeout and amortize as needed, so use the
> non-amortized RES_CHECK_TIMEOUT.
>
> RES_CHECK_TIMEOUT does double duty here -- presenting the current
> clock value, the timeout/deadlock error from clock_deadlock() to
> the cond-load and, returning the error value via ret.
>
> For correctness, we need to ensure that the error case of the
> cond-load interface always agrees with that in clock_deadlock().
>
> For the most part, this is fine because there's no independent clock,
> or double reads from the clock in cond-load -- either of which could
> lead to its internal state going out of sync from that of
> clock_deadlock().
>
> There is, however, an edge case where clock_deadlock() checks for:
>
>         if (time > ts->timeout_end)
>                 return -ETIMEDOUT;
>
> while smp_cond_load_acquire_timeout() checks for:
>
>         __time_now = (time_expr_ns);
>         if (__time_now <= 0 || __time_now >= __time_end) {
>                 VAL = READ_ONCE(*__PTR);
>                 break;
>         }
>
> This runs into a problem when (__time_now == __time_end) since
> clock_deadlock() does not treat it as a timeout condition but
> the second clause in the conditional above does.
> So, add an equality check in clock_deadlock().
>
> Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
> the spin-count used in the amortized version. We only do this for
> non-arm64 as that uses a waiting implementation.
>
> Cc: bpf@vger.kernel.org
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Besides switching to the new cond-load interface, this commit also
changes the boundary comparison in clock_deadlock() from:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

to:

        if (time >= ts->timeout_end)
                return -ETIMEDOUT;

so that time == timeout_end is now treated as a timeout, matching the
__time_now >= __time_end check in smp_cond_load_acquire_timeout().

The time > ts->timeout_end check, and the timeout_end field itself, were
first introduced in the then-named check_timeout() helper by:

  commit 14c48ee81452 ("rqspinlock: Add support for timeouts")

Should this commit carry a Fixes: tag for that boundary change?

  Fixes: 14c48ee81452 ("rqspinlock: Add support for timeouts")

This is offered tentatively: under the previous res_smp_cond_load_acquire
interface the '>' comparison was internally consistent, and the boundary
divergence only becomes observable once this commit switches to the
'__time_now >= __time_end' interface. So this may read more as a
self-contained adjustment than a fix for a pre-existing bug.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27125050324
--===============6094207814609945116==--
