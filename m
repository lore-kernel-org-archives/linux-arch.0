Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C812D3727;
	Fri, 16 Oct 2026 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137342; cv=none; b=ptA0GXWV48D1a3GDDFbyrVbXhAut3bgHQcgNEiC4iyb5M2pFai9SljCeU3TY46RacqeGRWCrIyt9IgZLQz8cRvOpsdm8+jHnFH92TB2tX9jiqB6GuuQ7r/j2sQhT63c/DW5/PMhUHTVNMPPTCdyCMerl96K+FieDlEpAB0AT4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137342; c=relaxed/simple;
	bh=oGuTNCcaS/ru9gt9wOxR4fiDuG37+U6RlBOr7lQ3QlQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CCf2WsE9PB6WBEXrLyjY3ymatX1hwn+12uQ40C63YJPWiCFK8R45ho5gSKcR9+xYgpZdCb0lk+quJ6/MdaxuiHqV+DqlPEFU7JkepWDHJj9aZlLrYzpMk6+gfacRrS5qc+yj/L6X70bD9ZYlO2bXCohRa9bhQEGqGqltS4hXw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGJWk1Nd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGJWk1Nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331861F000C5;
	Fri, 16 Oct 2026 07:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137340;
	bh=LfnYK9wuqqNvQYXwL+C7ZhSJlmFE6g+Vm0Z+GDaNmYU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YGJWk1NdE3s6iWwTJlsbjI8oPUGeiGVdn00Uf/zNNuJ8svicsxzQ+ax9qYK0SRNE7
	 WCYC3ZrfXH3HMnDUKcddXsqYngI/SP3Ni59N9Z/5Dc9DUoCnCE0bpWz1l54skdrHZE
	 xsEWL6iGX33jCZczTzYCqapqxESUaa988Fd81gkRkuuXFj5eKe+FQcnyvNtgjS2OLO
	 pQYiYhitTbZkshOjKDjhKdHbFWUylzCZXzv7WJwtCWcF6z++yrGD1zEAU0ffDGjU33
	 gXQfCwQhlYuDG0kFeHLOTZtrdAvccooO7gV2fmeg278SmH43w0ssfzP1BEFx6C4/lV
	 YonIDIlyEOXFA==
Content-Type: multipart/mixed; boundary="===============6623771970694444259=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <afe82bcf3be90afbd548fc12aa07092f1216d45c90f5a6df7143c71657e566e4@mail.kernel.org>
In-Reply-To: <20261016070837.440748-15-ankur.a.arora@oracle.com>
References: <20261016070837.440748-15-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v16 14/16] barrier: add tests for smp_cond_load_*_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@kernel.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,boris.ostrovsky@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,julianbraha@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 07:55:38 +0000 (UTC)

--===============6623771970694444259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> barrier: add tests for smp_cond_load_*_timeout()

TL;DR: Nit only, in the KUnit test patch: the suite name
"smp-cond-load-*-timeout" and file name barrier-timeout-test.c may not follow
KUnit naming conventions (underscores, _kunit.c suffix).

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
> new file mode 100644
> index 000000000000..9c12cd36e7d2
> --- /dev/null
> +++ b/lib/tests/barrier-timeout-test.c
> @@ -0,0 +1,129 @@

[ ... ]

> +static struct kunit_suite barrier_timeout_test_suite = {
> +	.name = "smp-cond-load-*-timeout",
> +	.test_cases = barrier_timeout_test_cases,
> +};

this isn't a bug, but would a different suite name fit the KUnit naming
conventions better?

Documentation/dev-tools/kunit/style.rst asks for underscores rather than
dashes in suite names, and for the test file to be named
tests/<suite>_kunit.c.  The current name "smp-cond-load-*-timeout" uses
dashes and a literal '*', and the file is barrier-timeout-test.c.

Would something like smp_cond_load_timeout (with the file named
lib/tests/barrier_timeout_kunit.c or similar) work instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38867477666
--===============6623771970694444259==--
