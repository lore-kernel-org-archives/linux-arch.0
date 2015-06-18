From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: subtle side effect of commit a1c48bb160f836
Date: Thu, 18 Jun 2015 14:15:27 +0530
Message-ID: <55828527.8050901@synopsys.com>
References: <55826966.6050202@synopsys.com> <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com> <20150618081329.GA9434@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58294 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbbFRIqF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2015 04:46:05 -0400
In-Reply-To: <20150618081329.GA9434@pobox.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Thursday 18 June 2015 01:43 PM, Michal Marek wrote:
>> > Alternatively, as we already have CONFIG_CC_OPTIMIZE_FOR_SIZE,
>> > a(nother) Kconfig option may make sense.
> We can also introduce some ARCH_CFLAGS that is appended near the end of
> the list, and have arc/Makefile add its -O3 there. But I'd like to why
> the -O3 needs to be there in first place. 

This is how historically ARC kernels have been built. We do track performance
results LMBench/hackbench... and going from -O3 to -O2 caused a sudden dip in some
of the numbers when we measured 3.18 (vs. 3.13)

> Obviously, the kernel works
> with -O2, otherwise the regression would have been identified earlier.

Its a performance thing - so yeah -O2 works, but -O3 works even better :-)

> So why can't users specify -O3 in KCFLAGS like on any other
> architecture.

Sweet, I didn't know about this. But I don't see any arch setting this - only tile
using it. So yeah - below does the trick !

--------->
From 5e44cd2ed69b1d030b4cb87600d2767b69c35537 Mon Sep 17 00:00:00 2001
From: Vineet Gupta <vgupta@synopsys.com>
Date: Thu, 18 Jun 2015 13:54:01 +0530
Subject: [PATCH] ARC: Override toplevel default -O2 with -O3

ARC kernels have historically been built with -O3, despite top level
Makefile defaulting to -O2. This was facilitated by implicitly ordering
of arch makefile include AFTER top level assigned -O2.

An upstream fix to top level a1c48bb160f ("Makefile: Fix unrecognized
cross-compiler command line options") changed the ordering, making ARC
-O3 defunt.

Fix that by NOT relying on any ordering whatsoever and use the right
mechanism to do the over-rides.

Suggested-by: Michal Marek <mmarek@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 86c71b2089d2..c23f3f2b0ff8 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -44,6 +44,7 @@ endif
 ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
 # Generic build system uses -O2, we want -O3
 cflags-y  += -O3
+KCFLAGS += -O3
 endif

 # small data is default for elf32 tool-chain. If not usable, disable it
-- 
1.9.1
