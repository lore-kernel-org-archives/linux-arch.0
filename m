Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.29.151]:33727 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbYB0OVr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2008 09:21:47 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id m1RELkFH088788
	for <linux-arch@vger.kernel.org>; Wed, 27 Feb 2008 14:21:46 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m1RELjL41884240
	for <linux-arch@vger.kernel.org>; Wed, 27 Feb 2008 15:21:45 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m1RELiK0013387
	for <linux-arch@vger.kernel.org>; Wed, 27 Feb 2008 14:21:45 GMT
Subject: Re: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080226194903.GB31527@flint.arm.linux.org.uk>
References: <20080225132648.GA13791@digi.com>
	 <1203958582.3247.3.camel@localhost> <20080226143858.GA11590@digi.com>
	 <1204048666.21725.6.camel@localhost>
	 <20080226194903.GB31527@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 15:21:34 +0100
Message-Id: <1204122094.25607.24.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Tue, 2008-02-26 at 19:49 +0000, Russell King wrote:
> > > For a complete fix we might want to change the type of pte?
> > 
> > You mean instead of a "struct page *" use a pgtable_t ? Yes, that would
> > be cleaner even if it is the same type.
> 
> Would someone mind investigating how the code ended up in this mess in
> the first place, so we can avoid this kind of thing in the future?

One thing I have learned is that if I ever have to do a change over all
architectures again I will split the patch into the common part and the
arch parts and send it to the respective maintainers directly. Adding
linux-arch seems NOT to be enough to get the attention of the arch
maintainers (having the patch in -mm for 3 month is not doing the trick
either).

> It looks like the pte_lock_deinit() appeared in
> 4c21e2f2441dc5fbb957b030333f5a3f2d02dea7.
> 
> The dec_zone_page_state() used to be dec_page_state(nr_page_table_pages);
> which then became a dec_zone_page_state() in
> df849a1529c106f7460e51479ca78fe07b07dc8c.
> 
> Both changes of those changes on their own look correct.
> 
> Ah, is it that someone skipped over ARM when they changed the page table
> freeing code?  Yes - 2f569afd9ced9ebec9a6eb3dbf6f83429be0a7b4 has:

Yes, sorry. I need one of these brown paper bags..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.


