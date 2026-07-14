Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5EE3F823B;
	Tue, 14 Jul 2026 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016701; cv=none; b=ejK9c+dF1dhz6XRCpPjRacmin9+7p1KdFJzqY9ZTfCvJGM7bgquBilQYuW8uZxSruhcnmx2Eej/dqpJeafdrScYwz1sR++XwT8j5hDfP/WQUVtWnmR9eiszsquwRnBokNSX+1Nu7DFr6e53+ppX5eCJds1U0Nf5LbOLw57O4lFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016701; c=relaxed/simple;
	bh=EwFKmsYfl+bD1LLKuHxnLdbF0n0QqBWjHvd5uv38YHA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OCWtWStTCwvk8dgrYe9uHGDSsfliwTo2CIfXCuhteEVOpZeySjgPPaFnBYjxeh43IMqVWfLkgyVRRJRRiZNLTAYb5arhB00w/bJrVyPvgiNUT2gA39hGX4xQsgGc5tNmiELUcX9c21aD1Faa7Dt8Cqrl/vXLI4+mR6pMRW+ILqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMrRiQbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMrRiQbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B55C1F000E9;
	Tue, 14 Jul 2026 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016699;
	bh=OkAYUluhr6YaET7SYNVUxr0Dp4O9CKoxwBGmYn1WFVQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QMrRiQbSUJTKi269vkwvfFF8p4vJHa/WTG0TKyGdgwRFAqacT1WprLOQXpFgItCfZ
	 hgPmDXd0DTFRkENvaxWTUeOFxWLf9oFwb0rcrKmMGRuYGeJlc2OrpeYdk8iWTCOI5U
	 MlC4gjRsiejoAak2ncKtGyhk6duqixQDHqNntuQp+pfl5Vrm4k06xxV4N2I/8zM7be
	 PEO8rzNoYsnnHB7olATpQbYcZttDnSYXZc6hZqiWVEdbsAKvWylfpEqkGWaAinSzxf
	 PPUP1+lA/ht9YHKbNxXoiAIpdkeawyDFnzCkL7UqLS2XY5Kygpu0reqk4xaTQANps9
	 QBjOeFVEL9gJw==
Content-Type: multipart/mixed; boundary="===============9025402234174642696=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <13456576e105a6f6c9c4c26c2dda990659ac74afb4474c04cfa4d768c0f86e46@mail.kernel.org>
In-Reply-To: <20260714073041.40250-15-ankur.a.arora@oracle.com>
References: <20260714073041.40250-15-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v14 14/15] barrier: add tests for smp_cond_load_*_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,julianbraha@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Jul 2026 08:11:38 +0000 (UTC)

--===============9025402234174642696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1244dcac2294..07a06cfd820a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2551,6 +2551,16 @@ config FFS_KUNIT_TEST
>  	  For more information on KUnit and unit tests in general,
>  	  please refer to Documentation/dev-tools/kunit/.
>
> +config BARRIER_TIMEOUT_KUNIT_TEST
> +	tristate "KUnit tests for smp_cond_load_relaxed_timeout()" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds KUnit tests that validate wake-up and timeout handling paths
> +	  in smp_cond_load_relaxed_timeout().
> +
> +	  If unusure, say N.

This isn't a bug, but there's a small typo here: should this be 'unsure'
instead of 'unusure' to match the standard phrasing used by the neighboring
config entries?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29315652884
--===============9025402234174642696==--
