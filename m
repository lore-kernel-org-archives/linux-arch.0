From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Tue, 19 Jan 2016 15:26:16 +0100
Message-ID: <1534543.eobSKFEFfp@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51259 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842AbcASO0n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2016 09:26:43 -0500
In-Reply-To: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>

On Tuesday 19 January 2016 19:27:55 kbuild test robot wrote:
> arm                               allnoconfig
> arm                         at91_dt_defconfig
> arm                                  at_hdmac
> arm                                    ep93xx
> arm                       imx_v6_v7_defconfig
> arm                                  iop-adma
> arm                          marzen_defconfig
> arm                          prima2_defconfig
> arm                                    sa1100
> arm                                   samsung
> arm                                        sh
> arm                       spear13xx_defconfig
> 

Hi Fengguang,

Sorry for hijacking this thread. I have never seen the list of arm defconfigs
you are building before, and it seems to be a surprising selection, as a number
of platforms (ep93xx, iop, sa1100, spear13xx) are rather obscure, but the
configurations that I tend to use most (multi_v7_defconfig, multi_v5_defconfig,
allmodconfig) are not included.

Do you always build the same set of configurations, or is this a different
each time?

Can you always include the three I mentioned?

	Arnd
