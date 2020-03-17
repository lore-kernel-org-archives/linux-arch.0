Return-Path: <SRS0=zClU=5C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:41546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgCQSt0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 14:49:26 -0400
Date: Tue, 17 Mar 2020 18:49:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200317184920.GI632169@arrakis.emea.arm.com>
References: <20200316165055.31179-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316165055.31179-1-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20200317184920.r_m2HZMjbd8ixqfOyv5-FaDW3V0JyhgSdvDz04e4Cpc@z>

On Mon, Mar 16, 2020 at 04:50:42PM +0000, Mark Brown wrote:
> Daniel Kiss (1):
>   mm: smaps: Report arm64 guarded pages in smaps
> 
> Dave Martin (11):
>   ELF: UAPI and Kconfig additions for ELF program properties
>   ELF: Add ELF program property parsing support
>   arm64: Basic Branch Target Identification support
>   elf: Allow arch to tweak initial mmap prot flags
>   arm64: elf: Enable BTI at exec based on ELF program properties
>   arm64: BTI: Decode BYTPE bits when printing PSTATE
>   arm64: unify native/compat instruction skipping
>   arm64: traps: Shuffle code to eliminate forward declarations
>   arm64: BTI: Reset BTYPE when skipping emulated instructions
>   KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions
>   arm64: BTI: Add Kconfig entry for userspace BTI
> 
> Mark Brown (1):
>   arm64: mm: Display guarded pages in ptdump

I provisionally pushed this patches to linux-next (and arm64
for-next/bti).

I'm not sure whether they'll make it into 5.7 yet (still missing acks on
the fs/* changes) but at least they'll get some wider exposure,
especially as they go outside arch/arm64/.

-- 
Catalin
