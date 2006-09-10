Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:49559 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750723AbWIJKbq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 06:31:46 -0400
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around
	_syscall*()
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200609101033.41833.ak@suse.de>
References: <200608302359.k7UNxIZW027536@hera.kernel.org>
	 <20060904123801.905fabc6.akpm@osdl.org>
	 <1157881687.2977.111.camel@pmac.infradead.org>
	 <200609101033.41833.ak@suse.de>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 11:30:57 +0100
Message-Id: <1157884257.2977.124.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-09-10 at 10:33 +0200, Andi Kleen wrote:
> I don't think there is anything unacceptable in 2.6.18 in this area right now.
> So 2.6.18 should be fine, and hopefully in the future we will keep this
> useful facility too.

A facility which isn't needed in-kernel and which has patches lined up
in -mm to remove it entirely.

A facility which isn't provided to userspace on other architectures, and
which has been historically broken on i386 anyway.

A facility which is unnecessary because glibc provides a functional
version of its own (which even your own numactl uses).

Kernel headers are _not_ a dumping ground for random crap like this.
We're supposed to be trying to clean them up; in fact we _had_ cleaned
this particular wart up -- and you reverted the fix, afaict without even
the courtesy a Cc to myself, linux-arch or linux-kernel.

Please fix this regression before 2.6.18.

-- 
dwmw2

