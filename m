Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40186 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfJKNTx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 09:19:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so10197274wmj.5
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2019 06:19:51 -0700 (PDT)
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-5-git-send-email-Dave.Martin@arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 04/12] arm64: docs: cpu-feature-registers: Document
 ID_AA64PFR1_EL1
In-reply-to: <1570733080-21015-5-git-send-email-Dave.Martin@arm.com>
Date: Fri, 11 Oct 2019 14:19:48 +0100
Message-ID: <87zhi7l8qz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <richard.henderson@linaro.org>, Sudakshina Das <sudi.das@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191011131948.v4L8K-yJoN4R1QMNYGF9c2KVpp4t2vdKoDd_uKCpFqM@z>


Dave Martin <Dave.Martin@arm.com> writes:

> Commit d71be2b6c0e1 ("arm64: cpufeature: Detect SSBS and advertise
> to userspace") exposes ID_AA64PFR1_EL1 to userspace, but didn't
> update the documentation to match.
>
> Add it.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>
> ---
>
> Note to maintainers:
>
>  * This patch has been racing with various other attempts to fix
>    the same documentation in the meantime.
>
>    Since this patch only fixes the documenting for pre-existing
>    features, it can safely be dropped if appropriate.
>
>    The _new_ documentation relating to BTI feature reporting
>    is in a subsequent patch, and needs to be retained.
> ---
>  Documentation/arm64/cpu-feature-registers.rst | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentatio=
n/arm64/cpu-feature-registers.rst
> index 2955287..b86828f 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -168,8 +168,15 @@ infrastructure:
>       +------------------------------+---------+---------+
>
>
> -  3) MIDR_EL1 - Main ID Register
> +  3) ID_AA64PFR1_EL1 - Processor Feature Register 1
> +     +------------------------------+---------+---------+
> +     | Name                         |  bits   | visible |
> +     +------------------------------+---------+---------+
> +     | SSBS                         | [7-4]   |    y    |
> +     +------------------------------+---------+---------+
> +
>
> +  4) MIDR_EL1 - Main ID Register
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
>       +------------------------------+---------+---------+
> @@ -188,7 +195,7 @@ infrastructure:
>     as available on the CPU where it is fetched and is not a system
>     wide safe value.
>
> -  4) ID_AA64ISAR1_EL1 - Instruction set attribute register 1
> +  5) ID_AA64ISAR1_EL1 - Instruction set attribute register 1

If I'm not mistaken .rst has support for auto-enumeration if the #
character is used. That might reduce the pain of re-numbering in future.

>
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
> @@ -210,7 +217,7 @@ infrastructure:
>       | DPB                          | [3-0]   |    y    |
>       +------------------------------+---------+---------+
>
> -  5) ID_AA64MMFR2_EL1 - Memory model feature register 2
> +  6) ID_AA64MMFR2_EL1 - Memory model feature register 2
>
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |
> @@ -218,7 +225,7 @@ infrastructure:
>       | AT                           | [35-32] |    y    |
>       +------------------------------+---------+---------+
>
> -  6) ID_AA64ZFR0_EL1 - SVE feature ID register 0
> +  7) ID_AA64ZFR0_EL1 - SVE feature ID register 0
>
>       +------------------------------+---------+---------+
>       | Name                         |  bits   | visible |


--
Alex Benn=C3=A9e
