Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbdLMMZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Dec 2017 07:25:34 -0500
Date: Wed, 13 Dec 2017 04:25:33 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 0/2] mm: introduce MAP_FIXED_SAFE
Message-ID: <20171213122533.GA2384@bombadil.infradead.org>
References: <20171213092550.2774-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171213092550.2774-1-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.com>
Message-ID: <20171213122533.1d5iu3-Q7-IRN9AP7i4rYMQTGTffS8iQcvy9MjTr0eI@z>

On Wed, Dec 13, 2017 at 10:25:48AM +0100, Michal Hocko wrote:
> I am afraid we can bikeshed this to death and there will still be
> somebody finding yet another better name. Therefore I've decided to
> stick with my original MAP_FIXED_SAFE. Why? Well, because it keeps the
> MAP_FIXED prefix which should be recognized by developers and _SAFE
> suffix should also be clear that all dangerous side effects of the old
> MAP_FIXED are gone.

I liked basically every other name suggested more than MAP_FIXED_SAFE.
"Safe against what?" was an important question.

MAP_AT_ADDR was the best suggestion I saw that wasn't one of mine.  Of
my suggestions, I liked MAP_STATIC the best.
