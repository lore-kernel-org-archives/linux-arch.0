From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 2/2]: introduce fast_gup
Date: Thu, 15 May 2008 03:13:57 +0200
Message-ID: <20080515011357.GF30448@wotan.suse.de>
References: <20080328025455.GA8083@wotan.suse.de> <20080328030023.GC8083@wotan.suse.de> <1208857356.7115.218.camel@twins> <20080422094629.GC23770@wotan.suse.de> <1210789994.6377.21.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:38218 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbYEOBOB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 May 2008 21:14:01 -0400
Content-Disposition: inline
In-Reply-To: <1210789994.6377.21.camel@norville.austin.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, axboe@kernel.dk, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

On Wed, May 14, 2008 at 01:33:14PM -0500, Dave Kleikamp wrote:
> > Ah good catch. As you can see I haven't done any highmem testing ;)
> > Which I will do so before sending upstream.
> 
> Which will be when?  We'd really like to see this in mainline as soon as
> possible and in -mm in the meanwhile.

Well I just got all the "hard" core mm stuff past Linus in this merge
window, and got a couple of preexisting memory ordering bugs fixed..
So I am planning to get it into -mm, ready for the next merge window.

I'm a little concerned about Peter's instability reports, but maybe
they're just an -rt thing. But I don't think we've found any holes in
fast_gup yet (although I think I need to add one last check to ensure
it won't pick up kernel addresses).

Thanks,
Nick
