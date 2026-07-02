Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270442C0268;
	Thu,  2 Jul 2026 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958315; cv=none; b=n2sHfBtBvbT8y7q7dOFgeF05ZnIF7YFOqK82LfiESSUjmp564p+4u3gIoINTl3lzkoHYBFG9CR/i2E5OW3DPYI5N0TZcTFTcUKrCpSDszq+dCslYoEIN/uldB2LnAAWa4ThTP1mrTxvt0WHq05DTURwmrLMF1Ik1Lao8GrQmdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958315; c=relaxed/simple;
	bh=y6rE3cBGJ4TvQKQ+fgidLN4wmYtQOuNA8ivV1TAm5bI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UnZv9aWMFTaigJUoofeyrPRvoeZgmqfRRNNTfezIZPlSZ2uQZIq5c+N3jL6FQUVRiwoIm8UOtD3swZnD746c9Yb0OnkmJ9kn0N3UEF/8YcPW9ftylwm/pI9GLhf74G1V+l6uXEIMkwl44KJt8kxgwTTE1QgpSmXXCdhsc8SjO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ2APbjg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ2APbjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990FC1F000E9;
	Thu,  2 Jul 2026 02:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958314;
	bh=Xd6c0bAtnDC1jjI/+BRH1ouYM9ZqgJCsh0Ij+BLlITo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kJ2APbjgjo3kIcdbXWZLU9i4Jy7JX7fIVJ98tZh21ByFZiFIZmGTjMt2YjOt4xqDY
	 L1/xj3jL4IIrJqKFSW4Rsc/OhBCMiXJ5+TeQnerxvDEcB2F/b6IyRvGmrhrfr33iEZ
	 17hxcp++bMvCffzco3LiIvltFl//A5gAzqNTGO/hNTMUUHnPSPbRivYG0bPRx6cAYN
	 abiV7QkyVYVwBsmoZ3Bxqog/NycG/Um3goXhWEsZYeXPZIcodFXo1ECVndZjkhsXz7
	 qTxVpLtbUUrO4uBw9XrJqtgj4odhFZb2ndZEqlhVm2U7vTjfiY7cyoqZK/EZN64rnk
	 U3Qv+xPpGyUtA==
Content-Type: multipart/mixed; boundary="===============1924622309690578587=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <127be9fcbdb5b68bef8de1a918c3eaabb302f363788f96b5dca0cedfb583ef4d@mail.kernel.org>
In-Reply-To: <20260702013334.140905-16-ankur.a.arora@oracle.com>
References: <20260702013334.140905-16-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v13 15/15] barrier: add clock tests for smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Jul 2026 02:11:53 +0000 (UTC)

--===============1924622309690578587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
> index 4226fb6456b3..ec78f8533006 100644
> --- a/lib/tests/barrier-timeout-test.c
> +++ b/lib/tests/barrier-timeout-test.c

[ ... ]

> @@ -112,8 +114,64 @@ static void test_smp_cond_timeout(struct kunit *test)
>  		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
>  }
>
> +static s64 synthetic_clock(struct clock_state *clk)
> +{
> +	clk->end_time += clk->extra;
> +	clk->niters++;
> +
> +	return clk->end_time;
> +}
> +
> +
> +struct smp_cond_expiry_params {
> +	char	*desc;
> +	s64	timeout;
> +	s64	clk_inc;
> +	u32	niters;
> +};
> +
> +static const struct smp_cond_expiry_params expiry_params_list[] = {
> +	{ .clk_inc = (0x1ULL << 28), .timeout = 0,		.niters = 1,			.desc = "0",    },
> +	{ .clk_inc = (0x1ULL << 28), .timeout = 1,		.niters = 2,			.desc = "1",    },
> +	{ .clk_inc = (0x1ULL << 28), .timeout = (0x1ULL << 30), .niters = 1 + (1 << (30-28)),	.desc = "1<<30",   },
> +	{ .clk_inc = (0x1ULL << 28), .timeout = S32_MAX,	.niters = 1 + (1 << (31-28)),	.desc = "S32_MAX", },
> +	{ .clk_inc = (0x1ULL << 28), .timeout = U32_MAX,	.niters = 1 + (1 << (32-28)),	.desc = "U32_MAX", },
> +	{ .clk_inc = (0x1ULL << 28), .timeout = (0x1ULL << 33), .niters = 1 + (1 << (33-28)),	.desc = "1<<33",   },
> +};
> +
> +static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *desc)
> +{
> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock-%s, timeout=%s, iterations=%u",
> +		"relaxed", "synthetic", p->desc, p->niters);
> +}

This isn't a bug, but since "relaxed" and "synthetic" never vary here,
could they be written directly into the format string rather than passed
through %s?

> +
> +static void test_smp_cond_expiry(struct kunit *test)
> +{
> +	const struct smp_cond_expiry_params *p = test->param_value;
> +	struct clock_state clk = {
> +		.start_time = 0,
> +		.end_time = 0,
> +		.extra = p->clk_inc,
> +		.niters = 0,
> +	};
> +	s64 runtime;
> +
> +	flag = 0;
> +	smp_cond_load_relaxed_timeout(&flag,
> +				      0,
> +				      synthetic_clock(&clk),
> +				      p->timeout);
> +
> +	runtime = (u64)clk.end_time - (u64)clk.start_time;
> +	KUNIT_EXPECT_EQ(test, clk.niters, p->niters);
> +	KUNIT_EXPECT_GE(test, runtime, p->timeout);
> +}
> +
> +
> +KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
>  static struct kunit_case barrier_timeout_test_cases[] = {
>  	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
> +	KUNIT_CASE_PARAM(test_smp_cond_expiry, smp_cond_expiry_params_gen_params),
>  	{}
>  };


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28559763019
--===============1924622309690578587==--
