From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Tue, 26 Jan 2016 17:27:46 +0100
Message-ID: <3724678.Yr2Z2lv3F9@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <20160126053050.GB20385@wfg-t540p.sh.intel.com> <20160126053504.GA22301@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160126053504.GA22301@wfg-t540p.sh.intel.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday 26 January 2016 13:35:04 Fengguang Wu wrote:
> > There are a fixed set of config files for fast build tests (which I
> > selected randomly, feel free to ask me to change the list to more
> > reasonable ones):
> > 
> >       arm-allnoconfig
> >       arm-at91_dt_defconfig
> >       arm-at_hdmac
> >       arm-ep93xx
> >       arm-imx_v6_v7_defconfig
> >       arm-iop-adma
> >       arm-marzen_defconfig
> >       arm-prima2_defconfig
> >       arm-sa1100
> >       arm-samsung
> >       arm-sh
> >       arm-spear13xx_defconfig
> 
> And there is another set of best effort configs whose priority is
> in-between the above list and the arch/*/configs/* ones.
> 
>         arm-arm5
>         arm-arm67
>         arm-mmp
>         arm-omap2plus_defconfig
>         arm-s3c2410_defconfig
>         arm-tegra_defconfig
> 

I think we want at least one ARMv7-M NOMMU target in the list,
I'd pick efm32_defconfig as it has the least overlap with the
drivers in the other configs.

I don't know what arm-sh is, but I assume it's a superset of
marzen, so you can probably drop marzen or move it down to the
low-prio set. Similarly, the at_hdmac is likely a subset of
at91_dt_defconfig and could be dropped.

prima2, ep93xx and spear13xx, mmp and s3c2410 are all
slow-moving platforms, I would not expect to see much
results from running those compared to the more active
platforms.

The platforms with the most changes these days are omap2plus,
sunxi, shmobile, and exynos (samsung), followed by some
that are widely used but not changed as much including
tegra, imx_v6_v7, mvebu_v7, and qcom (previously msm).

iop and sa1100 are rather old and won't change much, but it
can be good to keep them in there because they are for older
CPU architectures and behave a little different from the
modern ones. It might be better to replace iop with ixp4xx,
as this one is the only big-endian defconfig build we have,
and that sometimes catches build-time bugs.

	Arnd
