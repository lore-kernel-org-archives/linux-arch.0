From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 19/26] arm64: vdso: Include common headers in the vdso
 library
Date: Sun, 15 Mar 2020 18:30:22 +0000
Message-ID: <20200315183021.GC32205@mbp>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-20-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200313154345.56760-20-vincenzo.frascino@arm.com>
Sender: linux-mips-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>Mark
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 13, 2020 at 03:43:38PM +0000, Vincenzo Frascino wrote:
> The vDSO library should only include the necessary headers required for
> a userspace library (UAPI and a minimal set of kernel headers). To make
> this possible it is necessary to isolate from the kernel headers the
> common parts that are strictly necessary to build the library.
> 
> Refactor the vdso implementation to include common headers.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
