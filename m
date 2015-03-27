Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46919 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbbC0Ish (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2015 04:48:37 -0400
Date: Fri, 27 Mar 2015 01:48:33 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20150327084833.GA7689@infradead.org>
References: <cover.1426528417.git.milosz@adfin.com>
 <20150326202824.65d03787.akpm@linux-foundation.org>
 <20150327081822.GA28669@infradead.org>
 <20150327013516.8c6788be.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150327013516.8c6788be.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Milosz Tanski <milosz@adfin.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150327084833.3JmUlvhRpcY-OFFoDSBp729ocnxGaKer-2shi6UwGm0@z>

On Fri, Mar 27, 2015 at 01:35:16AM -0700, Andrew Morton wrote:
> fincore() doesn't have to be ugly.  Please address the design issues I
> raised.  How is pread2() useful to the class of applications which
> cannot proceed until all data is available?

It actually makes them work correctly?  preadv2( ..., DONTWAIT) will
return -EGAIN, which causes them to bounce to the threadpool where
they call preadv(...).
