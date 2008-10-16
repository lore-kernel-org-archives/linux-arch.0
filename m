From: David Miller <davem@davemloft.net>
Subject: Re: [patch 054/272] compat: move cp_compat_stat to common code
Date: Wed, 15 Oct 2008 22:14:45 -0700 (PDT)
Message-ID: <20081015.221445.165279781.davem@davemloft.net>
References: <200810160502.m9G525d8028553@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48883
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750882AbYJPFPJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Oct 2008 01:15:09 -0400
In-Reply-To: <200810160502.m9G525d8028553@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, hch@lst.de, linux-arch@vger.kernel.org

From: akpm@linux-foundation.org
Date: Wed, 15 Oct 2008 22:02:05 -0700

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

Sparc bits:

Acked-by: David S. Miller <davem@davemloft.net>
