From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 5/5] ARM: asm/div64.h: adjust to generic codde
Date: Tue, 3 Nov 2015 09:25:28 +0800
Message-ID: <201511030926.cD5HnGPU%fengguang.wu@intel.com>
References: <1446503610-6942-6-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17715 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbbKCB0U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Nov 2015 20:26:20 -0500
Content-Disposition: inline
In-Reply-To: <1446503610-6942-6-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: kbuild-all@01.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicolas,

[auto build test WARNING on asm-generic/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Pitre/div64-h-optimize-do_div-for-power-of-two-constant-divisors/20151103-065348
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/div64.h:126:0,
                    from include/linux/kernel.h:136,
                    from include/asm-generic/bug.h:13,
                    from arch/arm/include/asm/bug.h:62,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/imx/clk-pllv1.c:1:
   drivers/clk/imx/clk-pllv1.c: In function 'clk_pllv1_recalc_rate':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
>> drivers/clk/imx/clk-pllv1.c:99:2: note: in expansion of macro 'do_div'
     do_div(ll, mfd + 1);
     ^
--
   In file included from arch/arm/include/asm/div64.h:126:0,
                    from include/linux/kernel.h:136,
                    from drivers/clk/imx/clk-pllv2.c:1:
   drivers/clk/imx/clk-pllv2.c: In function '__clk_pllv2_recalc_rate':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
>> drivers/clk/imx/clk-pllv2.c:103:2: note: in expansion of macro 'do_div'
     do_div(temp, mfd + 1);
     ^
   drivers/clk/imx/clk-pllv2.c: In function '__clk_pllv2_set_rate':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
   drivers/clk/imx/clk-pllv2.c:145:2: note: in expansion of macro 'do_div'
     do_div(temp64, quad_parent_rate / 1000000);
     ^
--
   In file included from arch/arm/include/asm/div64.h:126:0,
                    from include/linux/kernel.h:136,
                    from drivers/clk/tegra/clk-divider.c:17:
   drivers/clk/tegra/clk-divider.c: In function 'get_div':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
>> drivers/clk/tegra/clk-divider.c:50:2: note: in expansion of macro 'do_div'
     do_div(divider_ux1, rate);
     ^
--
   In file included from arch/arm/include/asm/div64.h:126:0,
                    from include/linux/kernel.h:136,
                    from drivers/clk/ti/clkt_dpll.c:17:
   drivers/clk/ti/clkt_dpll.c: In function 'omap2_get_dpll_rate':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
>> drivers/clk/ti/clkt_dpll.c:266:2: note: in expansion of macro 'do_div'
     do_div(dpll_clk, dpll_div + 1);
     ^
--
   In file included from arch/arm/include/asm/div64.h:126:0,
                    from include/linux/kernel.h:136,
                    from include/linux/clk.h:16,
                    from drivers/clk/ti/fapll.c:12:
   drivers/clk/ti/fapll.c: In function 'ti_fapll_recalc_rate':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
>> drivers/clk/ti/fapll.c:182:3: note: in expansion of macro 'do_div'
      do_div(rate, fapll_p);
      ^
   drivers/clk/ti/fapll.c: In function 'ti_fapll_synth_recalc_rate':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
   drivers/clk/ti/fapll.c:346:3: note: in expansion of macro 'do_div'
      do_div(rate, synth_div_freq);
      ^
--
   In file included from arch/arm/include/asm/div64.h:126:0,
                    from include/linux/kernel.h:136,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:5,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/event.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/subdev/clk.h:3,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/clk/priv.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:26:
   drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c: In function 'gk20a_pllg_calc_rate':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
   drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:144:2: note: in expansion of macro 'do_div'
     do_div(rate, divider);
     ^
   drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:144:2: warning: right shift count >= width of type
   In file included from include/linux/kernel.h:136:0,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from drivers/gpu/drm/nouveau/include/nvif/os.h:5,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/os.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/event.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/device.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h:3,
                    from drivers/gpu/drm/nouveau/include/nvkm/subdev/clk.h:3,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/clk/priv.h:4,
                    from drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:26:
>> arch/arm/include/asm/div64.h:49:20: warning: passing argument 1 of '__div64_32' from incompatible pointer type
    #define __div64_32 __div64_32
                       ^
>> include/asm-generic/div64.h:235:11: note: in expansion of macro '__div64_32'
      __rem = __div64_32(&(n), __base); \
              ^
   drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c:144:2: note: in expansion of macro 'do_div'
     do_div(rate, divider);
     ^
   arch/arm/include/asm/div64.h:32:24: note: expected 'uint64_t *' but argument is of type 'u32 *'
    static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
                           ^
--
   In file included from arch/arm/include/asm/div64.h:126:0,
                    from include/linux/kernel.h:136,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from drivers/gpu/drm//nouveau/include/nvif/os.h:5,
                    from drivers/gpu/drm//nouveau/include/nvkm/core/os.h:3,
                    from drivers/gpu/drm//nouveau/include/nvkm/core/event.h:3,
                    from drivers/gpu/drm//nouveau/include/nvkm/core/device.h:3,
                    from drivers/gpu/drm//nouveau/include/nvkm/core/subdev.h:3,
                    from drivers/gpu/drm//nouveau/include/nvkm/subdev/clk.h:3,
                    from drivers/gpu/drm//nouveau/nvkm/subdev/clk/priv.h:4,
                    from drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:26:
   drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c: In function 'gk20a_pllg_calc_rate':
   include/asm-generic/div64.h:217:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
   drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:144:2: note: in expansion of macro 'do_div'
     do_div(rate, divider);
     ^
   drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:144:2: warning: right shift count >= width of type
   In file included from include/linux/kernel.h:136:0,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from drivers/gpu/drm//nouveau/include/nvif/os.h:5,
                    from drivers/gpu/drm//nouveau/include/nvkm/core/os.h:3,
                    from drivers/gpu/drm//nouveau/include/nvkm/core/event.h:3,
                    from drivers/gpu/drm//nouveau/include/nvkm/core/device.h:3,
                    from drivers/gpu/drm//nouveau/include/nvkm/core/subdev.h:3,
                    from drivers/gpu/drm//nouveau/include/nvkm/subdev/clk.h:3,
                    from drivers/gpu/drm//nouveau/nvkm/subdev/clk/priv.h:4,
                    from drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:26:
>> arch/arm/include/asm/div64.h:49:20: warning: passing argument 1 of '__div64_32' from incompatible pointer type
    #define __div64_32 __div64_32
                       ^
>> include/asm-generic/div64.h:235:11: note: in expansion of macro '__div64_32'
      __rem = __div64_32(&(n), __base); \
              ^
   drivers/gpu/drm//nouveau/nvkm/subdev/clk/gk20a.c:144:2: note: in expansion of macro 'do_div'
     do_div(rate, divider);
     ^
   arch/arm/include/asm/div64.h:32:24: note: expected 'uint64_t *' but argument is of type 'u32 *'
    static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
                           ^

vim +/do_div +99 drivers/clk/imx/clk-pllv1.c

2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   @1  #include <linux/clk-provider.h>
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    2  #include <linux/io.h>
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    3  #include <linux/slab.h>
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    4  #include <linux/kernel.h>
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    5  #include <linux/err.h>
3a84d17b arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11    6  
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    7  #include "clk.h"
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    8  
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09    9  /**
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   10   * pll v1
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   11   *
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   12   * @clk_hw	clock source
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   13   * @parent	the parent clock name
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   14   * @base	base address of pll registers
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   15   *
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   16   * PLL clock version 1, found on i.MX1/21/25/27/31/35
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   17   */
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   18  
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   19  #define MFN_BITS	(10)
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   20  #define MFN_SIGN	(BIT(MFN_BITS - 1))
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   21  #define MFN_MASK	(MFN_SIGN - 1)
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   22  
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   23  struct clk_pllv1 {
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   24  	struct clk_hw	hw;
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   25  	void __iomem	*base;
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   26  	enum imx_pllv1_type type;
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   27  };
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   28  
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   29  #define to_clk_pllv1(clk) (container_of(clk, struct clk_pllv1, clk))
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   30  
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   31  static inline bool is_imx1_pllv1(struct clk_pllv1 *pll)
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   32  {
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   33  	return pll->type == IMX_PLLV1_IMX1;
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   34  }
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   35  
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   36  static inline bool is_imx21_pllv1(struct clk_pllv1 *pll)
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   37  {
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   38  	return pll->type == IMX_PLLV1_IMX21;
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   39  }
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   40  
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   41  static inline bool is_imx27_pllv1(struct clk_pllv1 *pll)
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   42  {
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   43  	return pll->type == IMX_PLLV1_IMX27;
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   44  }
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   45  
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   46  static inline bool mfn_is_negative(struct clk_pllv1 *pll, unsigned int mfn)
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   47  {
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   48  	return !is_imx1_pllv1(pll) && !is_imx21_pllv1(pll) && (mfn & MFN_SIGN);
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   49  }
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   50  
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   51  static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   52  		unsigned long parent_rate)
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   53  {
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   54  	struct clk_pllv1 *pll = to_clk_pllv1(hw);
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   55  	long long ll;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   56  	int mfn_abs;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   57  	unsigned int mfi, mfn, mfd, pd;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   58  	u32 reg;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   59  	unsigned long rate;
2af9e6db arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-03-09   60  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   61  	reg = readl(pll->base);
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   62  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   63  	/*
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   64  	 * Get the resulting clock rate from a PLL register value and the input
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   65  	 * frequency. PLLs with this register layout can be found on i.MX1,
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   66  	 * i.MX21, i.MX27 and i,MX31
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   67  	 *
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   68  	 *                  mfi + mfn / (mfd + 1)
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   69  	 *  f = 2 * f_ref * --------------------
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   70  	 *                        pd + 1
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   71  	 */
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   72  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   73  	mfi = (reg >> 10) & 0xf;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   74  	mfn = reg & 0x3ff;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   75  	mfd = (reg >> 16) & 0x3ff;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   76  	pd =  (reg >> 26) & 0xf;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   77  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   78  	mfi = mfi <= 5 ? 5 : mfi;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   79  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   80  	mfn_abs = mfn;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   81  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   82  	/*
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   83  	 * On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   84  	 * 2's complements number.
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   85  	 * On i.MX27 the bit 9 is the sign bit.
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   86  	 */
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   87  	if (mfn_is_negative(pll, mfn)) {
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26   88  		if (is_imx27_pllv1(pll))
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   89  			mfn_abs = mfn & MFN_MASK;
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   90  		else
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   91  			mfn_abs = BIT(MFN_BITS) - mfn;
a5947903 arch/arm/mach-imx/clk-pllv1.c Alexander Shiyan 2013-11-10   92  	}
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   93  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   94  	rate = parent_rate * 2;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   95  	rate /= pd + 1;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   96  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   97  	ll = (unsigned long long)rate * mfn_abs;
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11   98  
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11  @99  	do_div(ll, mfd + 1);
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11  100  
3bec5f81 arch/arm/mach-imx/clk-pllv1.c Shawn Guo        2015-04-26  101  	if (mfn_is_negative(pll, mfn))
a6dd3c81 arch/arm/mach-imx/clk-pllv1.c Sascha Hauer     2012-09-11  102  		ll = -ll;

:::::: The code at line 99 was first introduced by commit
:::::: a6dd3c812e774b876d440c1a9ec1bd0fd5659390 ARM: i.MX clk pllv1: move mxc_decode_pll code to its user

:::::: TO: Sascha Hauer <s.hauer@pengutronix.de>
:::::: CC: Sascha Hauer <s.hauer@pengutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ikeVEW9yuYc//A+q
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ikeVEW9yuYc//A+q--
