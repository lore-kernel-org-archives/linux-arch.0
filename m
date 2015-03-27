Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35445 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbbC0JAu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2015 05:00:50 -0400
Date: Fri, 27 Mar 2015 02:01:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20150327020159.eadd0ce1.akpm@linux-foundation.org>
In-Reply-To: <20150327084833.GA7689@infradead.org>
References: <cover.1426528417.git.milosz@adfin.com>
	<20150326202824.65d03787.akpm@linux-foundation.org>
	<20150327081822.GA28669@infradead.org>
	<20150327013516.8c6788be.akpm@linux-foundation.org>
	<20150327084833.GA7689@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Milosz Tanski <milosz@adfin.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150327090159.lwX0ENgVGb15Cbe_oVj1FSxLMGfpi-PiqDuCio4kYmA@z>

On Fri, 27 Mar 2015 01:48:33 -0700 Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Mar 27, 2015 at 01:35:16AM -0700, Andrew Morton wrote:
> > fincore() doesn't have to be ugly.  Please address the design issues I
> > raised.  How is pread2() useful to the class of applications which
> > cannot proceed until all data is available?
> 
> It actually makes them work correctly?  preadv2( ..., DONTWAIT) will
> return -EGAIN, which causes them to bounce to the threadpool where
> they call preadv(...).

(I assume you mean RWF_NONBLOCK)

That isn't how pread2() works.  If the leading one or more pages are
uptodate, pread2() will return a partial read.  Now what?  Either the
application reads the same data a second time via the worker thread
(dumb, but it will usually be a rare case) or it reads the remainder of
the data in the worker thread and splices the data back together. 
Which, as I said, will often result in a second load of the initial
read result into CPU cache.
