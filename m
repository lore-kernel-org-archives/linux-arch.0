Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:32163 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932071AbWIJJtC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 05:49:02 -0400
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around
	_syscall*()
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060904123801.905fabc6.akpm@osdl.org>
References: <200608302359.k7UNxIZW027536@hera.kernel.org>
	 <1157398050.2473.137.camel@shinybook.infradead.org>
	 <20060904123801.905fabc6.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 10:48:07 +0100
Message-Id: <1157881687.2977.111.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, ak@suse.de, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-04 at 12:38 -0700, Andrew Morton wrote:
> > What we have _now_, however, is entirely unacceptable. Please apply the
> > following patch to fix it:
> 
> whimper.  that gives me a reject storm to fix up.

It shouldn't bother you for long -- the intention was that the patch
would be applied ASAP, so that this regression doesn't make its way into
2.6.18 final.

-- 
dwmw2

