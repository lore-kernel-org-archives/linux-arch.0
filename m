Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33044 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbbC0D1T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Mar 2015 23:27:19 -0400
Date: Thu, 26 Mar 2015 20:28:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20150326202824.65d03787.akpm@linux-foundation.org>
In-Reply-To: <cover.1426528417.git.milosz@adfin.com>
References: <cover.1426528417.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150327032824.Rdoh-9mbBeOLZZquBOOAO1Mi13SAbXrlr1muMFZsCHk@z>

On Mon, 16 Mar 2015 14:27:10 -0400 Milosz Tanski <milosz@adfin.com> wrote:

> This patchset introduces two new syscalls preadv2 and pwritev2. They are the
> same syscalls as preadv and pwrite but with a flag argument. Additionally,
> preadv2 implements an extra RWF_NONBLOCK flag. 

I still don't understand why pwritev() exists.  We discussed this last
time but it seems nothing has changed.  I'm not seeing here an adequate
description of why it exists nor a justification for its addition.

Also, why are we adding new syscalls instead of using O_NONBLOCK?  I
think this might have been discussed before, but the changelogs haven't
been updated to reflect it - please do so.

> The RWF_NONBLOCK flag in preadv2 introduces an ability to perform a
> non-blocking read from regular files in buffered IO mode. This works by only
> for those filesystems that have data in the page cache.
> 
> We discussed these changes at this year's LSF/MM summit in Boston. More details
> on the Samba use case, the numbers, and presentation is available at this link:
> https://lists.samba.org/archive/samba-technical/2015-March/106290.html

https://drive.google.com/file/d/0B3maCn0jCvYncndGbXJKbGlhejQ/view?usp=sharing
talks about "sync" but I can't find a description of what this actually
is.  It appears to perform better than anything else?


> Background:
> 
>  Using a threadpool to emulate non-blocking operations on regular buffered
>  files is a common pattern today (samba, libuv, etc...) Applications split the
>  work between network bound threads (epoll) and IO threadpool. Not every
>  application can use sendfile syscall (TLS / post-processing).
> 
>  This common pattern leads to increased request latency. Latency can be due to
>  additional synchronization between the threads or fast (cached data) request
>  stuck behind slow request (large / uncached data).
> 
>  The preadv2 syscall with RWF_NONBLOCK lets userspace applications bypass
>  enqueuing operation in the threadpool if it's already available in the
>  pagecache.

A thing which bugs me about pread2() is that it is specifically
tailored to applications which are able to use a partial read result. 
ie, by sending it over the network.

But it is not very useful for the class of applications which require
that the entire read be completed before they can proceed with using
the data.  Such applications will have to run pread2(), see the short
result, save away the partial data, perform some IO then fetch the
remaining data then proceed.  By this time, the original partially read
data may have fallen out of CPU cache (or we're on a different CPU) and
the data will need to be fetched into cache a second time.

Such applications would be better served if they were able to query for
pagecache presence _before_ doing the big copy_to_user(), so they can
ensure that all the data is in pagecache before copying it in.  ie:
fincore(), perhaps supported by a synchronous POSIX_FADV_WILLNEED.

And of course fincore could be used by Samba etc to avoid blocking on
reads.  It wouldn't perform quite as well as pread2(), but I bet it's
good enough.

Bottom line: with pread2() there's still a need for fincore(), but with
fincore() there probably isn't a need for pread2().

And (again) we've discussed this before, but the patchset gets resent
as if nothing had happened.


And I'm doubtful about claims that it absolutely has to be non-blocking
100% of the time.  I bet that 99.99% is good enough.  A fincore()
option to run mark_page_accessed() against present pages would help
with the race-with-reclaim situation.
