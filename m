Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267199AbUHSS1i@vger.kernel.org>
Received: from p508B7861.dip.t-dialin.net ([80.139.120.97]:9324 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S267195AbUHSS1f
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Aug 2004 14:27:35 -0400
Date: Thu, 19 Aug 2004 20:26:51 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Using get_cycles for add_timer_randomness
Message-ID: <20040819182651.GD16994@linux-mips.org>
References: <200308160303.17612.arnd@arndb.de> <20040810162435.GK24690@krispykreme> <20040814183623.GB5637@krispykreme> <20040815154821.2d6edb03.akpm@osdl.org> <20040816161756.GC16521@thunk.org> <20040816162228.GB11200@holomorphy.com> <20040816164420.GA22312@linux-mips.org> <20040816164947.GC11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816164947.GC11200@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>, arnd@arndb.de, richm@oldelvet.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Aug 16, 2004 at 09:49:47AM -0700, William Lee Irwin III wrote:

> What does it return when the 32-bit cycle counter is not present? (It was
> not obvious to me; it looks like it returns whatever's in $9.)

Undefined behaviour ...

  Ralf
