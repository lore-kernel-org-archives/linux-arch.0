From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Thu, 28 Jan 2016 17:42:41 +0000
Message-ID: <20160128174241.GN10826@n2100.arm.linux.org.uk>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <1947556.38OyJnvGS5@wuerfel>
 <20160127093018.GA21190@wfg-t540p.sh.intel.com>
 <3596300.IYfzmako0c@wuerfel>
 <20160128031435.GA25625@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160128031435.GA25625@wfg-t540p.sh.intel.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, linux-kbuild@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Michal Marek <mmarek@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 28, 2016 at 11:14:35AM +0800, Fengguang Wu wrote:
> On Wed, Jan 27, 2016 at 10:44:01AM +0100, Arnd Bergmann wrote:
> > - CONFIG_PHYS_OFFSET needs to be entered manually to be a number
> >   in 'make config'
> 
> That's a problem for auto tests.

I'm really against the idea of providing some kind of "default" to it.
Not providing a default means that people _have_ to do some research
for their particular system in order to provide a value, and they're
more likely to get the right value.  Providing a default will lead to
the assumption that the value is okay, and then we'll end up with
people complaining that their kernel doesn't boot, and is totally
silent.

The only default I'd accept is one based on the rest of the config -
in other words, re-introducing all the physical address of RAM that
we used to have in the mach/memory.h files...

There's other ways around these kinds of things, the Kconfig system
does allow a Kconfig fragment which can be used to pre-set some
configuration options to particular values - and so which can be used
to set CONFIG_PHYS_OFFSET prior to an allrandconfig or similar.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
