Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:38088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeEIBji (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 21:39:38 -0400
Date: Tue, 8 May 2018 18:39:35 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for
 architectures
Message-ID: <20180509013935.GA8131@bombadil.infradead.org>
References: <20180428001526.22475-1-mcgrof@kernel.org>
 <20180428031810.GA14566@bombadil.infradead.org>
 <20180509010438.GM27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509010438.GM27853@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, arnd@arndb.de, gregkh@linuxfoundation.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Message-ID: <20180509013935.jWOtakFG2CeorKsvgQs0mx_oK-k3-hS6-TtiP_Yezqg@z>

On Wed, May 09, 2018 at 01:04:38AM +0000, Luis R. Rodriguez wrote:
> On Fri, Apr 27, 2018 at 08:18:10PM -0700, Matthew Wilcox wrote:
> > ia64: Add PAGE_KERNEL_RO and PAGE_KERNEL_EXEC
> > 
> > The rest of the kernel was falling back to simple PAGE_KERNEL pages; using
> > PAGE_KERNEL_RO and PAGE_KERNEL_EXEC provide better protection against
> > unintended writes.
> > 
> > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Nice, should I queue this into my series as well?

A little reluctant to queue it without anyone having tested it.  Heck,
I didn't even check it compiled ;-)

We used to just break architectures and let them fix it up for this kind
of thing.  That's not really acceptable nowadays, but I don't know how
we get arch maintainers to fix up their ports now.
