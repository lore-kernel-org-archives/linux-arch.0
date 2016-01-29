From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Fri, 29 Jan 2016 22:24:31 +0100
Message-ID: <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
	<7619136.niuXthzi6R@wuerfel>
	<CAMuHMdX33SQe8n7SRda0TjQV05yP1zbuw129Jqjknt8=CY=LjA@mail.gmail.com>
	<19656457.qoKNGRmV4Q@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19656457.qoKNGRmV4Q@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Fengguang Wu <fengguang.wu@intel.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, linux-kbuild <linux-kbuild@vger.kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Michal Marek <mmarek@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Fri, Jan 29, 2016 at 9:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index c6b6175d0203..6cc09cf8618f 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1526,6 +1526,7 @@ config DEBUG_UART_PHYS
>         default 0xfffb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
>         default 0xfffe8600 if DEBUG_BCM63XX_UART
>         default 0xfffff700 if ARCH_IOP33X
> +       default 0xdeadbeef if DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || DEBUG_LL_UART_EFM32
>         depends on ARCH_EP93XX || \
>                 DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>                 DEBUG_LL_UART_EFM32 || \
> @@ -1628,6 +1629,7 @@ config DEBUG_UART_VIRT
>         default 0xff003000 if DEBUG_U300_UART
>         default 0xffd01000 if DEBUG_HIP01_UART
>         default DEBUG_UART_PHYS if !MMU
> +       default 0xdeadbeef if DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || DEBUG_LL_UART_EFM32
>         depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>                 DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
>                 DEBUG_NETX_UART || \
> diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
> index 7f7446f6f806..1191b1458586 100644
> --- a/arch/arm/include/debug/8250.S
> +++ b/arch/arm/include/debug/8250.S
> @@ -9,6 +9,9 @@
>   */
>  #include <linux/serial_reg.h>
>
> +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xe0000000

Any special reason for 0xe0000000 vs ...

> --- a/arch/arm/include/debug/efm32.S
> +++ b/arch/arm/include/debug/efm32.S
> @@ -6,6 +6,9 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000

0xf0000000?

> --- a/arch/arm/include/debug/pl01x.S
> +++ b/arch/arm/include/debug/pl01x.S
> @@ -10,6 +10,9 @@
>   * published by the Free Software Foundation.
>   *
>  */
> +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000

Likewise.

Gr{oetje,eeting}s,

                        Geert
