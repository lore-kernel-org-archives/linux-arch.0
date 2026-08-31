Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273B3A3804;
	Mon, 31 Aug 2026 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211018; cv=none; b=FqH3/GsKjWlHkaHUHqeqBuoiOdrMg69FUVF8wb+P7RvGM8T7qRgYiRKQcwsW0WsIOyz8JWDx5njSZi/mzfiphZiaqp+2T5pYg3IVdbzFc7ArE5LKqvwEESyzKGJVwcthJv2Cuy7ox/qvS5r1l8pcD/Y8REKTOu2vChqRP916g4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211018; c=relaxed/simple;
	bh=aLsWq6mTYXLpbPI6MOH+G8a+tV87hSIKXi9aM75F7tU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tiCoogkENZ6uVoE/YjzX2zx6DXU6Skh4YLZf1tS64S7MRNjmcM6/rE41/9WjhZ6lHhkBn3waIxrV6LpmxvfnMhCa3bbhebfDQwFCutisZscs6cw7hh2txzjkL4FJz+iWG9+aL64Z8sXt9hrP+dldGHZ2pWeo9lPw4xE3CTFQM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNnHRH17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNnHRH17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229721F00A3D;
	Mon, 31 Aug 2026 21:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211017;
	bh=PFh4/3xyOKgfQ4/nEjqStHfW21LKL5WMdD7LihFSIaA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XNnHRH17HFtbbbpUMCFZFUYOISQJdwaYji/LlBXcV6RYez+wXk7e2BgPstsJ2PHwk
	 giFrp3+G5BnWyzCFv3xcJYuYCZS9ZYGKFWgeTLBr+JgBP77X7mRB5W4VmP/lAty6Hf
	 +BO7X2wmz3i0aPAx+EN0xa4awjnUC4MGAf1pzA+Pt02ppR0EZPWXK9dipW3DI2t/O4
	 Dc57p8iYXB+8jtvNxGhLMlsEXu9araEUo8tgmFknM2ADbiOl3pSOlZP76OpjdTt1Xa
	 3FoS8sWNxH/Neq4nWIbqZvFd11xgqEpx0H3/2A185GuGw4Tyztf+fo5YWvTCKmw7AE
	 ECVi2d3oY9Q0Q==
Content-Type: multipart/mixed; boundary="===============7660510954029895059=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2895763b954f1c233ec3c6fd4cf4c1f1af790941e719934a8c7628a4d3869e83@mail.kernel.org>
In-Reply-To: <20260831202251.305046-14-ankur.a.arora@oracle.com>
References: <20260831202251.305046-14-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v15 13/16] arm64/delay: enable testing smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 21:16:56 +0000 (UTC)

--===============7660510954029895059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> arm64/delay: enable testing smp_cond_load_relaxed_timeout()
>
> This enables the barrier tests to be built as a module.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

This isn't a bug, but half of the diff lands in
drivers/clocksource/arm_arch_timer.c, which has its own MAINTAINERS entry
(ARM ARCHITECTED TIMER, Marc Zyngier) and its own changelog prefix
convention (clocksource/drivers/arm_arch_timer: ...).

The subject uses only the arm64/delay prefix and the Cc/Ack lines name
only the arm64 maintainers, so the clocksource hunk is easy to miss when
the patch is routed or reviewed.

Would it help to either split the arm_arch_timer.c export into its own
clocksource-prefixed patch, or widen the subject/Cc so the clocksource
change is visible to its maintainer - and mention in the changelog that
the two symbols get pulled in via cpu_poll_relax()?

> diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
> index f08eacef2f0a..20bc2894b65b 100644
> --- a/arch/arm64/lib/delay.c
> +++ b/arch/arm64/lib/delay.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/timex.h>
> +#include <kunit/visibility.h>
>  #include <asm/delay-const.h>
>
>  #include <clocksource/arm_arch_timer.h>
> @@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
>  	guard(preempt_notrace)();
>  	return __arch_counter_get_cntvct_stable();
>  }
> +EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);
>
>  void __delay(unsigned long cycles)
>  {
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index cc9a8b399004..227447b19b14 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -28,6 +28,7 @@
>  #include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/ptp_kvm.h>
> +#include <kunit/visibility.h>
>
>  #include <asm/arch_timer.h>
>  #include <asm/virt.h>
> @@ -893,6 +894,7 @@ bool arch_timer_evtstrm_available(void)
>  	 */
>  	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
>
>  static struct arch_timer_kvm_info arch_timer_kvm_info;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33438155296
--===============7660510954029895059==--
