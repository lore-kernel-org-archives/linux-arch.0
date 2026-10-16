Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB12DA749;
	Fri, 16 Oct 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137333; cv=none; b=Dbxi83uTOwXj59eVl8eLpHky9hBGqGwYl+qd9Fyq+ODPZSH5w7mjoMl3XykJAqtVLyvg5Z0cSI+rP92nFFdFPEhynkODFnT3/xTJWChRN86PHL6xG2T/lAP54gRbYGvpZzU/sk6axk7P1fDdF8Th2hzg2WZEL0ArjWMzH8+bHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137333; c=relaxed/simple;
	bh=s2qkuz77nZb+KEAcPiNu4S5EkdFXyCs0e22k3+Jyfuo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OVAMfzRNNkvUHbFmwAC/VXCtHJQO+rjUIH3djQsZNv5fOHP3rl3Y1Ktnl4kUxr6/bwvD7Q8ZuMqZiwMk1BCQ4AD6g+pr1Vqxaz1qYzvTXdYWRB+sHkd5NLrCKmh6M/edXJnoFgp4vUWXHK/+x3yZEgWQmNOyNQvT1hIl+0q1I2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d79fYZ1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d79fYZ1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD101F000C4;
	Fri, 16 Oct 2026 07:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137331;
	bh=1G3X/wKLWQ8BtSB601M3ucPdAke4dgZzTbZ/O9Bh7aA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=d79fYZ1l/3iad7+p0OOm0c4iu1ttaMzqjl5q6/IAYOjO5oyKyDkxbXjMp2exDnFi8
	 ErcZPHJFK4lX7BbYenXGuGDmuiqS9oOWTdUgwyAwx6ulkRr/pjuMWvBLkAuqkMq4ii
	 Hf1lQJtKyzbdDvcFwfa8Jwce5iuXBk1uXnDl9xhH2RakAMVgdY8cGlJL6kPClo9ugg
	 Yv4R9CnT1A42bVkf71OFoVdjGEg56v89XoIds+2J1t4PPpP0gHIBBxZXq4DFqu/dXr
	 qSjmiX+ArNBuP/NDcWJ99efsQ+WyUDdWCkjqaQi7U2WF5Io3Huxda+4pe5vrBelwOn
	 bMeNRPIYTK4Vw==
Content-Type: multipart/mixed; boundary="===============7152762966294616627=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e8d14ff76206a79ef0d97847df7802345cf747603e554bb2c015c155113fd3f3@mail.kernel.org>
In-Reply-To: <20261016070837.440748-16-ankur.a.arora@oracle.com>
References: <20261016070837.440748-16-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v16 15/16] barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@kernel.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,boris.ostrovsky@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 07:55:29 +0000 (UTC)

--===============7152762966294616627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> barrier: timeout validity checks for smp_cond_load_relaxed_timeout()

TL;DR: Nits only, in the new KUnit test: iteration bounds print as unprefixed
hex ("10" for 16), which is confusing in test names, and a format string has a
stray double space.

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
> index 9c12cd36e7d2..88b374ceb78b 100644
> --- a/lib/tests/barrier-timeout-test.c
> +++ b/lib/tests/barrier-timeout-test.c

[ ... ]

> +static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *desc)
> +{
> +	char iters[32] = "";
> +
> +	if (p->miniters != -1)
> +		snprintf(iters, 32, ">= %llx", (u64)p->miniters);
> +	else if (p->maxiters != -1)
> +		snprintf(iters, 32, "%s %llx", p->maxiters == 0 ? "==" : "<=", (u64)p->maxiters);
> +
> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
> +		 "smp_cond_*_timeout: clock=%s,  timeout=%s, iterations %s",
> +		 "synthetic", p->desc, iters);
> +}

This isn't a bug, but would printing the iteration bound in decimal (%lld)
or with a 0x prefix make the test names easier to match against the checks?

With "%llx" and no prefix, the U32_MAX row (miniters = 1 << (32-28)) is
reported as "iterations >= 10" and the 1<<33 row (miniters = 1 << (33-28))
as "iterations >= 20", while test_smp_cond_relaxed() actually checks for
>= 16 and >= 32.  The timeout labels in the same table use the "1<<33"
style, so the hex counts read inconsistently in the KTAP output.

Also, is the double space after "clock=%s," in the format string intended?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38867477666
--===============7152762966294616627==--
