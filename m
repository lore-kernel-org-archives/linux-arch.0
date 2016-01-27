From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Wed, 27 Jan 2016 10:44:01 +0100
Message-ID: <3596300.IYfzmako0c@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <1947556.38OyJnvGS5@wuerfel> <20160127093018.GA21190@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20160127093018.GA21190@wfg-t540p.sh.intel.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 27 January 2016 17:30:18 Fengguang Wu wrote:

> > Looks good, I'm just unsure about "multi_v8_defconfig", this does not
> > exist. Do you mean multi_v5_defconfig?

> Ah yes, multi_v8_defconfig does not exist actually.

Ok, can you include multi_v5_defconfig than?

I see you have one named "arm-arm5", which may be the same.

> > I also wonder if you include 'randconfig' builds for some architectures.
> > I have patches for all remaining errors and warnings that I see with
> > ARM randconfig builds today. Not all of them are merged yet, but I could
> > probably come up with a file to be used as input to KCONFIG_ALLCONFIG
> > to eliminate the known-broken configurations, if you are interested.
> 
> If the are mostly ready for upstream, it may be easier to wait until
> upstream randconfig works just fine for ARM.

I have around 130 patches for warnings that I'm submitting at the moment, but
there are a couple of really tricky ones that I don't currently have
a good plan for:

- in some configurations, you end up without any boards selected, hitting
  an #error in the final link
- ARMv3 support in gcc is rather broken and causes internal compiler errors
  among other things
- the old ELF format (OABI) doesn't work in some cases
- GCOV_PROFILE_ALL causes problems that need to be debugged
- XIP_KERNEL sometimes causes kallsyms to fail
- not all platforms implement the complete clk API, if they don't
  use CONFIG_COMMON_CLK (I have patch for that we can probably merge)
- CONFIG_PHYS_OFFSET needs to be entered manually to be a number
  in 'make config'
- same for DEBUG_LL

	Arnd
