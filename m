Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE843A784A;
	Mon, 31 Aug 2026 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211025; cv=none; b=OAsjFS0sEHYrt8NsvOKcKYRLf4TJ9L3MQd5bpzKoDRvG/QAZJgF4tK87sYkGYK6s0tC2PVE7QOcq09pJDXYp0aUPe5db6lfkxDuL60RgtWWUXd50eBSS/lewErJdoPt9EhpoVmqGGcq8+lMJbuwDh8XUpoSforDgG9wXk7yM750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211025; c=relaxed/simple;
	bh=MJ6tn8OhctkckNKrdVmjL6XqZLMecYluIvYIo/zwwuM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NCgleVs5MUgKahG2w1rs2e7JuhbsWQlDsdGweMtrOJwGFHU3Q8N1cz6mz0yVrCBK1p0kj6a/V/PMY9/Yh5qAcAO1tGb/4iFNvk1/ZaCj2TQzViS/z3cr1G8fg+GbH3ht6KDjdWHmyMDVcz92XoDRkmYXDG4sun5S8oQxgzlWREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcIN2iSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcIN2iSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB48C1F00A3D;
	Mon, 31 Aug 2026 21:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211023;
	bh=VeBW89NCaotxpWHYUHo6tftRkQoaTqSQueHBMNZxTgM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kcIN2iSDuIXMzwh7bvLAs4M30OeByHymKx04xjR/XGNaKAxWawulhGO4uQbd5Nga+
	 U4vDw6U2DnKolO/899QKQE5sLdzvdQQi5CZBKVvrCtRuC1+QRPjjg0bcP7sEum2a7K
	 stXqnUmpX1DGhM5mWxKfbKyYOvH9n7cPss23uysklc6c07f1wnPv9cMHMfNArkKhQA
	 d5EHPg4PGsoLC+MXbvesMZwEBrALdaGIGRKn1ko4RjMp6A9PKEQvFuI9FMxO3BPLa8
	 x3oDgLZQfy007PAydUkY7N3zEQbPaU8WdKAPruBkWnoNbo8pS0g8wTXn3jvsTOAwrD
	 EEqZt4UX8GvFQ==
Content-Type: multipart/mixed; boundary="===============8337952524881869404=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9a72b53f0d952d0abbb6203b4ccc25ba3ae0ac0b8e8071d89c9948cc5f650fd1@mail.kernel.org>
In-Reply-To: <20260831202251.305046-15-ankur.a.arora@oracle.com>
References: <20260831202251.305046-15-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v15 14/16] barrier: add tests for smp_cond_load_*_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,julianbraha@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 21:17:01 +0000 (UTC)

--===============8337952524881869404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1244dcac2294..cb46e9fcc87c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2551,6 +2551,16 @@ config FFS_KUNIT_TEST
>  	  For more information on KUnit and unit tests in general,
>  	  please refer to Documentation/dev-tools/kunit/.
>
> +config BARRIER_TIMEOUT_KUNIT_TEST
> +	tristate "KUnit tests for smp_cond_load_*_timeout()" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds KUnit tests that validate wake-up and timeout handling paths in
> +	  smp_cond_load_relaxed_timeout() and smp_cond_load_acquire_timeout().
> +
> +	  If unsure, say N.
> +
>  config TEST_KSTRTOX
>  	tristate "Test kstrto*() family of functions at runtime"

[ ... ]

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
> new file mode 100644
> index 000000000000..60f121fe5472
> --- /dev/null
> +++ b/lib/tests/barrier-timeout-test.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests exercising smp_cond_load_relaxed_timeout().
> + *
> + * Copyright (c) 2026, Oracle Corp.
> + * Author: Ankur Arora <ankur.a.arora@oracle.com>
> + */

[ ... ]

> +static void test_smp_cond_timeout(struct kunit *test)
> +{
> +	const struct smp_cond_update_params *p = test->param_value;
> +	struct clock_state clk = {
> +		.start_time = local_clock(),
> +		.end_time = local_clock(),
> +	};
> +	s64 runtime, timeout_ns = TIMEOUT_MSEC * NSEC_PER_MSEC;
> +	unsigned int result;
> +
> +	flag = 0;
> +	if (p->acquire) {
> +		result = smp_cond_load_acquire_timeout(&flag,
> +						       (VAL & TEST_FLAG_VAL),
> +						       p->clock(&clk),
> +						       timeout_ns);
> +	} else {
> +		result = smp_cond_load_relaxed_timeout(&flag,
> +						       (VAL & TEST_FLAG_VAL),
> +						       p->clock(&clk),
> +						       timeout_ns);
> +	}
> +
> +	runtime = clk.end_time - clk.start_time;
> +	KUNIT_EXPECT_EQ(test, (bool)(result & TEST_FLAG_VAL), p->succeeds);
> +	if (!p->succeeds)
> +		KUNIT_EXPECT_GE(test, runtime, timeout_ns);

Could the elapsed-time assertion produce spurious failures when the test
migrates between CPUs?

The test runs with preemption and migration enabled, and can spend 2 ms
inside smp_cond_load_*_timeout() spinning on cpu_relax(). There is no
preempt_disable(), migrate_disable(), or CPU affinity set anywhere in
the file.

Samples can therefore come from different CPUs:

    .start_time = local_clock(),           /* test_smp_cond_timeout() */
    ...
    clk->end_time = local_clock();         /* basic_clock() */
    runtime = clk.end_time - clk.start_time;
    KUNIT_EXPECT_GE(test, runtime, timeout_ns);

local_clock() is only monotonic per CPU. With
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK and !sched_clock_stable(),
local_clock_noinstr() returns sched_clock_local(this_scd()), whose
per-CPU value is only clamped into [gtod, gtod + TICK_NSEC].

include/linux/sched/clock.h states this explicitly:

    # when comparing cpu_clock(i) to cpu_clock(j) for i != j, time can
    # go backwards !!

The permitted inter-CPU skew is up to one tick, which is 4 ms at HZ=250,
twice the 2 ms timeout under test.

Concrete failing interleaving (D = skew, CPU A ahead of CPU B):

  1. test_smp_cond_timeout() on CPU A samples start_time = a0.
  2. Task migrates to CPU B. The macro's first time_expr_ns evaluation
     samples t1 = a0 - D and sets __scl_time_end = a0 - D + timeout_ns.
  3. Task migrates back to CPU A. A later sample satisfies
     __scl_timeout <= 0 as soon as a0 + elapsed >= a0 - D + timeout_ns,
     i.e. elapsed >= timeout_ns - D, and that sample is stored in
     clk->end_time.
  4. runtime = timeout_ns - D < timeout_ns, so KUNIT_EXPECT_GE fails
     even though the implementation behaved correctly.

This also conflicts with the documented contract in
include/asm-generic/barrier.h which requires "expression that evaluates
to monotonic time (in ns)".

Would pinning the test (migrate_disable()/preempt_disable() around the
spin, or sampling with a globally monotonic source) make the 2 ms
assertion sound?

> +}

[ ... ]

> +kunit_test_suite(barrier_timeout_test_suite);
> +
> +MODULE_DESCRIPTION("KUnit tests for smp_cond_load_relaxed_timeout()");
> +MODULE_LICENSE("GPL");

Does the MODULE_DESCRIPTION accurately describe the module's coverage?

The file header comment and MODULE_DESCRIPTION both claim the module
only covers the relaxed variant:

    /*
     * KUnit tests exercising smp_cond_load_relaxed_timeout().

    MODULE_DESCRIPTION("KUnit tests for smp_cond_load_relaxed_timeout()");

But half of the parameter table selects the acquire variant, and
test_smp_cond_timeout() calls it:

    update_params_list[] = {
        { .clock = &mocked_clock, .succeeds = true, .acquire = true,  },
        { .clock = &basic_clock, .succeeds = false,  .acquire = true, },
    };

    if (p->acquire) {
            result = smp_cond_load_acquire_timeout(&flag, ... );
    }

Everything else in the patch names both: the commit subject is
"barrier: add tests for smp_cond_load_*_timeout()", the suite name is
"smp-cond-load-*-timeout", and the new Kconfig help text correctly says
"smp_cond_load_relaxed_timeout() and smp_cond_load_acquire_timeout()".

MODULE_DESCRIPTION is user-visible via modinfo, so should both the
header comment and MODULE_DESCRIPTION name smp_cond_load_*_timeout()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33438155296
--===============8337952524881869404==--
