Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267801AbUHPQp7@vger.kernel.org>
Received: from p508B7A74.dip.t-dialin.net ([80.139.122.116]:42554 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S267798AbUHPQp5
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Aug 2004 12:45:57 -0400
Date: Mon, 16 Aug 2004 18:44:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Using get_cycles for add_timer_randomness
Message-ID: <20040816164420.GA22312@linux-mips.org>
References: <200308160303.17612.arnd@arndb.de> <20040810162435.GK24690@krispykreme> <20040814183623.GB5637@krispykreme> <20040815154821.2d6edb03.akpm@osdl.org> <20040816161756.GC16521@thunk.org> <20040816162228.GB11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816162228.GB11200@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>, arnd@arndb.de, richm@oldelvet.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Aug 16, 2004 at 09:22:28AM -0700, William Lee Irwin III wrote:

> At some point in the past, Arnd Bergmann <arnd@arndb.de> wrote:
> >> I noticed that only i386 and x86-64 are currently using a high resolution
> >> timer source when adding randomness.  Since many architectures have a
> >> working get_cycles() implementation, it seems rather straightforward to use
> >> that.
> 
> On Mon, Aug 16, 2004 at 12:17:56PM -0400, Theodore Ts'o wrote:
> > My only concern about using get_cycles is the speed question; on some
> > architectures, could (particularly those without TSC registers or
> > equivalent hardware support) could get_cycles() be slow enough to cause
> > latency problems?
> 
> AFAICT most of those return 0 from get_cycles().

The cycle counter on MIPS processors [1] is only 32-bit.  I've been
pondering to construct a 64-bit value in get_cycles() which would seriously
slow down the function compared to the current single instruction
implementation; fortunately a quick survey of all get_cycles() users a
while ago did look like non of them actually requires the full 64-bit.

  Ralf

[1] Some older processors don't have at all.
