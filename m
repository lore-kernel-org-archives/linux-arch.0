From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Fri, 29 Jan 2016 21:46:22 +0000
Message-ID: <20160129214622.GS10826@n2100.arm.linux.org.uk>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <20160128031435.GA25625@wfg-t540p.sh.intel.com>
 <20160128174241.GN10826@n2100.arm.linux.org.uk>
 <7619136.niuXthzi6R@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:45533 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756920AbcA2Vqk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2016 16:46:40 -0500
Content-Disposition: inline
In-Reply-To: <7619136.niuXthzi6R@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fengguang Wu <fengguang.wu@intel.com>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, linux-kbuild@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, Michal Marek <mmarek@suse.com>, linux-arm-kernel@lists.infradead.org

On Fri, Jan 29, 2016 at 12:07:21AM +0100, Arnd Bergmann wrote:
> This doesn't sound too hard. I've picked the defaults out of the
> git history in the patch below. The only tricky part was davinci,
> which has two different addresses and requires a little rework
> to avoid circular dependencies.

I think there's a much better way to solve this.

How about we have an architecture-defined way to provide all*config
with a set of settings to be used with Kconfig to define these
integer settings, rather than papering over the problem making up
random addresses (like you're doing for the debug stuff.)  Eg,
a default architecture-provided setting for KCONFIG_ALLCONFIG
that defines things such as the physical offset and the debug
addresses to be used for all*config targets?

Surely that's better than hacking around with the Kconfig files
trying to frig something into working, which can potentially confuse
people.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
