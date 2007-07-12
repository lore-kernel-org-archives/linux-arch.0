Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:44249 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbXGLDtV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jul 2007 23:49:21 -0400
Date: Thu, 12 Jul 2007 05:49:14 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] bitops: lock bitops
Message-ID: <20070712034914.GG32414@wotan.suse.de>
References: <20070712031419.GF32414@wotan.suse.de> <20070711.203811.92584706.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070711.203811.92584706.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, paulus@samba.org, tony.luck@intel.com, benh@kernel.crashing.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jul 11, 2007 at 08:38:11PM -0700, David Miller wrote:
> From: Nick Piggin <npiggin@suse.de>
> Date: Thu, 12 Jul 2007 05:14:19 +0200
> 
> > Here is a set of patches that aims to mitigate some of the lock_page
> > overhead on powerpc introduced in the fault path by another set.
> > Fortunately it also improves various other things too :)
> > 
> > After this set, a dd if=./big-sparse-file of=/dev/null on my G5
> > goes from 563MB/s to 575MB/s, or about 80ns less time per page.
> > However I won't post the full set until after getting some acks
> > from the arch people now, because it is a fair bit of churn in core
> > code (eg. renaming !TestSetPageLocked to trylock_page).
> > 
> > Not sure who else can take advantage of these. Sparc64 probably.
> 
> What I would code up on sparc64 would be basically equivalent to your
> generic versions.
> 
> Or, more simply, I could just call test_and_clear_bit() et al.
> directly and ignore the return value.  There wouldn't be any
> difference.

Oh OK, I stand corrected then. I thought you could avoid the
PRE barrier on your test_and_set, and the POST barrier on
test_and_clear, however I don't know exactly what sparc's
barriers work.
