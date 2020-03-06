From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Date: Fri, 6 Mar 2020 10:21:11 +0000
Message-ID: <20200306102111.GB2503422@arrakis.emea.arm.com>
References: <20200227174417.23722-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:59036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgCFKVR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 05:21:17 -0500
Content-Disposition: inline
In-Reply-To: <20200227174417.23722-1-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.c>

On Thu, Feb 27, 2020 at 05:44:06PM +0000, Mark Brown wrote:
> Dave Martin (10):
>   ELF: UAPI and Kconfig additions for ELF program properties
>   ELF: Add ELF program property parsing support
>   arm64: Basic Branch Target Identification support
>   elf: Allow arch to tweak initial mmap prot flags

Al, are you ok for patches 1, 2 and 4 in this series to be merged via
the arm64 tree? The full series is here:

https://lore.kernel.org/linux-arm-kernel/20200227174417.23722-1-broonie@kernel.org/

Thanks.

-- 
Catalin
