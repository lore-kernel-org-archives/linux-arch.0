From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [patch 054/272] compat: move cp_compat_stat to common code
Date: Thu, 16 Oct 2008 11:17:41 -0400
Message-ID: <20081016151741.GA2529@bombadil.infradead.org>
References: <200810160502.m9G525d8028553@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:39005 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbYJPPRo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Oct 2008 11:17:44 -0400
Content-Disposition: inline
In-Reply-To: <200810160502.m9G525d8028553@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, hch@lst.de, linux-arch@vger.kernel.org

On Wed, Oct 15, 2008 at 10:02:05PM -0700, akpm@linux-foundation.org wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> struct stat / compat_stat is the same on all architectures, so
> cp_compat_stat should be, too.
> 
> Turns out it is, except that various architectures have slightly and some
> high2lowuid/high2lowgid or the direct assignment instead of the
> SET_UID/SET_GID that expands to the correct one anyway.
> 
> This patch replaces the arch-specific cp_compat_stat implementations with
> a common one based on the x86-64 one.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: <linux-arch@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

direct cc's would have been nice. ;-)

Acked-by: Kyle McMartin <kyle@mcmartin.ca>
