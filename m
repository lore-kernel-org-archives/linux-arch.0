Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:54685 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab0BGA0p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 6 Feb 2010 19:26:45 -0500
Date: Sat, 6 Feb 2010 19:26:38 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCHv3 0/5] fix xfs by making I/O to vmap/vmalloc areas work
Message-ID: <20100207002638.GQ24051@bombadil.infradead.org>
References: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de> <20100205160640.GA24344@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100205160640.GA24344@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: James Bottomley <James.Bottomley@suse.de>, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, rmk@arm.linux.org.uk, lethal@linux-sh.org, torvalds@linux-foundation.org, James Bottomley <James.Bottomley@HansenPartnership.com>
Message-ID: <20100207002638.Tr4C9R1a3743ipTE0Li47b5KpJ20VB5SfMZt5wt_FNY@z>

On Fri, Feb 05, 2010 at 05:06:40PM +0100, Christoph Hellwig wrote:
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > 
> 
> Agreed.  There's also a lot of ARM users popping up with this recently,
> while others worked around it using local flushing hacks previously.
> 

Thanks, I've applied these to parisc/next to give them a shakedown in
linux-next.

regards, Kyle.
