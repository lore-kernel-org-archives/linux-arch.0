Return-Path: <SRS0=hCVk=4O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41285 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgBZVpB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 16:45:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so299055pgm.8
        for <linux-arch@vger.kernel.org>; Wed, 26 Feb 2020 13:45:01 -0800 (PST)
Date: Wed, 26 Feb 2020 13:44:59 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 00/11] arm64: Branch Target Identification support
Message-ID: <202002261343.3B2ECE90@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-1-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20200226214459.2dpq2rZ63lPjGra9LdX07QjBsx93kgYRXAhTQUj-ZXE@z>

On Wed, Feb 26, 2020 at 03:57:03PM +0000, Mark Brown wrote:
> This patch series implements support for ARMv8.5-A Branch Target
> Identification (BTI), which is a control flow integrity protection
> feature introduced as part of the ARMv8.5-A extensions.
> 
> Changes:
> 
> v7:
>  - Rebase onto v5.6-rc3.
>  - Move comment about keeping NT_GNU_PROPERTY_TYPE_0 internal into first
>    patch.
>  - Add an explicit check for system_supports_bti() when parsing BTI ELF
>    property for improved robustness.

Looks good. I sent a few more Reviewed-bys where I could. Who is
expected to pick this up? Catalin? Will?

I'm excited to have both the ELF parser and BTI landed. :)

-Kees

-- 
Kees Cook
