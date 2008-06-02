From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 3/5] x86: lockless get_user_pages_fast
Date: Mon, 2 Jun 2008 12:15:30 +0200
Message-ID: <20080602101530.GA7206@wotan.suse.de>
References: <20080529122050.823438000@nick.local0.net> <20080529122602.330656000@nick.local0.net> <1212081659.6308.10.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:46383 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbYFBKPg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Jun 2008 06:15:36 -0400
Content-Disposition: inline
In-Reply-To: <1212081659.6308.10.camel@norville.austin.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org

BTW. I do plan to ask Linus to merge this as soon as 2.6.27 opens.
Hope nobody objects (or if they do please speak up before then)


On Thu, May 29, 2008 at 12:20:59PM -0500, Dave Kleikamp wrote:
> On Thu, 2008-05-29 at 22:20 +1000, npiggin@suse.de wrote:
>  
> > +int get_user_pages_fast(unsigned long start, int nr_pages, int write, struct page **pages)
