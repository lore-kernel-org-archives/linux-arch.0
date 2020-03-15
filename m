From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 21/26] arm64: Introduce asm/vdso/arch_timer.h
Date: Sun, 15 Mar 2020 18:32:16 +0000
Message-ID: <20200315183151.GE32205@mbp>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-22-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200313154345.56760-22-vincenzo.frascino@arm.com>
Sender: linux-mips-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>Mark
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 13, 2020 at 03:43:40PM +0000, Vincenzo Frascino wrote:
> The vDSO library should only include the necessary headers required for
> a userspace library (UAPI and a minimal set of kernel headers). To make
> this possible it is necessary to isolate from the kernel headers the
> common parts that are strictly necessary to build the library.
> 
> Introduce asm/vdso/arch_timer.h to contain all the arm64 specific
> code. This allows to replace the second isb() in __arch_get_hw_counter()
> with a fake dependent stack read of the counter which improves the vdso
> library peformances of ~4.5%. Below the results of vdsotest [1] ran for
> 100 iterations.

The subject seems to imply a non-functional change but as you read, it
gets a lot more complicated. Could you keep the functional change
separate from the header clean-up, maybe submit it as an independent
patch? And it shouldn't go in without Will's ack ;).

-- 
Catalin
