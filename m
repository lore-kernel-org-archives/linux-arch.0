From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 5/5] ARM: asm/div64.h: adjust to generic codde
Date: Mon, 2 Nov 2015 23:03:38 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511022235430.630@knanqh.ubzr>
References: <201511030926.cD5HnGPU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33015 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbbKCEDm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Nov 2015 23:03:42 -0500
Received: by qgeo38 with SMTP id o38so3933105qge.0
        for <linux-arch@vger.kernel.org>; Mon, 02 Nov 2015 20:03:41 -0800 (PST)
In-Reply-To: <201511030926.cD5HnGPU%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

[added Mike/linux-clk and David/dri-devel]

A patch I produced is now highlighting existing bugs in the drivers 
listed below.

On Tue, 3 Nov 2015, kbuild test robot wrote:

> Hi Nicolas,
> 
> [auto build test WARNING on asm-generic/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicolas-Pitre/div64-h-optimize-do_div-for-power-of-two-constant-divisors/20151103-065348
> config: arm-multi_v7_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/arm/include/asm/div64.h:126:0,
>                     from include/linux/kernel.h:136,
>                     from include/asm-generic/bug.h:13,
>                     from arch/arm/include/asm/bug.h:62,
>                     from include/linux/bug.h:4,
>                     from include/linux/io.h:23,
>                     from include/linux/clk-provider.h:14,
>                     from drivers/clk/imx/clk-pllv1.c:1:
>    drivers/clk/imx/clk-pllv1.c: In function 'clk_pllv1_recalc_rate':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
> >> drivers/clk/imx/clk-pllv1.c:99:2: note: in expansion of macro 'do_div'
>      do_div(ll, mfd + 1);
>      ^

Here the problem is in clk-pllv1.c where the ll variable is declared as 
a long long. It should be an unsigned long long, or better yet an 
uint64_t or u64.

> --
>    In file included from arch/arm/include/asm/div64.h:126:0,
>                     from include/linux/kernel.h:136,
>                     from drivers/clk/imx/clk-pllv2.c:1:
>    drivers/clk/imx/clk-pllv2.c: In function '__clk_pllv2_recalc_rate':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
> >> drivers/clk/imx/clk-pllv2.c:103:2: note: in expansion of macro 'do_div'
>      do_div(temp, mfd + 1);
>      ^

Same thing: temp is declared as a s64. It should be u64.

>    drivers/clk/imx/clk-pllv2.c: In function '__clk_pllv2_set_rate':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
>    drivers/clk/imx/clk-pllv2.c:145:2: note: in expansion of macro 'do_div'
>      do_div(temp64, quad_parent_rate / 1000000);
>      ^

Ditto here.

> --
>    In file included from arch/arm/include/asm/div64.h:126:0,
>                     from include/linux/kernel.h:136,
>                     from drivers/clk/tegra/clk-divider.c:17:
>    drivers/clk/tegra/clk-divider.c: In function 'get_div':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
> >> drivers/clk/tegra/clk-divider.c:50:2: note: in expansion of macro 'do_div'
>      do_div(divider_ux1, rate);
>      ^

Ditto here.

> --
>    In file included from arch/arm/include/asm/div64.h:126:0,
>                     from include/linux/kernel.h:136,
>                     from drivers/clk/ti/clkt_dpll.c:17:
>    drivers/clk/ti/clkt_dpll.c: In function 'omap2_get_dpll_rate':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
> >> drivers/clk/ti/clkt_dpll.c:266:2: note: in expansion of macro 'do_div'
>      do_div(dpll_clk, dpll_div + 1);
>      ^

Ditto here.

> --
>    In file included from arch/arm/include/asm/div64.h:126:0,
>                     from include/linux/kernel.h:136,
>                     from include/linux/clk.h:16,
>                     from drivers/clk/ti/fapll.c:12:
>    drivers/clk/ti/fapll.c: In function 'ti_fapll_recalc_rate':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
> >> drivers/clk/ti/fapll.c:182:3: note: in expansion of macro 'do_div'
>       do_div(rate, fapll_p);
>       ^

Ditto here.

>    drivers/clk/ti/fapll.c: In function 'ti_fapll_synth_recalc_rate':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
>    drivers/clk/ti/fapll.c:346:3: note: in expansion of macro 'do_div'
>       do_div(rate, synth_div_freq);
>       ^

Ditto here.

> --
>    In file included from arch/arm/include/asm/div64.h:126:0,
>                     from include/linux/kernel.h:136,
>                     from include/linux/list.h:8,
>                     from include/linux/preempt.h:10,
>                     from include/linux/spinlock.h:50,
>                     from include/linux/mmzone.h:7,
>                     from include/linux/gfp.h:5,
>                     from include/linux/slab.h:14,
>                     from drivers/gpu/drm/nouveau/include/nvif/os.h:5,
>                     from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:3,
>                     from drivers/gpu/drm/nouveau/include/nvkm/core/event.h:3,
>                     from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:3,
>                     from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:3,
>                     from drivers/gpu/drm/nouveau/include/nvkm/subdev/clk.h:3,
>                     from drivers/gpu/drm/nouveau/nvkm/subdev/clk/priv.h:4,
>                     from drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:26:
>    drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c: In function 'gk20a_pllg_calc_rate':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^
>    drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:144:2: note: in expansion of macro 'do_div'
>      do_div(rate, divider);
>      ^
>    drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:144:2: warning: right shift count >= width of type
>    In file included from include/linux/kernel.h:136:0,
>                     from include/linux/list.h:8,
>                     from include/linux/preempt.h:10,
>                     from include/linux/spinlock.h:50,
>                     from include/linux/mmzone.h:7,
>                     from include/linux/gfp.h:5,
>                     from include/linux/slab.h:14,
>                     from drivers/gpu/drm/nouveau/include/nvif/os.h:5,
>                     from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:3,
>                     from drivers/gpu/drm/nouveau/include/nvkm/core/event.h:3,
>                     from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:3,
>                     from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:3,
>                     from drivers/gpu/drm/nouveau/include/nvkm/subdev/clk.h:3,
>                     from drivers/gpu/drm/nouveau/nvkm/subdev/clk/priv.h:4,
>                     from drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:26:
> >> arch/arm/include/asm/div64.h:49:20: warning: passing argument 1 of '__div64_32' from incompatible pointer type
>     #define __div64_32 __div64_32
>                        ^
> >> include/asm-generic/div64.h:235:11: note: in expansion of macro '__div64_32'
>       __rem = __div64_32(&(n), __base); \
>               ^
>    drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:144:2: note: in expansion of macro 'do_div'
>      do_div(rate, divider);
>      ^
>    arch/arm/include/asm/div64.h:32:24: note: expected 'uint64_t *' but argument is of type 'u32 *'
>     static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>                            ^

This one is a plain bug.

> --
>    In file included from arch/arm/include/asm/div64.h:126:0,
>                     from include/linux/kernel.h:136,
>                     from include/linux/list.h:8,
>                     from include/linux/preempt.h:10,
>                     from include/linux/spinlock.h:50,
>                     from include/linux/mmzone.h:7,
>                     from include/linux/gfp.h:5,
>                     from include/linux/slab.h:14,
>                     from drivers/gpu/drm//nouveau/include/nvif/os.h:5,
>                     from drivers/gpu/drm//nouveau/include/nvkm/core/os.h:3,
>                     from drivers/gpu/drm//nouveau/include/nvkm/core/event.h:3,
>                     from drivers/gpu/drm//nouveau/include/nvkm/core/device.h:3,
>                     from drivers/gpu/drm//nouveau/include/nvkm/core/subdev.h:3,
>                     from drivers/gpu/drm//nouveau/include/nvkm/subdev/clk.h:3,
>                     from drivers/gpu/drm//nouveau/nvkm/subdev/clk/priv.h:4,
>                     from drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:26:
>    drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c: In function 'gk20a_pllg_calc_rate':
>    include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
>      (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
>                                ^

This one is a driver bug too.

>    drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:144:2: note: in expansion of macro 'do_div'
>      do_div(rate, divider);
>      ^
>    drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:144:2: warning: right shift count >= width of type
>    In file included from include/linux/kernel.h:136:0,
>                     from include/linux/list.h:8,
>                     from include/linux/preempt.h:10,
>                     from include/linux/spinlock.h:50,
>                     from include/linux/mmzone.h:7,
>                     from include/linux/gfp.h:5,
>                     from include/linux/slab.h:14,
>                     from drivers/gpu/drm//nouveau/include/nvif/os.h:5,
>                     from drivers/gpu/drm//nouveau/include/nvkm/core/os.h:3,
>                     from drivers/gpu/drm//nouveau/include/nvkm/core/event.h:3,
>                     from drivers/gpu/drm//nouveau/include/nvkm/core/device.h:3,
>                     from drivers/gpu/drm//nouveau/include/nvkm/core/subdev.h:3,
>                     from drivers/gpu/drm//nouveau/include/nvkm/subdev/clk.h:3,
>                     from drivers/gpu/drm//nouveau/nvkm/subdev/clk/priv.h:4,
>                     from drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:26:
> >> arch/arm/include/asm/div64.h:49:20: warning: passing argument 1 of '__div64_32' from incompatible pointer type
>     #define __div64_32 __div64_32
>                        ^
> >> include/asm-generic/div64.h:235:11: note: in expansion of macro '__div64_32'
>       __rem = __div64_32(&(n), __base); \
>               ^
>    drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:144:2: note: in expansion of macro 'do_div'
>      do_div(rate, divider);
>      ^
>    arch/arm/include/asm/div64.h:32:24: note: expected 'uint64_t *' but argument is of type 'u32 *'
>     static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>                            ^
> 
> vim +/do_div +99 drivers/clk/imx/clk-pllv1.c
> 
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   @1  #include <linux/clk-provider.h>
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    2  #include <linux/io.h>
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    3  #include <linux/slab.h>
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    4  #include <linux/kernel.h>
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    5  #include <linux/err.h>
> 3a84d17b arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11    6  
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    7  #include "clk.h"
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    8  
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    9  /**
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   10   * pll v1
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   11   *
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   12   * @clk_hw	clock source
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   13   * @parent	the parent clock name
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   14   * @base	base address of pll registers
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   15   *
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   16   * PLL clock version 1, found on i.MX1/21/25/27/31/35
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   17   */
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   18  
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   19  #define MFN_BITS	(10)
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   20  #define MFN_SIGN	(BIT(MFN_BITS - 1))
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   21  #define MFN_MASK	(MFN_SIGN - 1)
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   22  
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   23  struct clk_pllv1 {
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   24  	struct clk_hw	hw;
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   25  	void __iomem	*base;
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   26  	enum imx_pllv1_type type;
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   27  };
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   28  
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   29  #define to_clk_pllv1(clk) (container_of(clk, struct clk_pllv1, clk))
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   30  
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   31  static inline bool is_imx1_pllv1(struct clk_pllv1 *pll)
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   32  {
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   33  	return pll->type == IMX_PLLV1_IMX1;
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   34  }
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   35  
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   36  static inline bool is_imx21_pllv1(struct clk_pllv1 *pll)
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   37  {
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   38  	return pll->type == IMX_PLLV1_IMX21;
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   39  }
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   40  
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   41  static inline bool is_imx27_pllv1(struct clk_pllv1 *pll)
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   42  {
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   43  	return pll->type == IMX_PLLV1_IMX27;
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   44  }
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   45  
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   46  static inline bool mfn_is_negative(struct clk_pllv1 *pll, unsigned int mfn)
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   47  {
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   48  	return !is_imx1_pllv1(pll) && !is_imx21_pllv1(pll) && (mfn & MFN_SIGN);
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   49  }
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   50  
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   51  static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   52  		unsigned long parent_rate)
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   53  {
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   54  	struct clk_pllv1 *pll = to_clk_pllv1(hw);
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   55  	long long ll;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   56  	int mfn_abs;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   57  	unsigned int mfi, mfn, mfd, pd;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   58  	u32 reg;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   59  	unsigned long rate;
> 2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   60  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   61  	reg = readl(pll->base);
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   62  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   63  	/*
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   64  	 * Get the resulting clock rate from a PLL register value and the input
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   65  	 * frequency. PLLs with this register layout can be found on i.MX1,
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   66  	 * i.MX21, i.MX27 and i,MX31
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   67  	 *
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   68  	 *                  mfi + mfn / (mfd + 1)
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   69  	 *  f = 2 * f_ref * --------------------
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   70  	 *                        pd + 1
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   71  	 */
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   72  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   73  	mfi = (reg >> 10) & 0xf;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   74  	mfn = reg & 0x3ff;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   75  	mfd = (reg >> 16) & 0x3ff;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   76  	pd =  (reg >> 26) & 0xf;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   77  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   78  	mfi = mfi <= 5 ? 5 : mfi;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   79  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   80  	mfn_abs = mfn;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   81  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   82  	/*
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   83  	 * On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   84  	 * 2's complements number.
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   85  	 * On i.MX27 the bit 9 is the sign bit.
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   86  	 */
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   87  	if (mfn_is_negative(pll, mfn)) {
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   88  		if (is_imx27_pllv1(pll))
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   89  			mfn_abs = mfn & MFN_MASK;
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   90  		else
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   91  			mfn_abs = BIT(MFN_BITS) - mfn;
> a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   92  	}
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   93  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   94  	rate = parent_rate * 2;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   95  	rate /= pd + 1;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   96  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   97  	ll = (unsigned long long)rate * mfn_abs;
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   98  
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11  @99  	do_div(ll, mfd + 1);
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11  100  
> 3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26  101  	if (mfn_is_negative(pll, mfn))
> a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11  102  		ll = -ll;
> 
> :::::: The code at line 99 was first introduced by commit
> :::::: a6dd3c812e774b876d440c1a9ec1bd0fd5659390 ARM: i.MX clk pllv1: move mxc_decode_pll code to its user
> 
> :::::: TO: Sascha Hauer <s.hauer@pengutronix.de>
> :::::: CC: Sascha Hauer <s.hauer@pengutronix.de>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
