From: tytso@mit.edu
Subject: Re: [git patches] xfs and block fixes for virtually indexed arches
Date: Fri, 18 Dec 2009 09:17:32 -0500
Message-ID: <20091218141731.GH2123@thunk.org>
References: <20091217163036.GE2123@thunk.org>
 <alpine.LFD.2.00.0912170839550.15740@localhost.localdomain>
 <20091217173957.GG2123@thunk.org>
 <20091218091901J.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091218091901J.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-parisc-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: torvalds@linux-foundation.org, kyle@mcmartin.ca, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, hch@infradead.org, linux-arch@vger.kernel.org, jens.axboe@oracle.com
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 18, 2009 at 09:21:30AM +0900, FUJITA Tomonori wrote:
> 
> iSCSI initiator driver should work with kmalloc'ed memory.
> 
> The reason why iSCSI didn't work with kmalloc'ed memory is that it
> uses sendpage (which needs refcountable pages). We added a workaround
> to not use sendpage with kmalloc'ed memory (it would be great if we
> remove the workaround though).

Well, with a patch that I plan to be pushing that we have general
agreement that it is a block device driver BUG not to accept
kmalloc'ed/SLAB allocated memory, is one where ext4 will use
kmalloc'ed/slab allocated memory on occasion when it needs to make
shadow copy of buffers for journalling purposes AND when the fs block
size is smaller than the page size.  (i.e., no more allocating a 16k
page when the fs block size is 4k).  So this won't happen all the
time; even if the case of a 16k Itanium system with 4k blocks, the
bulk of the data won't be sent via kmalloc'ed memory --- just some
critical metadata block and some data blocks that need to be escaped
when being written into the journal.

I do think we need to document that block device drivers are
_expected_ to be able to handle kmalloc'ed memory, and if they can't,
#1 they should do a BUG_ON instead of corrupting user's data, and #2,
if they do corrupt data, we should send the angry users with corrupted
file systems to bang at the doors of the block device authors.

					- Ted




