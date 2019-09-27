Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:51144 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbfI0LAZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 07:00:25 -0400
Date: Fri, 27 Sep 2019 10:59:42 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20190927105942.GS10204@ediswmail.ad.cirrus.com>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, rmk+kernel@arm.linux.org.uk, Will Deacon <will@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Message-ID: <20190927105942.hx8gii9tp3X7Ada1mJXY7EWC7Wr0zA6z0fN60yHou3s@z>

On Fri, Sep 27, 2019 at 12:43:33PM +0200, Nicolas Saenz Julienne wrote:
> On Fri, 2019-08-30 at 12:43 +0900, Masahiro Yamada wrote:
> > Commit 9012d011660e ("compiler: allow all arches to enable
> > CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> > this option. A couple of build errors were reported by randconfig,
> > but all of them have been ironed out.
> > 
> > Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> > (and it will simplify the 'inline' macro in compiler_types.h),
> > this commit changes it to always-on option. Going forward, the
> > compiler will always be allowed to not inline functions marked
> > 'inline'.
> > 
> > This is not a problem for x86 since it has been long used by
> > arch/x86/configs/{x86_64,i386}_defconfig.
> > 
> > I am keeping the config option just in case any problem crops up for
> > other architectures.
> > 
> > The code clean-up will be done after confirming this is solid.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> [ Adding some ARM people as they might be able to help ]
> 
> This was found to cause a regression on a Raspberry Pi 2 B built with
> bcm2835_defconfig which among other things has no SMP support.
> 
> The relevant logs (edited to remove the noise) are:
> 
> [    5.827333] Run /init as init process
> Loading, please wait...
> Failed to set SO_PASSCRED: Bad address
> Failed to bind netlink socket: Bad address
> Failed to create manager: Bad address
> Failed to set SO_PASSCRED: Bad address
> [    9.021623] systemd[1]: SO_PASSCRED failed: Bad address
> [!!!!!!] Failed to start up manager.
> [    9.079148] systemd[1]: Freezing execution.
> 
> I looked into it, it turns out that the call to get_user() in sock_setsockopt()
> is returning -EFAULT. Down the assembly rabbit hole that get_user() is I
> found-out that it's the macro 'check_uaccess' who's triggering the error.
> 
> I'm clueless at this point, so I hope you can give me some hints on what's
> going bad here.
> 

Not sure I can add much in terms of a solution, but I can at
least confirm I am seeing exactly the same issue, on my Zynq
based ARM system.

Thanks,
Charles
