From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 17:22:41 +0100
Message-ID: <20170330162241.GG7909@n2100.armlinux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36386 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933864AbdC3QXQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 12:23:16 -0400
Content-Disposition: inline
In-Reply-To: <20170329055706.GH29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwi>

On Wed, Mar 29, 2017 at 06:57:06AM +0100, Al Viro wrote:
> Comments, review, testing, replacement patches, etc. are very welcome.

I've given this a spin, and it appears to work (in that the box boots).

Kernel size wise:

   text    data      bss      dec     hex filename
8020229 3014220 10243276 21277725 144ac1d vmlinux.orig
8034741 3014388 10243276 21292405 144e575 vmlinux.uaccess
7976719 3014324 10243276 21234319 144028f vmlinux.noinline

Performance using hdparm -T (cached reads) to evaluate against a SSD
gives me the following results:

* original:
 Timing cached reads:   580 MB in  2.00 seconds = 289.64 MB/sec
 Timing cached reads:   580 MB in  2.00 seconds = 290.06 MB/sec
 Timing cached reads:   580 MB in  2.00 seconds = 289.65 MB/sec
 Timing cached reads:   582 MB in  2.00 seconds = 290.82 MB/sec
 Timing cached reads:   578 MB in  2.00 seconds = 289.07 MB/sec

 Average = 289.85MB/s

* uaccess:
 Timing cached reads:   578 MB in  2.00 seconds = 288.36 MB/sec
 Timing cached reads:   534 MB in  2.00 seconds = 266.68 MB/sec
 Timing cached reads:   534 MB in  2.00 seconds = 267.07 MB/sec
 Timing cached reads:   552 MB in  2.00 seconds = 275.45 MB/sec
 Timing cached reads:   532 MB in  2.00 seconds = 266.08 MB/sec

 Average = 272.73 MB/sec

* noinline:
 Timing cached reads:   548 MB in  2.00 seconds = 274.16 MB/sec
 Timing cached reads:   574 MB in  2.00 seconds = 287.19 MB/sec
 Timing cached reads:   574 MB in  2.00 seconds = 286.47 MB/sec
 Timing cached reads:   572 MB in  2.00 seconds = 286.20 MB/sec
 Timing cached reads:   578 MB in  2.00 seconds = 288.86 MB/sec

 Average = 284.58 MB/sec

I've run the test twice, and there's definitely a reproducable drop in
performance for some reason when switching between current and Al's
uaccess patches, which is partly recovered by switching to the out of
line versions.

The only difference that I can identify that could explain this are
the extra might_fault() checks in Al's version but which are missing
from the ARM version.

I'd suggest that we immediately switch to the uninlined versions on
ARM so that the impact of that change is reduced.  We end up with
a 1.9% performance reduction rather than a 6% reduction with the
inlined versions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
