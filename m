From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Date: Thu, 27 Feb 2020 17:35:39 -0800
Message-ID: <562edd23-9d86-800e-aae3-e54c92601929@linaro.org>
References: <20200227174417.23722-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41023 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbgB1Bfn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 20:35:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so550759plr.8
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 17:35:43 -0800 (PST)
In-Reply-To: <20200227174417.23722-1-broonie@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 2/27/20 9:44 AM, Mark Brown wrote:
>  * Binutils trunk supports the new ELF note, but this wasn't in a release
>    the last time I posted this series.  (The situation _might_ have changed
>    in the meantime...)

I believe this support is in binutils 2.32.


r~
