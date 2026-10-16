Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB62443C32;
	Fri, 16 Oct 2026 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137352; cv=none; b=tV5Kii1kbRPMq7hCqOJufArcuKVAGDmAeiXwiX8OfbKVLwIUU9/e9yHdb86oEB5ZIN4qxRzjZE36Zmt+WRBtOUoztoqEdO+sA8JcddljM6+3fNyeM0nw9BSrhloUn/sWya37pP6EcEIZJCXR3Rtc8r+rhbrYjoGjjwdueUffCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137352; c=relaxed/simple;
	bh=bbXnBjOMLoUFMUW/PbmA12pnO04WnrRGpNpDsUHGWE8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Bw18H+I/8w+2UQpBMMFoQu1WlynroDU67ZySjSGgYQBzrj9Qg4/UwMiHtsgQwFviKFlXhmIqf87+dp6CZ6BQ/SlyHKdgsMb5rDlULJKulG+TwZCJYS017LXIuch2V4QpIozgBbVJkzEU/xCKxQMsF12X5DIeqo2SNiPrd9xN4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwrH0AcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwrH0AcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092881F000C5;
	Fri, 16 Oct 2026 07:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137349;
	bh=KCKGc1h3JuJ4XsRCss0FTfTKjcZRv6QTRQ+XtcBdPNA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NwrH0AcTPiVX5vUvCVczRIw4WfrsxvozuDI0Gn5OuBTjM6wESPqJg50kAL5Gz41w1
	 VFzhaNnMpy6zfPMqtjQv0s9oRcC3XMJb6dNMOz0DD8ANIHkHo5PNJsS+iuScc3WXip
	 5OqkowMfjyzWwYnPtstJGHF2wizwg70s/TxL4/PmlhCPwsn5JTY7P5JMuGTmfq1UUc
	 dqg/iXoubZlla1oO8/wXpWKPv6FRMjVnqKAGaxDcs2/i16m6RWbd5tzvdx1is5n/Hr
	 K8OAqkjkjtNG6epXDHiEgYcTfas0jtMxseJF1J1v7+Wdb1oJTzgMs4wKlmcLinWuis
	 Ny869A5cn941w==
Content-Type: multipart/mixed; boundary="===============8960242286083874251=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b0e8ca62af5ba9b15ad83c3f4a2e78f0c50e17adf28cb7979a4c8f8ad6294a8@mail.kernel.org>
In-Reply-To: <20261016070837.440748-2-ankur.a.arora@oracle.com>
References: <20261016070837.440748-2-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v16 01/16] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@kernel.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,boris.ostrovsky@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 07:55:46 +0000 (UTC)

--===============8960242286083874251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> asm-generic: barrier: Add smp_cond_load_relaxed_timeout()

TL;DR: Nit only: the kernel-doc comment in asm-generic/barrier.h binds to the
internal __smp_cond_load_relaxed_timeout() helper, causing a new kernel-doc
warning; it should move above the public macro.

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index b99cb57dfccc..ac0a8b5e0ffe 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h

[ ... ]

> @@ -273,6 +274,115 @@ do {									\
>  })
>  #endif
>

[ ... ]

> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on.
> + * @cond_expr: boolean expression to wait for.

[ ... ]

> + * dependent ways.
> + */
> +#ifndef smp_cond_load_relaxed_timeout
> +#define __smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\

[ ... ]

> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\

[ ... ]

Does the kernel-doc comment above attach to the right macro?  It sits
directly above "#ifndef smp_cond_load_relaxed_timeout" followed by the
"#define __smp_cond_load_relaxed_timeout(" helper, so kernel-doc skips the
#ifndef and binds the comment to the internal helper:

  $ tools/docs/kernel-doc -none include/asm-generic/barrier.h
  Warning: include/asm-generic/barrier.h expecting prototype for
  smp_cond_load_relaxed_timeout(). Prototype was for
  __smp_cond_load_relaxed_timeout() instead

The parent commit produces no kernel-doc warnings for this header, and the
warning is still present at the end of the series, so no later patch
addresses it.  The public smp_cond_load_relaxed_timeout() macro ends up
with no kernel-doc.

Could the /** block be moved down so it sits directly above
"#define smp_cond_load_relaxed_timeout(", with the
__smp_cond_load_relaxed_timeout() helper getting a plain /* comment?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38867477666
--===============8960242286083874251==--
