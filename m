From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v3 18/24] arm64: Add vDSO compat support
Date: Mon, 17 Dec 2018 07:26:16 -0800
Message-ID: <483c4226-b56d-69aa-1638-9f495d801273@android.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
 <20181213165746.56930-19-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213165746.56930-19-vincenzo.frascino@arm.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
List-Id: linux-arch.vger.kernel.org

On 12/13/2018 08:57 AM, Vincenzo Frascino wrote:
> This patch adds vDSO compat support to the arm64 building system.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   arch/arm64/Kconfig         |  1 +
>   arch/arm64/Makefile        | 21 +++++++++++++++++++--
>   arch/arm64/kernel/Makefile |  6 +++++-
>   3 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aafa18e2e7c4..ed9c36f0ccb9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -103,6 +103,7 @@ config ARM64
>   	select GENERIC_STRNLEN_USER
>   	select GENERIC_TIME_VSYSCALL
>   	select GENERIC_GETTIMEOFDAY
> +	select GENERIC_COMPAT_VDSO
>   	select HANDLE_DOMAIN_IRQ
>   	select HARDIRQS_SW_RESEND
>   	select HAVE_ACPI_APEI if (ACPI && EFI)
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6cb9fc7e9382..814d2b0ac017 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -49,9 +49,23 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
>     endif
>   endif
>   
> -KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
> +ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
> +  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
> +
> +  ifeq ($(CROSS_COMPILE_ARM32),)
> +    $(warning CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
> +  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
> +    $(error $(CROSS_COMPILE_ARM32)gcc not found, check CROSS_COMPILE_ARM32)
> +  else
> +    export CROSS_COMPILE_ARM32
> +    export CONFIG_COMPAT_VDSO := y
> +    compat_vdso := -DCONFIG_COMPAT_VDSO=1
> +  endif
> +endif
> +
> +KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
>   KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> -KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
> +KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
>   
>   KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>   KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
Does not build with clang

Do not hard-code gcc, use $(cc-name)

-- Mark
