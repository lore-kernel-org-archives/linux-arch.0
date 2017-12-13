Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbdLMMel (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 07:34:41 -0500
Date: Wed, 13 Dec 2017 13:34:37 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 0/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171213123437.GF25185@dhcp22.suse.cz>
References: <20171213092550.2774-1-mhocko@kernel.org>
 <20171213122533.GA2384@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213122533.GA2384@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Kees Cook <keescook@chromium.org>
Message-ID: <20171213123437.k9bPaWMgi7TRx-J0WKpY0eb4yskKgvvO0tKSVFPjSRs@z>

On Wed 13-12-17 04:25:33, Matthew Wilcox wrote:
> On Wed, Dec 13, 2017 at 10:25:48AM +0100, Michal Hocko wrote:
> > I am afraid we can bikeshed this to death and there will still be
> > somebody finding yet another better name. Therefore I've decided to
> > stick with my original MAP_FIXED_SAFE. Why? Well, because it keeps the
> > MAP_FIXED prefix which should be recognized by developers and _SAFE
> > suffix should also be clear that all dangerous side effects of the old
> > MAP_FIXED are gone.
> 
> I liked basically every other name suggested more than MAP_FIXED_SAFE.
> "Safe against what?" was an important question.
> 
> MAP_AT_ADDR was the best suggestion I saw that wasn't one of mine.  Of
> my suggestions, I liked MAP_STATIC the best.

The question is whether you care enough to pursue this further yourself.
Because as I've said I do not want to spend another round discussing the
name. The flag is documented and I believe that the name has some merit.
Disagreeing on naming is the easiest pitfall to block otherwise useful
functionality from being merged. And I am pretty sure there will be
always somebody objecting...
-- 
Michal Hocko
SUSE Labs
