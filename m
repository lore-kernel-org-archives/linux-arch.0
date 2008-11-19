From: Jim Radford <radford@blackbean.org>
Subject: Re: [patch] mm: vmalloc fix lazy unmapping cache aliasing
Date: Wed, 19 Nov 2008 10:58:14 -0800
Message-ID: <20081119185814.GA25025@blackbean.org>
References: <20081119045338.GA18697@wotan.suse.de> <20081119045425.GB18697@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cpe-67-49-92-118.socal.res.rr.com ([67.49.92.118]:50043 "EHLO
	mail.blackbean.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbYKSTZ4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2008 14:25:56 -0500
Content-Disposition: inline
In-Reply-To: <20081119045425.GB18697@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, rmk@arm.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>

On Wed, Nov 19, 2008 at 05:54:25AM +0100, Nick Piggin wrote:
> On Wed, Nov 19, 2008 at 05:53:38AM +0100, Nick Piggin wrote:
> > Jim Radford has reported that the vmap subsystem rewrite was sometimes causing
> > his VIVT ARM system to behave strangely (seemed like going into infinite loops
> > trying to fault in pages to userspace).

> > We determined that the problem was most likely due to a cache aliasing issue.
> > flush_cache_vunmap was only being called at the moment the page tables were
> > to be taken down, however with lazy unmapping, this can happen after the page
> > has subsequently been freed and allocated for something else. The dangling
> > alias may still have dirty data attached to it.

> > The fix for this problem is to do the cache flushing when the caller has
> > called vunmap -- it would be a bug for them to write anything else to the
> > mapping at that point.

> Added Jim to CC...

Thanks Nick.  I just wanted to confirm that this latest version of the
patch works for me as well.

-Jim
