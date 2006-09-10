Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:14518 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750855AbWIJKLy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 06:11:54 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around _syscall*()
Date: Sun, 10 Sep 2006 10:33:41 +0200
References: <200608302359.k7UNxIZW027536@hera.kernel.org> <20060904123801.905fabc6.akpm@osdl.org> <1157881687.2977.111.camel@pmac.infradead.org>
In-Reply-To: <1157881687.2977.111.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609101033.41833.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-arch.vger.kernel.org>

On Sunday 10 September 2006 11:48, David Woodhouse wrote:
> On Mon, 2006-09-04 at 12:38 -0700, Andrew Morton wrote:
> > > What we have _now_, however, is entirely unacceptable. Please apply the
> > > following patch to fix it:
> >
> > whimper.  that gives me a reject storm to fix up.
>
> It shouldn't bother you for long -- the intention was that the patch
> would be applied ASAP, so that this regression doesn't make its way into
> 2.6.18 final.

I don't think there is anything unacceptable in 2.6.18 in this area right now.
So 2.6.18 should be fine, and hopefully in the future we will keep this
useful facility too.

-Andi
