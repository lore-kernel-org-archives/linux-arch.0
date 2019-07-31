From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: vdso: Fix Makefile regression
Date: Wed, 31 Jul 2019 18:09:27 +0100
Message-ID: <20190731170927.GD17773@arrakis.emea.arm.com>
References: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
 <20190729125421.32482-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190729125421.32482-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org, Matteo Croce <mcroce@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 29, 2019 at 01:54:21PM +0100, Vincenzo Frascino wrote:
> Using an old .config in combination with "make oldconfig" can cause
> an incorrect detection of the compat compiler:
> 
> $ grep CROSS_COMPILE_COMPAT .config
> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
> 
> $ make oldconfig && make
> arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.
> Stop.
> 
> Accordingly to the section 7.2 of the GNU Make manual "Syntax of
> Conditionals", "When the value results from complex expansions of
> variables and functions, expansions you would consider empty may
> actually contain whitespace characters and thus are not seen as
> empty. However, you can use the strip function to avoid interpreting
> whitespace as a non-empty value."
> 
> Fix the issue adding strip to the CROSS_COMPILE_COMPAT string
> evaluation.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Matteo Croce <mcroce@redhat.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Queued for 5.3-rc3. Thanks.

-- 
Catalin
