Return-Path: <ink@jurassic.park.msu.ru>
Received: from jurassic.park.msu.ru ([195.208.223.243]:24846 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261955AbUB2Ao7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 19:44:59 -0500
Date: Sun, 29 Feb 2004 03:44:56 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [PROPOSAL] switch atomic_t to long
Message-ID: <20040229034456.A707@den.park.msu.ru>
References: <20040226141645.GL25779@parcelfarce.linux.theplanet.co.uk> <20040226174513.A16541@jurassic.park.msu.ru> <20040226152544.GM25779@parcelfarce.linux.theplanet.co.uk> <20040226190143.A16913@jurassic.park.msu.ru> <16446.58540.470071.388994@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16446.58540.470071.388994@cargo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Feb 27, 2004 at 05:33:16PM +1100
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Feb 27, 2004 at 05:33:16PM +1100, Paul Mackerras wrote:
> Note that you don't need both "count" and "waking" to do semaphores
> efficiently on architectures with load-locked/store-conditional; just
> a "count" is sufficient.  Look at the ppc implementation (or the ppc64
> or sparc64 implementations, which follow it).

Indeed...
Thanks for pointing that out.

Ivan.
