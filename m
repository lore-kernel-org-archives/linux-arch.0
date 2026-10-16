Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A737882A;
	Fri, 16 Oct 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137338; cv=none; b=JRScrtMTZuZm6b0xYvoWkq448WWwFel7otgETltWtiKI6cMD3Cq3JH9k8epIvRPTCbzvr/dDomdBAMQpE1B9vMI6L6nxAygixMHhEhfPodebjhHCVkB82SaW3RdS7ThAxThinIb3aIavuZGbkJmvIW8Gj6iZjWx4NyPTXYIPa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137338; c=relaxed/simple;
	bh=8dcLeq2ST8ULdfY192fZeXNuEtUPixp2SP6HkibGVqs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eaO5UZPbOwP5WiLsadiQwzMGh7C3e3q67D9K5v/xCyZH+Y0Wm+yiH44ebPwWYXk1KxLZ4ZXaxcwbxbYU27fCjrvTN8h1rdCCNE9UTq1amHWhLb47q4DXgqAJ75/WY6LJ7VEoKPSBZZm6pc3fjn9I4qPwpMgUWhb6GTFxFcerOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF+dKR6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF+dKR6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4851F000C4;
	Fri, 16 Oct 2026 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137336;
	bh=j6n/ZjZ2OIMP6lyuBqMBR5OqO2p3A3f429iS/YeL0TM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YF+dKR6yM5v6UDIIr8S+PXF1O+nlvbIgVGV7Y43J3ORBkjWrhKNjplk2d7AZmOSbB
	 Vsf7kRv5NVSuY0KkYzP2F2y7MagHAwM8yYDbHdlGLDtBTIcc7JNRlkUwsz7rLqZ92v
	 m3J0IjY3GGZO8Pb37VtVICMFG7sMkzIpoqKzuPKXOq2DrTCceZNnJnlezz9ahPqUXZ
	 2A78+1m1Wk9oLu0wpKvKnffi4uNz9bNsnT6+JnSlxO5KuplvDffRe568AmjLHS6GvK
	 qfwTNFBaNeELYts/xEUmof7v2O8/5uWYu/7vooKOLojn109xaXUIm2qk1eJhz6qNwk
	 yAJvdaC4Tu44w==
Content-Type: multipart/mixed; boundary="===============0314830124621368691=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <39f6de0b5e2388ef5857634f3df37a650c778e190b346409e4712064556c6aef@mail.kernel.org>
In-Reply-To: <20261016070837.440748-4-ankur.a.arora@oracle.com>
References: <20261016070837.440748-4-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v16 03/16] arm64/delay: move, fixup usecs_to_cycles()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@kernel.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,boris.ostrovsky@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,andersson@kernel.org,konradybcio@kernel.org,cl@linux.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 07:55:33 +0000 (UTC)

--===============0314830124621368691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> arm64/delay: move, fixup usecs_to_cycles()

TL;DR: The new generic usecs_to_cycles() in arm64 delay-const.h likely
conflicts with gpio-aspeed.c's function of the same name once a later patch
includes it, so arm64 builds with CONFIG_GPIO_ASPEED (allmodconfig, defconfig)
would fail.

> diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
> new file mode 100644
> index 000000000000..6ccdfe0a4130
> --- /dev/null
> +++ b/arch/arm64/include/asm/delay-const.h
> @@ -0,0 +1,35 @@

[ ... ]

> +static inline u64 usecs_to_cycles(u64 time_usecs)
> +{
> +	return xloops_to_cycles(time_usecs * __usecs_to_xloops_mult);
> +}

[ ... ]

Can these generic names conflict with other file-scope definitions once this
header is included widely?

The commit message says the rpmh-rsc.c helpers were renamed because they
"were occupying the same namespace", but drivers/gpio/gpio-aspeed.c also
defines a function with the same name and a different signature:

drivers/gpio/gpio-aspeed.c:
static int usecs_to_cycles(struct aspeed_gpio *gpio, unsigned long usecs,
		u32 *cycles)

Later in this series, commit 117729ec2d64 ("arm64: support WFET in
smp_cond_load_relaxed_timeout()") adds this to
arch/arm64/include/asm/cmpxchg.h:

+#include <asm/delay-const.h>

gpio-aspeed.c reaches it through:

linux/spinlock.h -> linux/atomic.h -> asm/atomic.h -> asm/cmpxchg.h ->
asm/delay-const.h

At that point 'static inline u64 usecs_to_cycles(u64)' and 'static int
usecs_to_cycles(struct aspeed_gpio *, unsigned long, u32 *)' are two
file-scope declarations of one identifier with incompatible types, which
should fail with "conflicting types for 'usecs_to_cycles'".

GPIO_ASPEED depends on ARCH_ASPEED || COMPILE_TEST, and ARCH_ASPEED is an
arm64 platform option that is enabled in arch/arm64/configs/defconfig.  So
it looks like any arm64 config enabling CONFIG_GPIO_ASPEED, including
allmodconfig and allyesconfig, would fail to build.

The build first breaks at 117729ec2d64, but the cause is the namespace
cleanup here only covering rpmh-rsc.c.  Nothing up to the end of the series
(c43dfae4ee10) changes the gpio-aspeed definition.

Would renaming the gpio-aspeed helper, or giving the arm64 helpers a
namespaced prefix (for example arch_ or __arm64_), avoid the collision?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38867477666
--===============0314830124621368691==--
