Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF552D3727;
	Fri, 16 Oct 2026 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137350; cv=none; b=e/xK4MASMIQwIMBdGZqwg0aReXm+WpW+0ssAXVLwisEmAguZZbAQxVxD3SxeT2mSwmzAICzYNN/PI4SK+u5l3NkeHfKuvYOQl16cTxk6ABHICjsc3vNN8DLBCIAY3IT77ZSNA4yYebpjIWY5mQjU7ZCnv0VCBStuLa44QsEeZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137350; c=relaxed/simple;
	bh=TdniLzRo1hTRlAo1ykO352wpdDwjJ6lcY5QPJBAW4cM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=k+l0CsmvHFh/1ZVoU01lOdJIoCwngQTbno3Z5M4bZ1B99PsFf/ocfU0Rm9jRVoz76f/U6uG7a5ej1zeAgYTMaBL775vqKtfbNSQ7GCMKWwQowotS0cVgbPuhCjEJdZGsrTA9tV0Z3m/liNym+V/VAVANAXskJJxdB/js9AU4Scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NanFW6pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NanFW6pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7151F000C4;
	Fri, 16 Oct 2026 07:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137345;
	bh=hYTRtpJK6XoBA3N+dDBXyNLDsg4zg0Esn2LKYeojMqI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NanFW6pzX2kLYD+V7Lt51tQlQXpvd6zHIpx3Vf9CVJOUxQpcoXbHa5dZBUJ5x/sAu
	 KCjCrCx44cM6wysD8p4gIpfO9Sfgj8uWx+9dcGnRn9ZQZQRu+jESb5c3x82g87hPoT
	 0K/3vflM987kHuyUc23miVbLSJ8RNCwhB62J1peEyGcZFH3kkEzzdZdqy9BJ4GxTey
	 OmQtZz9CqYWeXQx0sDv0WjoV41euHPNTXIT92/qo5i1JTEf/7HzPUTXtarpPuGi2N4
	 ZweDc/Es9YJ5Ge06EKxCbNp/8bjm/Yrq2lrSrvjU7r6xYLG8vw7RQDeywxWWrw2y/I
	 rCOj3cf94SFUA==
Content-Type: multipart/mixed; boundary="===============8446463070818369903=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ca104b0c215cbcdad7bb204b29ef90911a4e82ea03acc92f05da689a997af950@mail.kernel.org>
In-Reply-To: <20261016070837.440748-5-ankur.a.arora@oracle.com>
References: <20261016070837.440748-5-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v16 04/16] arm64: support WFET in smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@kernel.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,boris.ostrovsky@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 07:55:42 +0000 (UTC)

--===============8446463070818369903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> arm64: support WFET in smp_cond_load_relaxed_timeout()

TL;DR: Including asm/delay-const.h from asm/cmpxchg.h may break the arm64
build of drivers/gpio/gpio-aspeed.c, whose usecs_to_cycles() would conflict
with the new one; it appears unfixed by the series.

> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index 6cf3cd6873f5..30dca19c9a7b 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -12,6 +12,7 @@
>
>  #include <asm/barrier.h>
>  #include <asm/lse.h>
> +#include <asm/delay-const.h>

Can this include break the build of drivers/gpio/gpio-aspeed.c?

asm/cmpxchg.h is pulled into almost every arm64 translation unit through
linux/spinlock.h -> linux/atomic.h -> asm/atomic.h -> asm/cmpxchg.h, so the
static inlines in asm/delay-const.h become visible everywhere.

gpio-aspeed.c already defines a helper with the same name and a different
signature:

drivers/gpio/gpio-aspeed.c:
    static int usecs_to_cycles(struct aspeed_gpio *gpio, unsigned long usecs,
                               u32 *cycles)

while asm/delay-const.h now provides:

arch/arm64/include/asm/delay-const.h:
    static inline u64 usecs_to_cycles(u64 time_usecs)

That looks like it would fail with "conflicting types for 'usecs_to_cycles'".
GPIO_ASPEED depends on ARCH_ASPEED || COMPILE_TEST, and ARCH_ASPEED is an
arm64 platform, so arm64 allmodconfig/allyesconfig and any config enabling
CONFIG_GPIO_ASPEED would stop building at this commit.

The previous patch ("arm64/delay: move, fixup usecs_to_cycles()") renamed the
rpmh-rsc helpers for the same name clash, but gpio-aspeed.c was not touched.
No commit in the rest of the series modifies gpio-aspeed.c or delay-const.h,
so the breakage appears to remain at the end of the series.

Could the gpio-aspeed helper be renamed, could the delay-const.h helpers get
an arch-specific prefix, or could the cycle computation be moved out of line
so that asm/cmpxchg.h doesn't need to include asm/delay-const.h?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38867477666
--===============8446463070818369903==--
