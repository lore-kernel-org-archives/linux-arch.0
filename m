From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Thu, 28 Jan 2016 11:14:35 +0800
Message-ID: <20160128031435.GA25625@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <1947556.38OyJnvGS5@wuerfel>
 <20160127093018.GA21190@wfg-t540p.sh.intel.com>
 <3596300.IYfzmako0c@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38735 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932985AbcA1DOr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Jan 2016 22:14:47 -0500
Content-Disposition: inline
In-Reply-To: <3596300.IYfzmako0c@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 27, 2016 at 10:44:01AM +0100, Arnd Bergmann wrote:
> On Wednesday 27 January 2016 17:30:18 Fengguang Wu wrote:
> 
> > > Looks good, I'm just unsure about "multi_v8_defconfig", this does not
> > > exist. Do you mean multi_v5_defconfig?
> 
> > Ah yes, multi_v8_defconfig does not exist actually.
> 
> Ok, can you include multi_v5_defconfig than?
 
OK, done.

> I see you have one named "arm-arm5", which may be the same.

Yes, looks so -- it's provided by someone else long time ago.

> > > I also wonder if you include 'randconfig' builds for some architectures.
> > > I have patches for all remaining errors and warnings that I see with
> > > ARM randconfig builds today. Not all of them are merged yet, but I could
> > > probably come up with a file to be used as input to KCONFIG_ALLCONFIG
> > > to eliminate the known-broken configurations, if you are interested.
> > 
> > If the are mostly ready for upstream, it may be easier to wait until
> > upstream randconfig works just fine for ARM.
> 
> I have around 130 patches for warnings that I'm submitting at the moment, but
> there are a couple of really tricky ones that I don't currently have
> a good plan for:
> 
> - in some configurations, you end up without any boards selected, hitting
>   an #error in the final link
> - ARMv3 support in gcc is rather broken and causes internal compiler errors
>   among other things
> - the old ELF format (OABI) doesn't work in some cases
> - GCOV_PROFILE_ALL causes problems that need to be debugged
> - XIP_KERNEL sometimes causes kallsyms to fail
> - not all platforms implement the complete clk API, if they don't
>   use CONFIG_COMMON_CLK (I have patch for that we can probably merge)

The robot may explicitly enable/disable some CONFIG_* after randconfig
to workaround known problems.

> - CONFIG_PHYS_OFFSET needs to be entered manually to be a number
>   in 'make config'

That's a problem for auto tests.

> - same for DEBUG_LL

Thanks,
Fengguang
