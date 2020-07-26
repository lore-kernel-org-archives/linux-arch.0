Return-Path: <SRS0=g7wM=BF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGZHLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 03:11:35 -0400
Date: Sun, 26 Jul 2020 08:11:32 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 04/20] unify generic instances of
 csum_partial_copy_nocheck()
Message-ID: <20200726071132.GA8862@infradead.org>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
 <20200724064117.GA10522@infradead.org>
 <20200724121918.GL2786714@ZenIV.linux.org.uk>
 <20200724122337.GA23095@infradead.org>
 <20200724123040.GM2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724123040.GM2786714@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200726071132.bcFqNV1ZLL5K9_F5gCvLf_dDb1Hn0n7qj0drtSHyZV8@z>

On Fri, Jul 24, 2020 at 01:30:40PM +0100, Al Viro wrote:
> > Sorry, I meant csum_and_copy_from_nocheck, just as in this patch.
> > 
> > Merging your branch into the net-next tree thus will conflict in
> > the nios2 and asm-geneeric/checksum.h as well as lib/checksum.c.
> 
> Noted, but that asm-generic/checksum.h conflict will be "massage
> in net-next/outright removal in this branch"; the same goes for
> lib/checksum.c and nios2.  It's c6x that is unpleasant in that respect...

What about just rebasing your branch on the net-next tree?
