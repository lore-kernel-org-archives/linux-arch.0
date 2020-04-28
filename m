From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Date: Tue, 28 Apr 2020 14:28:05 +0100
Message-ID: <20200428132804.GF6791@willie-the-truck>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200422154436.GJ4898@sirena.org.uk>
 <20200422162954.GF3585@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200422162954.GF3585@gaia>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 22, 2020 at 05:29:54PM +0100, Catalin Marinas wrote:
> On Wed, Apr 22, 2020 at 04:44:36PM +0100, Mark Brown wrote:
> > On Mon, Mar 16, 2020 at 04:50:42PM +0000, Mark Brown wrote:
> > > This patch series implements support for ARMv8.5-A Branch Target
> > > Identification (BTI), which is a control flow integrity protection
> > > feature introduced as part of the ARMv8.5-A extensions.
> > 
> > I've not resent this since the branch is still sitting in the arm64 tree
> > but it's also not in -next at the minute - is there anything you're
> > waiting for from my end here?
> 
> It's up to Will whether he wants a new series posted. The for-next/bti
> branch is complete AFAICT, only that normally we start queueing stuff
> (and push to -next) around -rc3.

I'm happy either way, but it would be nice to base other BTI patches on
top of this branch. Mark -- is it easier for you to refresh the series
against v5.7-rc3, or leave it like it is? Please just let me know either
way.

Thanks,

Will
