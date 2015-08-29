Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53064 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbbH2Ntj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 29 Aug 2015 09:49:39 -0400
Date: Sat, 29 Aug 2015 15:49:37 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: fix various asm-generic abuses
Message-ID: <20150829134937.GA13103@lst.de>
References: <1440746842-19029-1-git-send-email-hch@lst.de> <22516156.tfGZvl13aG@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22516156.tfGZvl13aG@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20150829134937.WYNRq1pDYnpxvfJ7qPyTwYKPcS9oJ4b9_Y1mhtPvk2s@z>

On Fri, Aug 28, 2015 at 09:16:51PM +0200, Arnd Bergmann wrote:
> On Friday 28 August 2015 09:27:13 Christoph Hellwig wrote:
> > This fixes two trivial classes of asm-generic abuse.  First two headers
> > that are intended for drivers are moved to include/linux, and second
> > various drivers that incorrectly use asm-generic headers directly are
> > switched over to use the proper public headers.  There are a few more
> > asm-generic abuse, but they aren't quite as trivial so they will take
> > a little more effort to fix.
> 
> Thanks a lot, these all look really useful. My normal way of dealing
> with asm-generic patches is to have changes go through the tree of
> whichever maintainer needs the changes for their own work with my
> Ack, but I guess in this case you don't actually have other patches
> depending on them, right?

No, there's nothing depending on it.

> If driver maintainers want to pick individual patches from this series,
> please add my
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> otherwise let me know if I should put them into my asm-generic git
> tree (which is currently empty, but part of linux-next).

Note that the first two are something you should probably pick up either
way as they aren't really specific to a driver.
