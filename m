From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 04/20] unify generic instances of
 csum_partial_copy_nocheck()
Date: Mon, 27 Jul 2020 04:58:14 +0100
Message-ID: <20200727035814.GA794331@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
 <20200724064117.GA10522@infradead.org>
 <20200724121918.GL2786714@ZenIV.linux.org.uk>
 <20200724122337.GA23095@infradead.org>
 <20200724123040.GM2786714@ZenIV.linux.org.uk>
 <20200726071132.GA8862@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgG0D6R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 23:58:17 -0400
Content-Disposition: inline
In-Reply-To: <20200726071132.GA8862@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Jul 26, 2020 at 08:11:32AM +0100, Christoph Hellwig wrote:
> On Fri, Jul 24, 2020 at 01:30:40PM +0100, Al Viro wrote:
> > > Sorry, I meant csum_and_copy_from_nocheck, just as in this patch.
> > > 
> > > Merging your branch into the net-next tree thus will conflict in
> > > the nios2 and asm-geneeric/checksum.h as well as lib/checksum.c.
> > 
> > Noted, but that asm-generic/checksum.h conflict will be "massage
> > in net-next/outright removal in this branch"; the same goes for
> > lib/checksum.c and nios2.  It's c6x that is unpleasant in that respect...
> 
> What about just rebasing your branch on the net-next tree?

For now I've just cherry-picked your commit in there.  net-next interaction
there is minimal; most of the PITA (and potential breakage) is in arch/*...
