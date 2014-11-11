Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:1348 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752045AbaKKVnI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Nov 2014 16:43:08 -0500
Date: Wed, 12 Nov 2014 08:42:40 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v6 0/7] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20141111214240.GV23575@dastard>
References: <cover.1415636409.git.milosz@adfin.com>
 <20141111064417.GT23575@dastard>
 <CANP1eJHfWT0Foe+weB1SJkJ10JnOge_g=E8CXBsQNPW7i2+4NA@mail.gmail.com>
 <x49ioilbrfx.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49ioilbrfx.fsf@segfault.boston.devel.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Milosz Tanski <milosz@adfin.com>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, Linux API <linux-api@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20141111214240.nVnpUR6WgtXH_K15ATNO1RnyCxiylXCN50Unh-p0_D8@z>

On Tue, Nov 11, 2014 at 12:03:14PM -0500, Jeff Moyer wrote:
> Milosz Tanski <milosz@adfin.com> writes:
> 
> >> Can you write a test (or set of) for fstests that exercises this new
> >> functionality? I'm not worried about performance, just
> >> correctness....
> >
> > Sure thing. Can you point me at the fstests repo? A quick google
> > search reveals lots of projects named fstests, most of them abandoned.
> 
> I think he's referring to xfstests.  Still, I think that's the wrong
> place for functional testing.  ltp would be better, imo.

I don't follow. Can you explain why is xfstests be the wrong place
to exercise this functionality and what makes ltp a better choice?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
