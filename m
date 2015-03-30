Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fn.samba.org ([216.83.154.106]:45856 "EHLO mail.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbbC3Utk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Mar 2015 16:49:40 -0400
Date: Mon, 30 Mar 2015 13:49:37 -0700
From: Jeremy Allison <jra@samba.org>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20150330204937.GB4987@samba2>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20150326202824.65d03787.akpm@linux-foundation.org>
 <20150327081822.GA28669@infradead.org>
 <20150327013516.8c6788be.akpm@linux-foundation.org>
 <20150327084833.GA7689@infradead.org>
 <20150327020159.eadd0ce1.akpm@linux-foundation.org>
 <20150327155854.GA5548@samba2>
 <20150330073604.GB22229@infradead.org>
 <20150330132625.52b1250527ca3dcda79e349e@linux-foundation.org>
 <20150330203227.GA4987@samba2>
 <20150330133758.d2788f6de72f121170ff0301@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150330133758.d2788f6de72f121170ff0301@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@infradead.org>, Milosz Tanski <milosz@adfin.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150330204937.0sBPXaujZmXW0FzHWuYURL4bMLI6-Bo9qz9XmdXGfYU@z>

On Mon, Mar 30, 2015 at 01:37:58PM -0700, Andrew Morton wrote:
> On Mon, 30 Mar 2015 13:32:27 -0700 Jeremy Allison <jra@samba.org> wrote:
> 
> > On Mon, Mar 30, 2015 at 01:26:25PM -0700, Andrew Morton wrote:
> > > 
> > > cons:
> > > 
> > > d) fincore() is more expensive
> > > 
> > > e) fincore() will very occasionally block
> > 
> > The above is the killer for Samba. If fincore
> > returns true but when we schedule the pread
> > we block, we're hosed.
> > 
> > Once we block, we're done serving clients on the main
> > thread until this returns. That can cause unpredictable
> > response times which can cause client timeouts.
> > 
> > A fincore+pread solution that blocks is simply unsafe
> > to use for us. We'll have to stay with the threadpool :-(.
> 
> Finally.  Thanks ;)
> 
> This implies that the samba main thread also has to avoid any memory
> allocations both direct and within syscall and pagefault - those will
> occasionally exhibit similar worse-case latency. Is this done now?

We don't do anything special around allocations in syscall.
For aio read we do talloc (internal memory allocator) the
return chunk before going into the pthread pread, so I
suppose this could block. Haven't seen this as a reported
problem though. I suppose you can say "well exactly the
same thing is true of fincore()" :-).
