From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 04/23] arm64: Substitute gettimeofday with C
 implementation
Date: Fri, 22 Feb 2019 13:42:19 +0000
Message-ID: <20190222134219.GH42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-5-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-5-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 22, 2019 at 12:24:11PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 8cd4707f832a..c904b2a9b255 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -6,16 +6,31 @@
>  # Heavily based on the vDSO Makefiles for other archs.
>  #
>  
> -obj-vdso := gettimeofday.o note.o sigreturn.o
> +# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
> +# the inclusion of generic Makefile.
> +ARCH_REL_TYPE_ABS := R_AARCH64_JUMP_SLOT|R_AARCH64_GLOB_DAT|R_AARCH64_ABS64
> +include $(srctree)/lib/vdso/Makefile
> +
> +obj-vdso := vgettimeofday.o note.o sigreturn.o
>  
>  # Build rules
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
>  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>  
> -ccflags-y := -shared -fno-common -fno-builtin -ffixed-x18
> +ccflags-y := -shared -fno-common -fno-builtin -ffixed-x18 -fno-stack-protector
> +ccflags-y += -DDISABLE_BRANCH_PROFILING
>  ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
>  		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
>  
> +VDSO_LDFLAGS := -Bsymbolic
> +
> +CFLAGS_REMOVE_vgettimeofday.o = -pg -Os

Please use CC_FLAGS_FTRACE rather than '-pg'

What said, wouldn't it be better to come up with the VDSO cflags
entirely separately from what the main kernel uses?

That way we're unlikely to have any surprises in future with
instrumentation etc.

I strongly suspect you need to disable more things here, e.g. UBSAN,
KASAN, KCOV. Have you tried compiling a kernel with those features
enabled?

VDSO files probably also need to be marked as OBJECT_FILES_NON_STANDARD.

Thanks,
Mark.
