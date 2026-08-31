Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BC39D6DA;
	Mon, 31 Aug 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211016; cv=none; b=m0icMsIVVxvgY4ot98fu3UgHvFr9qcn+tcIJAf9pdOD3itx2ztamUvokI6S6eXHmclsqi2XsXORUgrUW0r3A7oaR0BfgQ2n+cHNyeTz2LMN42Ih5cEGUOtS64SPb6n/1nAKRYxvGLOgpKyn7IaKc6yab/Dtn36tv1R/JGJMyS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211016; c=relaxed/simple;
	bh=BNzlqfIq5hVHHAdl7epz1Xgi8kcBUHUw9BrWP6fVPCo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AYdqR4QlFNT23PX4hhJZdfotMtPVM1NVzZpBDRdFhVPpePqzS7h076ANIbPTTyC3hejyOQiGZtY5qEgDOAwjMU163dBpk+6i1VUFw14bpEWaBvJO4jJjCOBYVXMobx75gkK0QBXQrRA5Fos7+vQ3RaVnwExwfRLwWVGoXG2Jhlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTUIIFUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTUIIFUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D881F000E9;
	Mon, 31 Aug 2026 21:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211014;
	bh=sZPchOHRA3BF9VMtsD8xf19l/B0VgamniMnRwg1tnIc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aTUIIFUuSZg/wIcP1OoHmTyO7DLJAioPNSdsM50MvAX0VgmzYzU7jPDcOL6saZdKM
	 vMzQwqx7YQlbm5kivk/X4FUXpn0xHaYJtXOeuCaCYJaZtL4oV1ISaCflykSMV1cM1k
	 1UiINnCbDH0WFnGL8YhFc4G/VGgRxKVUOKqu62LOvG1PWdULhq2GK7yUF+SLTIQeMn
	 mTv70n5/Del0DDYs2A2KMzaHwAcl0uCgAKRoVK5Jor8cGRaqPOFBiOvE4lio6nHQou
	 SDjlZWIfjtYaEIFXK1U3h0Q/Pz91Tlq1+aTxSwX3/03HrbULZEjhbfpTDgASPq1Ftn
	 SRyfGWxVI6vHw==
Content-Type: multipart/mixed; boundary="===============2706226096995356969=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e142ed0cf28a0bf221e04841e070eb7249ed50a2c68707f191cf19bd73f326bd@mail.kernel.org>
In-Reply-To: <20260831202251.305046-16-ankur.a.arora@oracle.com>
References: <20260831202251.305046-16-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v15 15/16] barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 21:16:53 +0000 (UTC)

--===============2706226096995356969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
> index 60f121fe5472..16a39f1076e2 100644
> --- a/lib/tests/barrier-timeout-test.c
> +++ b/lib/tests/barrier-timeout-test.c

[ ... ]

> +static const struct smp_cond_expiry_params expiry_params_list[] = {
> +	/* timeout_ns is invalid/out-of-range */
> +	{ .clk_unit = 0, .timeout_ns = -1LL,	.miniters = -1, .maxiters = 0, .desc = "invalid (-1LL)", },
> +	{ .clk_unit = 0, .timeout_ns = ~0ULL,	.miniters = -1, .maxiters = 0, .desc = "invalid (~0ULL)", },
> +	{ .clk_unit = 0, .timeout_ns = S64_MAX+1ULL, .miniters = -1, .maxiters = 0, .desc = "out-of-range (S64_MAX+1)", },
> +	{ .clk_unit = 0, .timeout_ns = U64_MAX,	.miniters = -1, .maxiters = 0, .desc = "out-of-range (U64_MAX)", },
> +	{ .clk_unit = 0, .timeout_ns = 0,	.miniters = -1, .maxiters = 1, .desc = "degenerate (0)",    },
> +
> +	/* timeout_ns is valid */
> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = 1,		    .miniters = 1,	      .maxiters = -1, .desc = "1",    },
> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 30), .miniters = 1 << (30-28), .maxiters = -1, .desc = "1<<30",   },
> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = S32_MAX,	    .miniters = 1 << (31-28), .maxiters = -1, .desc = "S32_MAX", },
> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = U32_MAX,	    .miniters = 1 << (32-28), .maxiters = -1, .desc = "U32_MAX", },
> +	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 33), .miniters = 1 << (33-28), .maxiters = -1, .desc = "1<<33",   },
> +	{ .clk_unit = (0x1ULL << 58), .timeout_ns = S64_MAX,	    .miniters = 1 << (63-58), .maxiters = -1, .desc = "S64_MAX", },
                                                                                                                  ^^^^^^^^^^^^
> +};

Can the last row actually test timeout expiry? The synthetic clock overflows
before the deadline can be reached.

synthetic_clock() advances by clk_unit per evaluation:

	clk->end_time += clk->extra;
	clk->niters++;
	return clk->end_time;

With clk_unit = 1<<58 and timeout_ns = S64_MAX, the deadline computed in
include/asm-generic/barrier.h becomes __scl_time_end = 2^58 + S64_MAX, which
needs the clock to reach 33 * 2^58 to expire. But the 32nd evaluation already
yields 32 * 2^58 == 2^63, which is S64_MIN as an s64, so the very next check
in __smp_cond_load_relaxed_timeout() breaks on the failure arm:

	if (__scl_time_now <= 0 || __scl_timeout <= 0) {
		VAL = READ_ONCE(*__PTR);
		break;
	}

So niters == 32 exactly and the break is 'time_expr_ns returned a negative
value' rather than 'timeout expired'. .miniters = 1 << (63-58) == 32 makes
KUNIT_EXPECT_GE(test, clk.niters, 32) pass by exactly zero margin, but this
doesn't distinguish an implementation that honours the timeout from one that
bails out early on clock failure.

> +static void test_smp_cond_relaxed(struct kunit *test)
> +{
> +	const struct smp_cond_expiry_params *p = test->param_value;
> +	struct clock_state clk = {
> +		.start_time = 0,
> +		.end_time = 0,
> +		.extra = p->clk_unit,
> +		.niters = 0,
> +	};
> +	s64 runtime;
         ^^^^^^^^^^^

> +
> +	flag = 0;
> +	smp_cond_load_relaxed_timeout(&flag,
> +				      0,
> +				      synthetic_clock(&clk),
> +				      p->timeout_ns);
> +
> +	runtime = (u64)clk.end_time - (u64)clk.start_time;
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

runtime is declared s64 but assigned an unsigned expression. For the S64_MAX
row this stores 2^63, which is a negative s64. The following check only passes
because typeof(right) is u64, which converts runtime back to unsigned:

	if (p->maxiters != 0)
		KUNIT_EXPECT_GE(test, runtime, p->timeout_ns);

Would declaring runtime as u64 (matching the casts on both operands) be
clearer?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33438155296
--===============2706226096995356969==--
