Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:55584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgANRhC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 12:37:02 -0500
Date: Tue, 14 Jan 2020 17:36:56 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 11/12] KVM: arm64: BTI: Reset BTYPE when skipping
 emulated instructions
Message-ID: <20200114173656.GN30444@arrakis.emea.arm.com>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-12-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211154206.46260-12-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20200114173656.rn5VA70Y3_HXsHUcR-_-f4ID9HhWKlC9_dasxE8NUTk@z>

On Wed, Dec 11, 2019 at 03:42:05PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> Since normal execution of any non-branch instruction resets the
> PSTATE BTYPE field to 0, so do the same thing when emulating a
> trapped instruction.
> 
> Branches don't trap directly, so we should never need to assign a
> non-zero value to BTYPE here.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
