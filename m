From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: fix various asm-generic abuses
Date: Fri, 28 Aug 2015 21:16:51 +0200
Message-ID: <22516156.tfGZvl13aG@wuerfel>
References: <1440746842-19029-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59473 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbbH1TRY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2015 15:17:24 -0400
In-Reply-To: <1440746842-19029-1-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 28 August 2015 09:27:13 Christoph Hellwig wrote:
> This fixes two trivial classes of asm-generic abuse.  First two headers
> that are intended for drivers are moved to include/linux, and second
> various drivers that incorrectly use asm-generic headers directly are
> switched over to use the proper public headers.  There are a few more
> asm-generic abuse, but they aren't quite as trivial so they will take
> a little more effort to fix.

Thanks a lot, these all look really useful. My normal way of dealing
with asm-generic patches is to have changes go through the tree of
whichever maintainer needs the changes for their own work with my
Ack, but I guess in this case you don't actually have other patches
depending on them, right?

If driver maintainers want to pick individual patches from this series,
please add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

otherwise let me know if I should put them into my asm-generic git
tree (which is currently empty, but part of linux-next).

	Arnd
