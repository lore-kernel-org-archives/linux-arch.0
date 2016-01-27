From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Wed, 27 Jan 2016 17:30:18 +0800
Message-ID: <20160127093018.GA21190@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <3724678.Yr2Z2lv3F9@wuerfel>
 <20160127083745.GA9933@wfg-t540p.sh.intel.com>
 <1947556.38OyJnvGS5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1947556.38OyJnvGS5@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 27, 2016 at 10:11:47AM +0100, Arnd Bergmann wrote:
> On Wednesday 27 January 2016 16:37:45 Fengguang Wu wrote:
> > 
> > Thank you for the tips! I've updated the lists accordingly.
> > 
> > 1st priority
> > ============
> > 
> > arm-allmodconfig
> > arm-allnoconfig
> > arm-at91_dt_defconfig
> > arm-efm32_defconfig
> > arm-exynos_defconfig
> > arm-multi_v7_defconfig
> > arm-multi_v8_defconfig
> > arm-shmobile_defconfig
> > arm-sunxi_defconfig
> > 
> > 2nd priority
> > ============
> > 
> > arm-arm5
> > arm-arm67
> > arm-imx_v6_v7_defconfig
> > arm-ixp4xx_defconfig
> > arm-mvebu_v7_defconfig
> > arm-omap2plus_defconfig
> > arm-sa1100
> > arm-samsung
> > arm-sh
> > arm-tegra_defconfig
> > 
> > 3nd priority
> > ============
> > 
> > arch/*/configs/*
> 
> Looks good, I'm just unsure about "multi_v8_defconfig", this does not
> exist. Do you mean multi_v5_defconfig?

Ah yes, multi_v8_defconfig does not exist actually.

> I also wonder if you include 'randconfig' builds for some architectures.
> I have patches for all remaining errors and warnings that I see with
> ARM randconfig builds today. Not all of them are merged yet, but I could
> probably come up with a file to be used as input to KCONFIG_ALLCONFIG
> to eliminate the known-broken configurations, if you are interested.

If the are mostly ready for upstream, it may be easier to wait until
upstream randconfig works just fine for ARM.

Thanks,
Fengguang
