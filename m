Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35300 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbbC0IeI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2015 04:34:08 -0400
Date: Fri, 27 Mar 2015 01:35:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20150327013516.8c6788be.akpm@linux-foundation.org>
In-Reply-To: <20150327081822.GA28669@infradead.org>
References: <cover.1426528417.git.milosz@adfin.com>
	<20150326202824.65d03787.akpm@linux-foundation.org>
	<20150327081822.GA28669@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Milosz Tanski <milosz@adfin.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150327083516.sdWZqu3AtpWGIpdMMgiUBTNMP5CYZ5SfiJHQwrdl9Xo@z>

On Fri, 27 Mar 2015 01:18:22 -0700 Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Mar 26, 2015 at 08:28:24PM -0700, Andrew Morton wrote:
> > I still don't understand why pwritev() exists.  We discussed this last
> > time but it seems nothing has changed.  I'm not seeing here an adequate
> > description of why it exists nor a justification for its addition.
> 
> pwritev2?  I have patches to support per-I/O O_DSYNC with it, lots of
> folks including Samba and SCSI targets want this because their protocols
> support it.  The patches were posted with earlier versions of Miklos
> series.
> 
> It's cleaner to add the two system calls in go when we plan using them
> anyway and have symmetric infrastructure, and I did not hear any
> disagreement with that on LSF.  Did you skip this session?

Put it in the changelogs.  All of it.  A conference discussion
is no use to people who weren't there.

> > And (again) we've discussed this before, but the patchset gets resent
> > as if nothing had happened.
> 
> We had long discussiosn about it both here and at LSF.  We had everyone
> agree and nod there, and only your repeated argument here, so maybe it's
> not Miklos who is disonnected but you?

I don't find conferences to be a good place to conduct code and design
review.

> Also that whole fincore argument is rather hypothetic - it's only been
> pushed in to ugly to live multiplexers that also expose things like
> pfns,  while with preadv2 we have a trivial and easy to use API read to
> merge, and various consumerms just waiting for it.

fincore() doesn't have to be ugly.  Please address the design issues I
raised.  How is pread2() useful to the class of applications which
cannot proceed until all data is available?


