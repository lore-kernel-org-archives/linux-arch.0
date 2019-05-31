From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 19/19] kselftest: Extend vDSO selftest
Date: Fri, 31 May 2019 10:53:39 +0200
Message-ID: <CAK8P3a3Z=wWQDu4aqV73J5PR2jNb3GzyWzYGT3dUp-F81H8mzQ@mail.gmail.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-20-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530141531.43462-20-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
List-Id: linux-arch.vger.kernel.org

On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +/*
> + * ARM64's vDSO exports its vDSO implementation with different names and
> + * a different version from other architectures, so we need to handle it
> + * as a special case.
> + */
> +#if defined(__aarch64__)
> +const char *version = "LINUX_2.6.39";
> +const char *name[4] = {
> +       "__kernel_gettimeofday",
> +       "__kernel_clock_gettime",
> +       "__kernel_time",
> +       "__kernel_clock_getres",
> +};
> +#else
> +/* Tested on x86, arm, mips */
> +const char *version = "LINUX_2.6";
> +const char *name[4] = {
> +       "__vdso_gettimeofday",
> +       "__vdso_clock_gettime",
> +       "__vdso_time",
> +       "__vdso_clock_getres",
> +};
> +#endif

I see the __kernel_* name used on arm64, powerpc and s390, whiel the __vdso_*
name is used on arm, mips, nds32, riscv, sparc, and x86.

Also the versions have more variants:

$ git ls-files arch | grep vdso | xargs grep
'\(LINUX_[2345]\|VDSO_VERSION_STRING\)'
arch/arm/vdso/vdso.lds.S:    LINUX_2.6 {
arch/arm64/kernel/vdso/vdso.lds.S:    LINUX_2.6.39 {
arch/mips/vdso/vdso.lds.S:    LINUX_2.6 {
arch/nds32/kernel/vdso/vdso.lds.S:    LINUX_4 {
arch/powerpc/include/asm/vdso.h:#define VDSO_VERSION_STRING    LINUX_2.6.15
arch/powerpc/kernel/vdso32/vdso32.lds.S:    VDSO_VERSION_STRING {
arch/powerpc/kernel/vdso64/vdso64.lds.S:    VDSO_VERSION_STRING {
arch/riscv/kernel/vdso/vdso.lds.S:    LINUX_4.15 {
arch/s390/include/asm/vdso.h:#define VDSO_VERSION_STRING    LINUX_2.6.29
arch/s390/kernel/vdso32/vdso32.lds.S:    VDSO_VERSION_STRING {
arch/s390/kernel/vdso64/vdso64.lds.S:    VDSO_VERSION_STRING {
arch/sparc/vdso/vdso.lds.S:    LINUX_2.6 {
arch/sparc/vdso/vdso32/vdso32.lds.S:    LINUX_2.6 {
arch/x86/entry/vdso/vdso.lds.S:    LINUX_2.6 {
arch/x86/entry/vdso/vdso32/vdso32.lds.S:    LINUX_2.6 {
arch/x86/entry/vdso/vdso32/vdso32.lds.S:    LINUX_2.5 {
arch/x86/entry/vdso/vdsox32.lds.S:    LINUX_2.6 {
arch/x86/um/vdso/vdso.lds.S:    LINUX_2.6 {

Maybe change the test case to just try all combinations of the
above (and __vdso_clock_gettime64 as well) and stop checking
the architecture?

       Arnd
