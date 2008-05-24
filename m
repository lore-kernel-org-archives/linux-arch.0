From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 2/2] mm: lockless get_user_pages
Date: Sat, 24 May 2008 02:04:05 +0200
Message-ID: <20080524000404.GE3144@wotan.suse.de>
References: <20080521115929.GB9030@wotan.suse.de> <20080521121114.GC9030@wotan.suse.de> <20080522102753.GA25370@shadowen.org> <20080523022732.GC30209@wotan.suse.de> <20080523123112.GA9357@shadowen.org> <20080523234432.GD3144@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42493 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbYEXAEM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 May 2008 20:04:12 -0400
Content-Disposition: inline
In-Reply-To: <20080523234432.GD3144@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: apw@shadowen.org
Cc: Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, axboe@oracle.com, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org

On Sat, May 24, 2008 at 01:44:32AM +0200, Nick Piggin wrote:
> On Fri, May 23, 2008 at 01:31:12PM +0100, apw@shadowen.org wrote:
> > On Fri, May 23, 2008 at 04:27:33AM +0200, Nick Piggin wrote:
> 
>  
> > [...]
> > > > I did wonder if we could also check _PAGE_BIT_USER bit as by my reading
> > > > that would only ever be set on user pages, and by rejecting pages without
> > > > that set we could prevent any kernel pages being returned basically
> > > > for free.
> > > 
> > > I still do want the access_ok check to avoid any possible issues with
> > > kernel page table modifications... but checking for the user bit would
> > > be another good sanity check, good idea. 
> > 
> > Definatly not advocating removing any checks at all.  Just thinking the
> > addition is one more safety net should any one of the checks be flawed.
> > Security being a pig to prove at the best of times.
> 
> It isn't a bad idea at all. I'll see what I can do.

Oh, hmm, I was already checking the _PAGE_USER bit anyway ;)
