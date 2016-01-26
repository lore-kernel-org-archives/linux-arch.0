From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Tue, 26 Jan 2016 13:35:04 +0800
Message-ID: <20160126053504.GA22301@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <1534543.eobSKFEFfp@wuerfel>
 <20160126053050.GB20385@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160126053050.GB20385@wfg-t540p.sh.intel.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 26, 2016 at 01:30:50PM +0800, Fengguang Wu wrote:
> Hi Arnd,
> 
> Sorry for the delay! I lost access to my email account for some week.
> 
> On Tue, Jan 19, 2016 at 03:26:16PM +0100, Arnd Bergmann wrote:
> > On Tuesday 19 January 2016 19:27:55 kbuild test robot wrote:
> > > arm                               allnoconfig
> > > arm                         at91_dt_defconfig
> > > arm                                  at_hdmac
> > > arm                                    ep93xx
> > > arm                       imx_v6_v7_defconfig
> > > arm                                  iop-adma
> > > arm                          marzen_defconfig
> > > arm                          prima2_defconfig
> > > arm                                    sa1100
> > > arm                                   samsung
> > > arm                                        sh
> > > arm                       spear13xx_defconfig
> > > 
> > 
> > Hi Fengguang,
> > 
> > Sorry for hijacking this thread. I have never seen the list of arm defconfigs
> > you are building before, and it seems to be a surprising selection, as a number
> > of platforms (ep93xx, iop, sa1100, spear13xx) are rather obscure, but the
> > configurations that I tend to use most (multi_v7_defconfig, multi_v5_defconfig,
> > allmodconfig) are not included.
> > 
> > Do you always build the same set of configurations, or is this a different
> > each time?
> 
> There are a fixed set of config files for fast build tests (which I
> selected randomly, feel free to ask me to change the list to more
> reasonable ones):
> 
> 	arm-allnoconfig
> 	arm-at91_dt_defconfig
> 	arm-at_hdmac
> 	arm-ep93xx
> 	arm-imx_v6_v7_defconfig
> 	arm-iop-adma
> 	arm-marzen_defconfig
> 	arm-prima2_defconfig
> 	arm-sa1100
> 	arm-samsung
> 	arm-sh
> 	arm-spear13xx_defconfig

And there is another set of best effort configs whose priority is
in-between the above list and the arch/*/configs/* ones.

	arm-arm5
	arm-arm67
	arm-mmp
	arm-omap2plus_defconfig
	arm-s3c2410_defconfig
	arm-tegra_defconfig

Thanks,
Fengguang

> The more configs included in arch/*/configs will be tested in a more
> slow pace. So not included in this email does not mean they are not
> tested -- they are likely not quick enough to catch this notification
> email.
> 
> > Can you always include the three I mentioned?
> 
> Sure.
> 
> Thanks,
> Fengguang
