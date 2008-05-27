From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 2/2] lockless get_user_pages
Date: Tue, 27 May 2008 04:57:25 +0200
Message-ID: <20080527025725.GC21578@wotan.suse.de>
References: <20080527095519.4676.KOSAKI.MOTOHIRO@jp.fujitsu.com> <20080527022801.GB21578@wotan.suse.de> <20080527114350.4679.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516AbYE0C51 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 May 2008 22:57:27 -0400
Content-Disposition: inline
In-Reply-To: <20080527114350.4679.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Johannes Weiner <hannes@saeurebad.de>, Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, jens.axboe@oracle.com, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org

On Tue, May 27, 2008 at 11:46:27AM +0900, KOSAKI Motohiro wrote:
> > Aw, nobody likes fast_gup? ;)
> 
> Ah, I misunderstood your intention.
> I thought you disklike fast_gup..
> 
> I don't dislike it :()

Heh, no I was joking. fast_gup is not such a good name, especially for
grep or a reader who doesn't know gup is for get_user_pages.

 
> > Technically get_user_pages_lockless is wrong: the implementation may
> > not be lockless so one cannot assume it will not take mmap sem and
> > ptls.
> 
> agreed.
> 
> 
> > But I do like to make it clear that it is related to get_user_pages.
> > get_current_user_pages(), maybe? Hmm, that's harder to grep for
> > both then I guess. get_user_pages_current?
> 
> Yeah, good name.
 
OK, I'll rename it.

Thanks,
Nick
