Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267797AbUHPQuW@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:22184 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267784AbUHPQuW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Aug 2004 12:50:22 -0400
Date: Mon, 16 Aug 2004 09:49:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Using get_cycles for add_timer_randomness
Message-ID: <20040816164947.GC11200@holomorphy.com>
References: <200308160303.17612.arnd@arndb.de> <20040810162435.GK24690@krispykreme> <20040814183623.GB5637@krispykreme> <20040815154821.2d6edb03.akpm@osdl.org> <20040816161756.GC16521@thunk.org> <20040816162228.GB11200@holomorphy.com> <20040816164420.GA22312@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816164420.GA22312@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>, arnd@arndb.de, richm@oldelvet.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Aug 16, 2004 at 09:22:28AM -0700, William Lee Irwin III wrote:
>> AFAICT most of those return 0 from get_cycles().

On Mon, Aug 16, 2004 at 06:44:20PM +0200, Ralf Baechle wrote:
> The cycle counter on MIPS processors [1] is only 32-bit.  I've been
> pondering to construct a 64-bit value in get_cycles() which would seriously
> slow down the function compared to the current single instruction
> implementation; fortunately a quick survey of all get_cycles() users a
> while ago did look like non of them actually requires the full 64-bit.

What does it return when the 32-bit cycle counter is not present? (It was
not obvious to me; it looks like it returns whatever's in $9.)


-- wli
