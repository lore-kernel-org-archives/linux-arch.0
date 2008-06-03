From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 3/5] x86: lockless get_user_pages_fast
Date: Tue, 3 Jun 2008 04:34:20 +0200
Message-ID: <20080603023419.GC5527@wotan.suse.de>
References: <20080529122050.823438000@nick.local0.net> <20080529122602.330656000@nick.local0.net> <1212081659.6308.10.camel@norville.austin.ibm.com> <20080602101530.GA7206@wotan.suse.de> <20080602212833.226146bc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59847 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760AbYFCCeX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Jun 2008 22:34:23 -0400
Content-Disposition: inline
In-Reply-To: <20080602212833.226146bc.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org

On Mon, Jun 02, 2008 at 09:28:33PM +1000, Stephen Rothwell wrote:
> Hi Nick,
> 
> On Mon, 2 Jun 2008 12:15:30 +0200 Nick Piggin <npiggin@suse.de> wrote:
> >
> > BTW. I do plan to ask Linus to merge this as soon as 2.6.27 opens.
> > Hope nobody objects (or if they do please speak up before then)
> 
> Any chance of getting this into linux-next then to see if it
> conflicts with/kills anything else?
> 
> If this is posted/reviewed/tested enough to be "finished" then put it in
> a tree (or quilt series) and submit it.

Hi Stephen,

Thanks for the offer... I was hoping for Andrew to pick it up (which
he now has).

I'm not sure how best to do mm/ related stuff, but I suspect we have
gone as smoothly as we are in large part due to Andrew's reviewing
and martialling mm patches so well.

Not saying that wouldn't happen if the patches went to linux-next,
but I'm quite happy with how -mm works for mm development, so I will
prefer to submit to -mm unless Andrew asks otherwise.

For other developments I'll keep linux-next in mind. I guess it will
be useful for me eg in the case where I change an arch defined prototype
that requires a big sweep of the tree.

Thanks,
Nick
