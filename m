Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36466 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbcDOHoZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Apr 2016 03:44:25 -0400
Date: Fri, 15 Apr 2016 09:44:21 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 01/19] tree wide: get rid of __GFP_REPEAT for order-0
 allocations part I
Message-ID: <20160415074421.GB32377@dhcp22.suse.cz>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
 <1460372892-8157-2-git-send-email-mhocko@kernel.org>
 <alpine.DEB.2.10.1604141255020.6593@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1604141255020.6593@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20160415074421.AcMcixUtjeRZY_tGJvwPl_ZSFYkL7cUWv6Mq2XUYHUo@z>

On Thu 14-04-16 12:56:28, David Rientjes wrote:
> On Mon, 11 Apr 2016, Michal Hocko wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > __GFP_REPEAT has a rather weak semantic but since it has been introduced
> > around 2.6.12 it has been ignored for low order allocations. Yet we have
> > the full kernel tree with its usage for apparently order-0 allocations.
> > This is really confusing because __GFP_REPEAT is explicitly documented
> > to allow allocation failures which is a weaker semantic than the current
> > order-0 has (basically nofail).
> > 
> > Let's simply drop __GFP_REPEAT from those places. This would allow
> > to identify place which really need allocator to retry harder and
> > formulate a more specific semantic for what the flag is supposed to do
> > actually.
> > 
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> I did exactly this before, and Andrew objected saying that __GFP_REPEAT 
> may not be needed for the current page allocator's implementation but 
> could with others and that setting __GFP_REPEAT for an allocation 
> provided useful information with regards to intent.
