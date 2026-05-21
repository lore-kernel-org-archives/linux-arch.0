Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7521A9B58;
	Thu, 21 May 2026 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779399992; cv=none; b=adiRsf3mXmVkVdOcReHNHwHdoQE9sjafu2DjOns9VsXkuepmFAUg9OzwdOLUrGel/cuvVHaowmZE0qMmYUoOUzF6u9++/Z5ozdmWmARm4ayR2T7LScTYhRmlTyq7oPQCiCJMBEkNUjS7uu3/N7c1ekeU/qBTGaLVRVRandO7KAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779399992; c=relaxed/simple;
	bh=egj+N/8dzxEVdKsTe8WaX6PQDQMTC4uQHbYIhFHm4y0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VM8JvPZTCYRCbnE4XK7YduLc8MVYj97YWhhV7EpXsHd7yTx9VFEUwTBCbL3vKJFhG26IUGdorhjVZMRoMIpqeS1lJAiNnsUHnB2ifDy82Pzmnv++1I6TnXJxsU2zkHtBuw6HUkcjPQUnGLLFkzUBpkQL6Y3+MAQHLaaDc5iTRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KsYqTJ5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KsYqTJ5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF031F000E9;
	Thu, 21 May 2026 21:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779399991;
	bh=qEpxywtKvyKc8pR0UbQITNwH/Hn/3Ki68Ju72Ok+Xeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KsYqTJ5zyrMd5A1ExmmDtQPu9yHezpY0U/H9UjN/u+a2IHt308AbfEh8k6kDioADF
	 RtCRqizHjDZU5gcWhZhCBkTOQxscLp8rono5FninvrJX74DZUaq1PP4y0QpG917uPa
	 iTdvlO/afgA7iKclb8Ltp9gRFnqX76vvfBTh8iD4=
Date: Thu, 21 May 2026 14:46:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-next@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
 catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 david.laight.linux@gmail.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
 Boqun Feng <boqun.feng@gmail.com>, Boqun Feng <boqun@kernel.org>, Christoph
 Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 1/2] kunit: add tests for smp_cond_load_*_timeout()
Message-Id: <20260521144629.11ee1e2ff88c5387a589f54a@linux-foundation.org>
In-Reply-To: <20260521083038.134260-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-15-ankur.a.arora@oracle.com>
	<20260521083038.134260-1-ankur.a.arora@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 01:30:37 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Add success and failure case tests for smp_cond_load_*_timeout().
> 
> All of the test cases wait on some state in smp_cond_load_*_timeout().
> In the success case we spawn a kthread that pokes the bit.
> 
> Success or failure cases depend on the expected bit being set (or not).
> Additionally in failure cases smp_cond_load_*_timeout() cannot return
> before timeout.

Your title "kunit: ..." implies that this is a kunit patchset.  ie, and
to my mind, this implies that the patchset makes changes to kunit
infrastructure.  This isn't the case, of course.

>
> ...
>  
> +config BARRIER_TIMEOUT_TEST
> +	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"

The patchset which attempted to add smp_cond_load_relaxed_timeout() was
titled "barrier: ...", which is a more appropriate identifier for this
patchset.

Anyway, I removed the series "barrier: Add
smp_cond_load_{relaxed,acquire}_timeout()" from mm.git on May 19 for
forgotten reasons.  So I suggest that the series be respun and resent,
with these two test patches included.

Again, I'm really not the guy to be handling these patches.  But a 4-6%
performance improvement in real world workloads is not to be ignored.

Not by me, anyway.

