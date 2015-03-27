Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33926 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbbC0GH1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2015 02:07:27 -0400
Date: Thu, 26 Mar 2015 23:08:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20150326230833.4ccfaebb.akpm@linux-foundation.org>
In-Reply-To: <E1YbN1J-0084qO-3s@intern.SerNet.DE>
References: <cover.1426528417.git.milosz@adfin.com>
	<20150326202824.65d03787.akpm@linux-foundation.org>
	<E1YbN1J-0084qO-3s@intern.SerNet.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Volker.Lendecke@sernet.de
Cc: Milosz Tanski <milosz@adfin.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150327060833.yh6K0z8dUdDZwpx9oe7Zy49S1f5GLwn5KVGIkUbq9Mk@z>

On Fri, 27 Mar 2015 06:41:25 +0100 Volker Lendecke <Volker.Lendecke@sernet.de> wrote:

> On Thu, Mar 26, 2015 at 08:28:24PM -0700, Andrew Morton wrote:
> > A thing which bugs me about pread2() is that it is specifically
> > tailored to applications which are able to use a partial read result. 
> > ie, by sending it over the network.
> 
> Can you explain what you mean by this? Samba gets a pread
> request from a client for some bytes. The client will be
> confused when we send less than requested although the file
> is long enough to satisfy all.

Well it was my assumption that samba would be able to do something
useful with a partial read - pread() is allowed to return less than requested.

If it isn't the case that samba can use the partial read result then
what does it do?  It has to save the partial data, then do the
additional IO?  That's pretty clunky compared to

	if (it's all in cache)
		read it all now
	else
		ask a worker thread to read it all

> > And of course fincore could be used by Samba etc to avoid blocking on
> > reads.  It wouldn't perform quite as well as pread2(), but I bet it's
> > good enough.
> > 
> > Bottom line: with pread2() there's still a need for fincore(), but with
> > fincore() there probably isn't a need for pread2().
> 
> fincore would be a second syscall per pread, and it is not
> atomic. I've had discussions with MIPS based vendors who
> are worried about every single syscall. This is the #1
> hottest code path in Samba.

Bear in mind that these operations involve physical IO and large
memcpy's.  Yes, a fincore() approach will consume more CPU but the
additional overhead will be relatively small.

Tradeoffs are involved, and it may turn out that choosing a more
flexible and powerful interface which is somewhat more CPU intensive is
a better decision.  It's hard to say until this is quantified (ie:
measured).

> > And I'm doubtful about claims that it absolutely has to be non-blocking
> > 100% of the time.  I bet that 99.99% is good enough.  A fincore()
> > option to run mark_page_accessed() against present pages would help
> > with the race-with-reclaim situation.
> 
> If you can make sure that after an fincore the pages remain
> in memory for x milliseconds the atomicity concern might go
> away.

It won't be guaranteed that the fincore()+pread() will be
non-blocking.  But blocking will be very rare.  I don't know whether
the additional expense of activating the pages within fincore() is
justified - needs runtime testing.
