Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:33994 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbXGZIPD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jul 2007 04:15:03 -0400
Date: Thu, 26 Jul 2007 10:15:00 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/7] bitops: introduce lock bitops
Message-ID: <20070726081500.GC13404@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de> <20070726010522.0faeab97.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070726010522.0faeab97.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jul 26, 2007 at 01:05:22AM -0700, Andrew Morton wrote:
> On Wed, 25 Jul 2007 13:34:07 +0200 Nick Piggin <npiggin@suse.de> wrote:
> 
> > I'd like to get the new lock bitop primitives in if possible. Maybe it
> > is too late for 2.6.23, but at least if I can queue them up in -mm?
> > 
> > They are pretty simple, but at least the page lock and buffer lock
> > conversions touch quite a lot of code.
> 
> The changes look innocuous enough.  I'd prefer not to carry this for two
> months though.
> 
> afacit all the operations which got changed were actually renamed, so any
> unconverted code will reliably fail to compile, yes?  (If not, can we find
> a way to do this?).

Yes I think so. I'll double check.

The good thing is that none of the old operations are incompatible
either, so just in case something did get through, it won't cause
subtle synchronisation problems.


>  This means that a) if I _were_ to carry if for two
> months, any new code which gets added using the old operations will get
> reliably detected and b) there's not really much benefit in me carrying it
> all for two months.

Good points.

 
> > Not sure how to really do this
> > better to reduce merge difficulties.
> 
> Resend around the -rc5/6 timeframe?

OK.
