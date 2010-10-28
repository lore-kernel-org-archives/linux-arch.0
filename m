Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:53951 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011Ab0J1OQT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Oct 2010 10:16:19 -0400
Date: Thu, 28 Oct 2010 10:16:16 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] parisc: fix compile failure with kmap_atomic changes
Message-ID: <20101028141616.GY8332@bombadil.infradead.org>
References: <1288204547.6886.23.camel@mulgrave.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288204547.6886.23.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20101028141616.bc2LD3kFw1bBJSmByIcBAyKRmWkUBjA2y58XPaT9fqA@z>

On Wed, Oct 27, 2010 at 01:35:47PM -0500, James Bottomley wrote:
> Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date:   Tue Oct 26 14:21:51 2010 -0700
> 
>     mm: stack based kmap_atomic()
> 
> overlooked the fact that parisc uses kmap as a coherence mechanism, so
> even though we have no highmem, we do need to supply our own versions of
> kmap (and atomic).  This patch converts the parisc kmap to the form
> which is needed to keep it compiling (it's a simple prototype and name
> change).
> 
> Signed-off-by: James Bottomley <James.Bottomley@suse.de>

Signed-off-by: Kyle McMartin <kyle@redhat.com>

Care to send it straight to Linus? I didn't want to rebase my tree to
pull in the fix and risk his wrath...

Thanks,
--Kyle
