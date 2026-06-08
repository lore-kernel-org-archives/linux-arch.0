Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DF3B38AD;
	Mon,  8 Jun 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908810; cv=none; b=IPR0iLGE7Ad9RhGVdk6g08ePfm+EPNXkEjMwSMeZQ7tgzz+VGAFm2zgdfnqkB5qWSOYVnsNdxaw+MX12enpwUcwPEjltBOq7hp4XGcqotcIDscSCJr22IVBXFH0M+EKdNooXiWLj6JWqbpGl75dev8K62PZPVVUh6pPiaeeKXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908810; c=relaxed/simple;
	bh=0A/4qgz7V37XkWKp81nr1ju0+HrS3Ckcr53+kz7lpd0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LTU62Y5isrXW7kTaiFB4Dwp+5XozgLWVLSwWRl8AgOCiYVxFPRxJkIkUYpJyAooPxOULBrL7ZpoHo97NF6RE9777sVsR9aDu8+JL2owH3OOTAnDYbStXUK4EeUKXLOEmW1PyA4d3Pr1HEHoVjWPxqQEw//ZcURcOcm7SnD7lHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8xII/GV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8xII/GV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5341F00898;
	Mon,  8 Jun 2026 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780908808;
	bh=X5WIB6+IF+GEKqPs7/UInOgY+sgeIKBLyzEDOT1v6dw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X8xII/GV8sYmFYayedmQje5m1D+LBT8DiL6GX/J6/8sIN+5bX4DKD5sO/h0h/XV55
	 urHIGa04gwnGu1gaGx4yZuyfA3ugx8FGdYrWuxHpoGS9TlqGLFmmo6meHC9/4RjlnX
	 mcbU5FidMfRzi9CbzZlXvcSYo5H0K7VRGWN0K3WXBcKWRHr7UQF7hp4BNMAWewhPec
	 0UEL1B0xeHv+AIAx49Y7/gGfLr0yIcKBDKFO+H83mC+fBtxg3AczLG8gkIbsRfGSgv
	 8x5qe6xLRjxoWD8lZAaDdepLCRvKF2GAB5Me0I3Ca+xIFF/IMvbxI561S6OAtEy3Yf
	 ncf8Qm+SzSUhw==
Content-Type: multipart/mixed; boundary="===============7231439017758036295=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <04f6ed5fe4f00805ba2eeb5f5d1b6f6d731cabcd00bd74fe11c060fd828131a9@mail.kernel.org>
In-Reply-To: <20260608080440.127491-6-ankur.a.arora@oracle.com>
References: <20260608080440.127491-6-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v12 05/15] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 08:53:28 +0000 (UTC)

--===============7231439017758036295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
> index 9ea0a74e5892..a385603436e9 100644
> --- a/arch/arm64/include/asm/rqspinlock.h
> +++ b/arch/arm64/include/asm/rqspinlock.h
> @@ -3,91 +3,6 @@
>  #define _ASM_RQSPINLOCK_H
>
>  #include <asm/barrier.h>
> -
> -/*
> - * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
> - * version based on [0]. In rqspinlock code, our conditional expression involves
> - * checking the value _and_ additionally a timeout. However, on arm64, the
> - * WFE-based implementation may never spin again if no stores occur to the
> - * locked byte in the lock word. As such, we may be stuck forever if
> - * event-stream based unblocking is not available on the platform for WFE spin
> - * loops (arch_timer_evtstrm_available).
> - *

[ ... ]

> -#endif
> -
> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
> -
>  #include <asm-generic/rqspinlock.h>

With res_smp_cond_load_acquire removed here, does arm64 now fall back to
the generic definition in kernel/bpf/rqspinlock.c?

  #ifndef res_smp_cond_load_acquire
  #define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
  #endif

On arm64, smp_cond_load_acquire() uses __cmpwait_relaxed(), which issues a
WFE that wakes only on a store to the monitored cache line or on an
event-stream tick.

The consumer is resilient_queued_spin_lock_slowpath():

  kernel/bpf/rqspinlock.c:
      res_smp_cond_load_acquire(&lock->locked,
          !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));

The RES_CHECK_TIMEOUT() escape is part of cond_expr, so it is only
re-evaluated when smp_cond_load_acquire() returns from its WFE.

On platforms where arch_timer_evtstrm_available() is false, if the current
lock owner is stuck or dead and issues no further store to lock->locked,
can the WFE ever wake, and can the RES_CHECK_TIMEOUT timeout ever fire?

This looks like the exact case the removed comment described:

> - * checking the value _and_ additionally a timeout. However, on arm64, the
> - * WFE-based implementation may never spin again if no stores occur to the
> - * locked byte in the lock word. As such, we may be stuck forever if
> - * event-stream based unblocking is not available on the platform for WFE spin
> - * loops (arch_timer_evtstrm_available).

The removed private copy avoided this by falling back to a cpu_relax()-based
spinwait that always re-checks the timeout when the event stream is
unavailable.

Forward search of the series shows this is resolved by the later commit
7abb03c21db2 ("bpf/rqspinlock: Use smp_cond_load_acquire_timeout()"), which
switches rqspinlock to smp_cond_load_acquire_timeout(); on arm64 that uses
a waiting implementation handling the timeout and event-stream-absent case.
Should the change-over happen in the same commit, or is the window where a
kernel built or bisected at this commit can block indefinitely acceptable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27125050324
--===============7231439017758036295==--
