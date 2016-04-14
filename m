From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 01/19] tree wide: get rid of __GFP_REPEAT for order-0
 allocations part I
Date: Thu, 14 Apr 2016 12:56:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1604141255020.6593@chino.kir.corp.google.com>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org> <1460372892-8157-2-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34037 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcDNT4b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2016 15:56:31 -0400
Received: by mail-pf0-f173.google.com with SMTP id c20so49006934pfc.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Apr 2016 12:56:30 -0700 (PDT)
In-Reply-To: <1460372892-8157-2-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org

On Mon, 11 Apr 2016, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations. Yet we have
> the full kernel tree with its usage for apparently order-0 allocations.
> This is really confusing because __GFP_REPEAT is explicitly documented
> to allow allocation failures which is a weaker semantic than the current
> order-0 has (basically nofail).
> 
> Let's simply drop __GFP_REPEAT from those places. This would allow
> to identify place which really need allocator to retry harder and
> formulate a more specific semantic for what the flag is supposed to do
> actually.
> 
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Michal Hocko <mhocko@suse.com>

I did exactly this before, and Andrew objected saying that __GFP_REPEAT 
may not be needed for the current page allocator's implementation but 
could with others and that setting __GFP_REPEAT for an allocation 
provided useful information with regards to intent.  At the time, I 
attempted to eliminate __GFP_REPEAT entirely.
