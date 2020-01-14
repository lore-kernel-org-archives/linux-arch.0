Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:55460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgANRej (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 12:34:39 -0500
Date: Tue, 14 Jan 2020 17:34:33 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 07/12] arm64: BTI: Decode BYTPE bits when printing
 PSTATE
Message-ID: <20200114173433.GK30444@arrakis.emea.arm.com>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-8-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211154206.46260-8-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20200114173433.H1m5Nj6q6S4V8Rc32AStT7MGqbcpgfpSwpIuLw56lPQ@z>

On Wed, Dec 11, 2019 at 03:42:01PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> The current code to print PSTATE symbolically when generating
> backtraces etc., does not include the BYTPE field used by Branch
> Target Identification.
> 
> So, decode BYTPE and print it too.
> 
> In the interests of human-readability, print the classes of BTI
> matched.  The symbolic notation, BYTPE (PSTATE[11:10]) and
> permitted classes of subsequent instruction are:
> 
>     -- (BTYPE=0b00): any insn
>     jc (BTYPE=0b01): BTI jc, BTI j, BTI c, PACIxSP
>     -c (BYTPE=0b10): BTI jc, BTI c, PACIxSP
>     j- (BTYPE=0b11): BTI jc, BTI j
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
