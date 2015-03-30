Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48630 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbbC3HkW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2015 03:40:22 -0400
Date: Mon, 30 Mar 2015 00:40:20 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20150330074020.GC22229@infradead.org>
References: <cover.1426528417.git.milosz@adfin.com>
 <20150326202824.65d03787.akpm@linux-foundation.org>
 <CANP1eJEbDusq_Gda35dGKiacC+2tbvb_bQEEHpi6PmgnNoWDFw@mail.gmail.com>
 <20150327100411.6823b9d7.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150327100411.6823b9d7.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Milosz Tanski <milosz@adfin.com>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, Linux API <linux-api@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150330074020.2YgISi_iCg3mQ06W_cm3a84a-XKn6kQWboEyk2lOejk@z>

On Fri, Mar 27, 2015 at 10:04:11AM -0700, Andrew Morton wrote:
> mm...  I don't think we should be adding placeholders to the kernel API
> to support code which hasn't been written, tested, reviewed, merged,
> etc.  It's possible none of this will ever happen and we end up with a
> syscall nobody needs or uses.  Plus it's always possible that during
> this development we decide the pwrite2() interface needs alteration but
> it's too late.
> 
> What would be the downside of deferring pwrite2() until it's all
> implemented?

It _is_ implemented.  I just decided to submit it separately as Miklos
already has to deal with enough bikeshedding for his feature that I
don't want to put the burden of dealing with the BS for the one I wrote
on him.
