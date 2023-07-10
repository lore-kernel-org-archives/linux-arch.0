Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8069AC0015E
	for <linux-arch@archiver.kernel.org>; Mon, 10 Jul 2023 20:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGJUTJ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 10 Jul 2023 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGJUTI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:19:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4D1B2;
        Mon, 10 Jul 2023 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZV6+5ZsIhvZLlZYDqAT59X7+VfV8F+fbtD5fCX3g0W4=; b=Wzn841NyYIQXYIGiYDX2X1Mlck
        ty00EO4KYM+P78vdrMuP+kSnJ9pdEET8QYE2b2HTKE3DxkC2q0pXkBBsBoUd9svobF1qlOYzv8vRB
        LjwRC8d6N18vRNG65WRc6STmGx0iaAG9+J9CJzVIgyxu62BCnI1ne5Wsch1yBbavgGMQtnhqQoMTz
        L9s3GyZckfG2X+PHIS45QaUJcA6yoUncxCy8dnLyIrtV1SoriXmeRrlr+ayu435XVzY6NuDy9c97p
        6NIZ3ZpIqVIU3Op+B0OrYzkXHNKjImuG4/u6g2n8w6dwK+R9GS6Q8eWGmzU7TLdTgdJJUwC0470o3
        FYVQxhgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxLP-00Etis-16; Mon, 10 Jul 2023 20:18:51 +0000
Date:   Mon, 10 Jul 2023 21:18:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/36] nios2: Implement the new page table range API
Message-ID: <ZKxnqmk3sstOtDZQ@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-18-willy@infradead.org>
 <ZBGZKTP7BGhvS9Oo@kernel.org>
 <ce464a86-b75e-3488-bab0-cbea1b3e2572@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce464a86-b75e-3488-bab0-cbea1b3e2572@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 13, 2023 at 05:45:54PM -0500, Dinh Nguyen wrote:
> 
> 
> On 3/15/23 05:08, Mike Rapoport wrote:
> > On Wed, Mar 15, 2023 at 05:14:25AM +0000, Matthew Wilcox (Oracle) wrote:
> > > Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> > > flush_dcache_folio().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
> > > from being per-page to per-folio.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > 
> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > 
> 
> Applied!

Sorry, what?  You can't pick this patch out of the middle of a series
and apply it!  This needs various earlier patches to work.  And then
later patches depend on this one having been applied, so if we were to
go the route of "please arch maintainers apply each of these patches",
it'd take over a year to get them all in.

As I said in the cover letter, this will all go in through the mm tree.
So what I want from arch maintainers is an Acked-by/Reviewed-by/Tested-by,
and then Andrew will apply the whole set.
