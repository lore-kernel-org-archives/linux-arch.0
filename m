From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Date: Thu, 28 Jan 2016 13:07:10 +0100
Message-ID: <1889851.3PhZkL3YD7@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com> <3596300.IYfzmako0c@wuerfel> <20160128031435.GA25625@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:50925 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbcA1MH4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jan 2016 07:07:56 -0500
In-Reply-To: <20160128031435.GA25625@wfg-t540p.sh.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>, linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk

On Thursday 28 January 2016 11:14:35 Fengguang Wu wrote:

> > - CONFIG_PHYS_OFFSET needs to be entered manually to be a number
> >   in 'make config'
> 
> That's a problem for auto tests.

Ok, I'll try to revisit this one. Maybe I can turn it into a
'default 0xffffffff' with a compile-time warning, or make
'default 0' the fallback when it's not specified otherwise.

	Arnd
