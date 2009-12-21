From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Mon, 21 Dec 2009 17:53:00 +0900
Message-ID: <20091221175137I.fujita.tomonori@lab.ntt.co.jp>
References: <20091217173957.GG2123@thunk.org>
	<20091218091901J.fujita.tomonori@lab.ntt.co.jp>
	<20091218141731.GH2123@thunk.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:33761 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbZLUIxs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Dec 2009 03:53:48 -0500
In-Reply-To: <20091218141731.GH2123@thunk.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tytso@mit.edu
Cc: fujita.tomonori@lab.ntt.co.jp, torvalds@linux-foundation.org, kyle@mcmartin.ca, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, hch@infradead.org, linux-arch@vger.kernel.org, jens.axboe@oracle.com

On Fri, 18 Dec 2009 09:17:32 -0500
tytso@mit.edu wrote:

> On Fri, Dec 18, 2009 at 09:21:30AM +0900, FUJITA Tomonori wrote:
> > 
> > iSCSI initiator driver should work with kmalloc'ed memory.
> > 
> > The reason why iSCSI didn't work with kmalloc'ed memory is that it
> > uses sendpage (which needs refcountable pages). We added a workaround
> > to not use sendpage with kmalloc'ed memory (it would be great if we
> > remove the workaround though).
> 
> Well, with a patch that I plan to be pushing that we have general
> agreement that it is a block device driver BUG not to accept
> kmalloc'ed/SLAB allocated memory, is one where ext4 will use
> kmalloc'ed/slab allocated memory on occasion when it needs to make
> shadow copy of buffers for journalling purposes AND when the fs block
> size is smaller than the page size.  (i.e., no more allocating a 16k
> page when the fs block size is 4k).  So this won't happen all the
> time; even if the case of a 16k Itanium system with 4k blocks, the
> bulk of the data won't be sent via kmalloc'ed memory --- just some
> critical metadata block and some data blocks that need to be escaped
> when being written into the journal.

Actually, ext3 (jbd) sent kmalloc'ed buffer to the block layer for
frozen data. xfs also used kmalloc'ed buffer. Neither do now (so, as
you said above, jbd wastes some memory when the block size is not
equal to page size, I think).


> I do think we need to document that block device drivers are
> _expected_ to be able to handle kmalloc'ed memory,

Agreed.

Note that network block drivers (iSCSI, drbd, something else?) doesn't
play with page ref-counting. They want to use sendpage. The network
layer (sendpage) can't handle non-ref-counted pages. The best solution
for fs and network block drivers might be modifying sendpage to handle
such pages.
