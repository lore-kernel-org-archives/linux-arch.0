Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:42380 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935360AbXGMSXV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 14:23:21 -0400
Date: Fri, 13 Jul 2007 11:23:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 0/7] Sparsemem Virtual Memmap V5
In-Reply-To: <20070713104044.0d090c79.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0707131116080.22727@schroedinger.engr.sgi.com>
References: <exportbomb.1184333503@pinky> <Pine.LNX.4.64.0707131001060.21777@schroedinger.engr.sgi.com>
 <20070713104044.0d090c79.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 13 Jul 2007, Andrew Morton wrote:

> It would be nice to see a bit of spirited reviewing from the affected arch
> maintainers and mm people...

That was already done a long time ago. Maybe you do not remember it.

See 
http://marc.info/?l=linux-kernel&m=117556067909158&w=2
http://marc.info/?l=linux-kernel&m=117598342420719&w=2
http://marc.info/?l=linux-kernel&m=117541139915535&w=2
http://marc.info/?l=linux-kernel&m=116556142519461&w=2

> There's already an enormous amount of mm stuff banked up and it looks like
> I get to hold onto a lot of that until 2.6.24.  We seem to be spending too
> little time on the first 90% of new stuff and too little time on the last
> 10% of existing stuff.

Well without this we cannot perform the cleanup of the miscellaneous 
memory models around. The longer this is held up the longer the discontig 
etc will stay in the tree with all the associated #ifdeffery.
