From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv3 0/5] fix xfs by making I/O to vmap/vmalloc areas work
Date: Fri, 5 Feb 2010 17:06:40 +0100
Message-ID: <20100205160640.GA24344@lst.de>
References: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:48611 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab0BEQG7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Feb 2010 11:06:59 -0500
Content-Disposition: inline
In-Reply-To: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, rmk@arm.linux.org.uk, lethal@linux-sh.org, torvalds@linux-foundation.org, hch@lst.de, James Bottomley <James.Bottomley@HansenPartnership.com>

On Fri, Feb 05, 2010 at 09:50:52AM -0600, James Bottomley wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> This is essentially a small tidy up from the previous series.  I
> thought about the Ben H additions, but since power doesn't seem to
> need this, they seemed a bit moot (we can expand the API when an
> actual user comes along).
> 
> The patch series adds a flush/invalidate_kernel_vmap_range() API that
> drivers using vmap/vmalloc areas must use before sending tohse areas
> for I/O.  This makes it crystal clear that coherence on these areas is
> the responsibility of the driver alone.  Fortunately xfs is the only
> thing in the kernel actually doing I/O to vmap areas.
> 
> Sin ce xfs is completely broken on most VIPT architectures without
> this, I'd like to submit it as a bug fix for 2.6.33.  Unfortunately,
> we actually have some parisc xfs users whose data is curently at
> severe risk.

Agreed.  There's also a lot of ARM users popping up with this recently,
while others worked around it using local flushing hacks previously.
