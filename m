Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1C38E10C;
	Mon, 31 Aug 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211010; cv=none; b=PwbPv0R8QefXvGHCmBejAE6G829ynHygKfOI19y9ilDI6b5Uw4oSyY398kOfxJUHurL+/LVsFOaKWP57bijXsuIr9UbuN6Bat2b5SpZAIsP/QrdW8GyMObVdTrVj8kSzeLVRyoHdvfT61PCZOGCHSgwgmAqxDu2N5EbbHU//9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211010; c=relaxed/simple;
	bh=oz2iYW11PJCarVGxxvigdGDmNXonQff7obHjaFc1C2Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LHs8ERpz8p/2noV4VlfnSqEJF05CTp8tBSOP+m9OmYvC6SmY7WGyaM6OPnDowJO8B7ciGyZSxoK3Z0/lfaQQpz8yhmdtiDSXpyYFGXYdq+p+L5MwPVqXRhEkEE87hayfd+IfL3elYmwppSuolazetcWofKIM75AsAdkLsIaGUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNFtUoIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNFtUoIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30521F000E9;
	Mon, 31 Aug 2026 21:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211009;
	bh=oz2iYW11PJCarVGxxvigdGDmNXonQff7obHjaFc1C2Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZNFtUoIkaJG9P6nVESZEqo0cw8CCz5EJVPRvJs8ZVXNKdKz4IJjg1camWm197RZlz
	 MDR7hlatcAzYrTWAvZrWX2yCuCTAZwSoxDPbLDSBfcz3q8oIeJLVEsttZTKtP46CB6
	 pRqT/Av541c2nbRGp0TfQRdCWSslD3K6TXhzBIDFq47Mg7VpP2HgKLzrjsi0P9r7ps
	 1nQO0jBWSQ3zxKCO8OmwCisJDJirzVb5DDtbDD5omEK+CgsDZsYJeCkqcElO08XB/P
	 bICqL3GGTmPdvi1Zm9dhVN3pPoDw/UbQ/B4pZsEg8UVAQC6FzHavrz/9kDSOoN3SFY
	 E/FLiLwVknf7w==
Content-Type: multipart/mixed; boundary="===============7237600942549384120=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <91b81ddb118dbeab295077ade10f2fdc9a6d4f09e5c5b07aff05a086215c7f90@mail.kernel.org>
In-Reply-To: <20260831202251.305046-8-ankur.a.arora@oracle.com>
References: <20260831202251.305046-8-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v15 07/16] atomic: Add atomic_cond_read_*_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,boqun.feng@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 21:16:47 +0000 (UTC)

--===============7237600942549384120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> atomic: Add atomic_cond_read_*_timeout()
>
> Add atomic load wrappers, atomic_cond_read_*_timeout() and
> atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.
>
> Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
> and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

The changelog states it will "add a short description" for these interfaces,
but looking at the actual changes, the documentation hunks only list the
function names under a new heading and insert the words "or conditional" into
an existing sentence.

Nothing in the patch explains what these operations do (spin-wait on a pointer
until a condition is true), what the timeout parameters mean, that the timeout
variants can return with the condition still false, or what ordering guarantees
the _relaxed vs _acquire variants provide.

Should the changelog be updated to say it lists the new operations in the API
section, or should a description matching what the changelog promises be added
to the SEMANTICS section of Documentation/atomic_t.txt?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33438155296
--===============7237600942549384120==--
