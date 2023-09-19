Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B546CD5BCA
	for <linux-arch@archiver.kernel.org>; Tue, 19 Sep 2023 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjISO0b (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 19 Sep 2023 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjISO0a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 10:26:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603EFF7;
        Tue, 19 Sep 2023 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VncnnhJmc8PsU0ruYP9H8J/d7HOU/JkrH5FEC5hhYfI=; b=nY5fCyJsDEElTaGCYnh8i/NEA5
        CFMU0X1ing7uHiVoZSIDlH6e9DPZQcxX5mzviYpFmt/x1/mPgJZDxlUuX4oI+5NzqwUdK87aP9wcm
        zdP5V7h3lcazZ3jjEwjrmd/sxuc/McSa1luT/D06mztTkKIgU8t3kZGIZGMY08EW0IY7zM2dgUsOx
        D4KtFCR9S3A2QqghlqdTAGaHioDYOhuV58+G7bPj1MzzXw7sGndLoBrVCX5+2Uxb9KI2jIZHfgyGO
        yY+lKYS/FTao9tnpuoByRcVqaOOU0UBZbkxeb4lEkD+ZV+QqL8FZOWXs74i+O/mtOvPlYFClpIgoJ
        bIf+WLww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qibg4-0005zv-Ma; Tue, 19 Sep 2023 14:26:12 +0000
Date:   Tue, 19 Sep 2023 15:26:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Greg Ungerer <gregungerer@westnet.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Message-ID: <ZQmvhC+pGWNs9R23@casper.infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 01:23:08PM +0000, David Laight wrote:
> > Well, that sucks.  What do you suggest for Coldfire?
> 
> Can you just do a 32bit xor ?
> Unless you've got smp m68k I'd presume it is ok?
> (And assuming you aren't falling off a page.)

Patch welcome.
