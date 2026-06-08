Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5A3B27DD;
	Mon,  8 Jun 2026 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908812; cv=none; b=G9zL68NNMPCXCPdKXCfzf9yU5kl9+ptg74yq3vbAWB5Ewoa2Q1LevHGmACjDROj8hRjdHOVl38Lg3neC9THGGj1SLE04HYrNF8qp/a6rI/QJ4e2/7LJw8viKg1kVGKQfJ9xgkPTAVvKik6vIH0QILVp9t6hBdtkTU+VViKZu64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908812; c=relaxed/simple;
	bh=6B1W3ma3hxCXw9RXyESCVcWs7eDQkLQq3XwwvVXIHDA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Va3S9D+ljuYjv3/H2fJhVVbfgwkSyvqh8QUOqF7H51ft41yL5uqYArOAQaprL34D2xXyAQM+dJCddHc1evP7+R/ZAT08hQy38m6dsrRlZFtB7D8MqeOesMrMjUZbM3f90In17hC8WP6T0/AqtgiQVHV0l1QnbO74zzkrcAa50A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhjIuQp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhjIuQp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F51F00893;
	Mon,  8 Jun 2026 08:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780908811;
	bh=aGkZcMBoAb+m8aY5hGGCVEYyH5C6dmJ8Ri3+vL0A/d8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fhjIuQp/Sup6o+sH0Z+zrskRvvuZfaaJITO4GbIdNebdzX5jnBc07vYHk8dWJB9WR
	 yE5JBOka/s+xDQy+CpvrNBPHQ3o6370lJMwur9CnIaDh94eYmGVrt3HqpLTGiGLtz4
	 XNVq6Z1OkRLsEt7V0WuaCnEkqNmQfdFvR9EYiJ+MdVc9jnZumiXmS27ia35iIAQrA0
	 u7QEDn7oLO5QiDPdyZcgS3aciwL2MXTc1tUML4R6VdCInYg+lOOfYdQj6CDfrxlfVX
	 IGXAlXAszT4xf+34dQdZ8C3QI3br29+cMutJROpEjDcUDgLTblYyD1UOktWHQCv23/
	 W9snBZHWFI+4A==
Content-Type: multipart/mixed; boundary="===============6216399173514572217=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23edac0734ee3ef334237165500d8f34e3c649081db7b3140a4a8596a202f339@mail.kernel.org>
In-Reply-To: <20260608080440.127491-3-ankur.a.arora@oracle.com>
References: <20260608080440.127491-3-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v12 02/15] arm64: barrier: Support smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 08:53:30 +0000 (UTC)

--===============6216399173514572217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fe60738e5943..fa676428ec3f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1606,6 +1606,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
>  config ARCH_DEFAULT_CRASH_DUMP
>  	def_bool y
>
> +config ARCH_HAS_CPU_RELAX
> +	def_bool y
> +

ARCH_HAS_CPU_RELAX isn't private to the barrier code.  Before this it was
defined only by arch/x86, and the generic kernel already keys cpuidle
behavior off it in two places that arm64 builds.

In drivers/cpuidle/Makefile:

  obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o

and in drivers/acpi/processor_idle.c:

  #define ACPI_IDLE_STATE_START	(IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX) ? 1 : 0)
  ...
  if (IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX)) {
          cpuidle_poll_state_init(drv);
          count = 1;
  }

On arm64, ACPI_PROCESSOR is "default y" and depends on ARM64, and it
selects ACPI_PROCESSOR_IDLE which selects CPU_IDLE.  So on an ACPI arm64
system this now builds poll_state.o and makes acpi_processor_setup_cstates()
register a POLL idle state as C-state index 0, shifting the firmware
C-states up by one.

The commit message describes this symbol only as indicating "an optimized
implementation of cpu_poll_relax()", and the generic patch describes it as
"a cpu_poll_relax() implementation that is expected to be cheaper".  Neither
mentions the cpuidle/ACPI poll_state side effect.

Is enabling the cpuidle polling idle state on arm64 intended here, or is
ARCH_HAS_CPU_RELAX only meant to feed smp_cond_load_relaxed_timeout()?  If
the latter, would a dedicated symbol (or decoupling poll_state/ACPI from
ARCH_HAS_CPU_RELAX) avoid the unintended idle-path change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27125050324
--===============6216399173514572217==--
