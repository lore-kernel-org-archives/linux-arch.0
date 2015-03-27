Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.SerNet.de ([193.175.80.2]:44302 "EHLO mail.SerNet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbbC0IDD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Mar 2015 04:03:03 -0400
Date: Fri, 27 Mar 2015 09:02:51 +0100
From: Volker Lendecke <Volker.Lendecke@SerNet.DE>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache
 only)
Reply-To: Volker.Lendecke@SerNet.DE
References: <cover.1426528417.git.milosz@adfin.com>
 <20150326202824.65d03787.akpm@linux-foundation.org>
 <E1YbN1J-0084qO-3s@intern.SerNet.DE>
 <20150326230833.4ccfaebb.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150326230833.4ccfaebb.akpm@linux-foundation.org>
Message-ID: <E1YbPEF-0088HN-S8@intern.SerNet.DE>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Milosz Tanski <milosz@adfin.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150327080251.XxZAIIiW4BOui2XZBYC6r1w7wKI-6d43oQXIafl-yhs@z>

On Thu, Mar 26, 2015 at 11:08:33PM -0700, Andrew Morton wrote:
> On Fri, 27 Mar 2015 06:41:25 +0100 Volker Lendecke <Volker.Lendecke@sernet.de> wrote:
> 
> > On Thu, Mar 26, 2015 at 08:28:24PM -0700, Andrew Morton wrote:
> > > A thing which bugs me about pread2() is that it is specifically
> > > tailored to applications which are able to use a partial read result. 
> > > ie, by sending it over the network.
> > 
> > Can you explain what you mean by this? Samba gets a pread
> > request from a client for some bytes. The client will be
> > confused when we send less than requested although the file
> > is long enough to satisfy all.
> 
> Well it was my assumption that samba would be able to do something
> useful with a partial read - pread() is allowed to return less than requested.

No, this is not the case. Maybe my whole understanding of
pread is wrong: I always thought that it won't return short
if the file spans the pread range. EINTR nonwithstanding.

> 	if (it's all in cache)

I know I'm repeating myself: We have a race condition here.
A small one, but it is racy. I've seen loaded systems where
we spend seconds between becoming re-scheduled. In these
systems, it will be the norm to block in later reads. And we
don't have a good way to detect this situation afterwards
and turn to threads as a precaution next time.

> 		read it all now
> 	else
> 		ask a worker thread to read it all
> 

> Bear in mind that these operations involve physical IO and large
> memcpy's.  Yes, a fincore() approach will consume more CPU but the
> additional overhead will be relatively small.

We have to pay this price for every single chunk. Without
oplocks we get 10-byte read requests. This is hard to
swallow for many vendors with small CPUs.

With best regards,

Volker Lendecke

-- 
SerNet GmbH, Bahnhofsallee 1b, 37081 Göttingen
phone: +49-551-370000-0, fax: +49-551-370000-9
AG Göttingen, HRB 2816, GF: Dr. Johannes Loxen
http://www.sernet.de, mailto:kontakt@sernet.de
