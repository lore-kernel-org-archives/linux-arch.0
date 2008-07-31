From: Nick Piggin <npiggin@suse.de>
Subject: Re: MMU notifiers review and some proposals
Date: Thu, 31 Jul 2008 08:14:19 +0200
Message-ID: <20080731061419.GB32644@wotan.suse.de>
References: <20080724143949.GB12897@wotan.suse.de> <20080725214552.GB21150@duo.random> <20080726030810.GA18896@wotan.suse.de> <20080726113813.GD21150@duo.random> <20080726122826.GA17958@wotan.suse.de> <20080726130202.GA9598@duo.random> <20080726131450.GC21820@wotan.suse.de> <48907880.3020105@linux-foundation.org> <20080730145436.GJ11494@duo.random> <48908BD4.10408@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33277 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbYGaGOV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 31 Jul 2008 02:14:21 -0400
Content-Disposition: inline
In-Reply-To: <48908BD4.10408@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>
Cc: Andrea Arcangeli <andrea@qumranet.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, steiner@sgi.com

On Wed, Jul 30, 2008 at 10:42:12AM -0500, Christoph Lameter wrote:
> Andrea Arcangeli wrote:
> 
> > I think the current implementation is fine for the long run, it can
> > provide the fastest performance when armed, and each invalidate either
> > requires IPIs or it may may need to access the southbridge, so when
> > freeing large areas of memory it's good being able to do a single
> > invalidate.
> 
> Right. A couple of months ago we had this discussion and agreed that the begin / end was the way to go. I still support that decision.

That's OK. We don't have to make decisions just by people supporting one
way or the other, because I'll come up with some competing patches and
if they turn out to be significantly simpler to the core VM without having
a significant negative impact on performance then naturally everybody should
be happy to merge them, so nobody has to argue with handwaving.
