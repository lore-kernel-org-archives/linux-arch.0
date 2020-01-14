From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 05/12] elf: Allow arch to tweak initial mmap prot flags
Date: Tue, 14 Jan 2020 16:38:59 +0000
Message-ID: <20200114163859.GI30444@arrakis.emea.arm.com>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-6-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191211154206.46260-6-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.orgli
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 03:41:59PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> An arch may want to tweak the mmap prot flags for an
> ELFexecutable's initial mappings.  For example, arm64 is going to
> need to add PROT_BTI for executable pages in an ELF process whose
> executable is marked as using Branch Target Identification (an
> ARMv8.5-A control flow integrity feature).
> 
> So that this can be done in a generic way, add a hook
> arch_elf_adjust_prot() to modify the prot flags as desired: arches
> can select CONFIG_HAVE_ELF_PROT and implement their own backend
> where necessary.
> 
> By default, leave the prot flags unchanged.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
