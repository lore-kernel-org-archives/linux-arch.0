Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D03F823B;
	Tue, 14 Jul 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016705; cv=none; b=BUx3ACeC5NjUm5lpiCkDYahPFFZMRCjtgJSqWRcCg+oQkUqoZvfNM5CYIsCQ/TMed8VWObdoAUeUnqcd887/TJMv4u1I//rvBdm4aiQRwXHY+xdLaGLvxmdHfluGcscXKeZ6xAAqyb6X23vO0rZFrWbeaxuQ9kgFIup2YS843i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016705; c=relaxed/simple;
	bh=CG97I99k1OzX+fMBjGHHU16gGs+Y941anRPECh9f7FY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hFac4nEE/p1LS1qpTBy2MhX/xqm2uHgeSmMcso6rSIkMWnGuR080g5STlqKE/3FZXwltwN0EmxVc0EJA8IIQc6pSp4Vs5Vu4dX8uUhK0mP+wzWk7V2hoPfO4uE+Wkjsx+c+0sYWR9Skf2ob52kH5QHjDFRLTIsj124oIaHVkejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj2GRs2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj2GRs2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7B91F00A3D;
	Tue, 14 Jul 2026 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016703;
	bh=uhhNINDBiC59vFpMCC14Vk72XYkJDy2FTBc8nnj9t3E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gj2GRs2wl2irznIrDvNpPnV4vkpGfKeI+3PSVbB0CyujGyPBFiY3ZMy79CveQ1to9
	 uvVMI39tRRXLXTc2j/JCxfw4D6UcLWhftueF19QMVUvZsQisjNa75Z+3I2e8teORtO
	 /+oNVXoKvZAkBPH4vf2Pq08kaWd2xOdf7mTnnyHbr3kFQrNYsaElHgegAL+MsUNZYV
	 zDbqzL0z7ug3iUjIZxJ3Zczp1WHiV+m2ZsZ1ASBqhY+Hl1x4g7O3rTSzdP6qkx/zf2
	 rB2BwgEdHqDrBoWuBWeKstawddVUwLVfFSl3dy2Wanro49mq+tTdAZFfnoZLNYLCc+
	 dsUq6GVWIW4ew==
Content-Type: multipart/mixed; boundary="===============0057947368761341553=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a80043974ca9edb08061f10579b253bfa019919fa162de90e6fe322ec8246274@mail.kernel.org>
In-Reply-To: <20260714073041.40250-11-ankur.a.arora@oracle.com>
References: <20260714073041.40250-11-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v14 10/15] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Jul 2026 08:11:43 +0000 (UTC)

--===============0057947368761341553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 0ec17ebb67c1..e5e27266b813 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c

[ ... ]

> @@ -269,6 +267,17 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
>   */
>  #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
>
> +/*
> + * Limit how often we invoke clock_deadlock() while spin-waiting in
> + * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
> + *
> + * We only override the default value not superceding ARM64's override.

this isn't a bug, but did you mean "superseding" rather than "superceding"
here?

> + */
> +#ifndef CONFIG_ARM64
> +#undef SMP_TIMEOUT_POLL_COUNT
> +#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
> +#endif


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29315652884
--===============0057947368761341553==--
