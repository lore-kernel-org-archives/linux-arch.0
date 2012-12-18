From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: memmap_init_zone() performance improvement
Date: Tue, 18 Dec 2012 15:03:13 -0800
Message-ID: <20121218150313.9f22bff7.akpm@linux-foundation.org>
References: <1349276174-8398-1-git-send-email-mike.yoknis@hp.com>
	<20121008151656.GM29125@suse.de>
	<1349794597.29752.10.camel@MikesLinux.fc.hp.com>
	<1350676398.1169.6.camel@MikesLinux.fc.hp.com>
	<20121020082858.GA2698@suse.de>
	<508FEECE.2070402@linux.vnet.ibm.com>
	<1352217806.6504.19.camel@MikesLinux.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35505 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2LRXDP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Dec 2012 18:03:15 -0500
In-Reply-To: <1352217806.6504.19.camel@MikesLinux.fc.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mike.yoknis@hp.com
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, Mel Gorman <mgorman@suse.de>, "mingo@redhat.com" <mingo@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mmarek@suse.cz" <mmarek@suse.cz>, "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "sam@ravnborg.org" <sam@ravnborg.org>, "minchan@kernel.org" <minchan@kernel.org>, "kamezawa.hiroyu@jp.fujitsu.com" <kamezawa.hiroyu@jp.fujitsu.com>, "mhocko@suse.cz" <mhocko@suse.cz>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>

On Tue, 06 Nov 2012 09:03:26 -0700
Mike Yoknis <mike.yoknis@hp.com> wrote:

> On Tue, 2012-10-30 at 09:14 -0600, Dave Hansen wrote:
> > On 10/20/2012 01:29 AM, Mel Gorman wrote:
> > > I'm travelling at the moment so apologies that I have not followed up on
> > > this. My problem is still the same with the patch - it changes more
> > > headers than is necessary and it is sparsemem specific. At minimum, try
> > > the suggestion of
> > >
> > > if (!early_pfn_valid(pfn)) {
> > >       pfn = ALIGN(pfn + MAX_ORDER_NR_PAGES, MAX_ORDER_NR_PAGES) - 1;
> > >       continue;
> > > }
> > 
> > Sorry I didn't catch this until v2...
> > 
> > Is that ALIGN() correct?  If pfn=3, then it would expand to:
> > 
> > (3+MAX_ORDER_NR_PAGES+MAX_ORDER_NR_PAGES-1) & ~(MAX_ORDER_NR_PAGES-1)
> > 
> > You would end up skipping the current MAX_ORDER_NR_PAGES area, and then
> > one _extra_ because ALIGN() aligns up, and you're adding
> > MAX_ORDER_NR_PAGES too.  It doesn't matter unless you run in to a
> > !early_valid_pfn() in the middle of a MAX_ORDER area, I guess.
> > 
> > I think this would work, plus be a bit smaller:
> > 
> >         pfn = ALIGN(pfn + 1, MAX_ORDER_NR_PAGES) - 1;
> > 
> Dave,
> I see your point about "rounding-up".  But, I favor the way Mel
> suggested it.  It more clearly shows the intent, which is to move up by
> MAX_ORDER_NR_PAGES.  The "pfn+1" may suggest that there is some
> significance to the next pfn, but there is not.
> I find Mel's way easier to understand.

I don't think that really answers Dave's question.  What happens if we
"run in to a !early_valid_pfn() in the middle of a MAX_ORDER area"?
