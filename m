Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:46302 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751053AbWCSVaP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 16:30:15 -0500
Subject: Re: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20060319.132511.116548328.davem@davemloft.net>
References: <1142801589.3240.51.camel@mulgrave.il.steeleye.com>
	 <20060319.130009.102283514.davem@davemloft.net>
	 <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
	 <20060319.132511.116548328.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 15:29:43 -0600
Message-Id: <1142803783.3240.64.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-03-19 at 13:25 -0800, David S. Miller wrote:
> This is exactly what Sparc64's caches are too, L1 D-cache is virtually
> indexed and physically tagged.  But any bus coherency transaction will
> update all lines with matching physical tags, otherwise things just
> won't work.

I'm afraid ours don't.  The reason is that parisc caches are huge
(around a megabyte), so you have to specify a coherence index (which is
effectively the virtual index) to the IOMMU on DMA transactions and
that's the only line it flushes (as long as the physical tags match).

> > OK, I confess to not ever having looked at that ... does it use
> > get_user_pages() as well?
> 
> I believe so, Andrew knows...

OK I'll wait to see what he says.

James


