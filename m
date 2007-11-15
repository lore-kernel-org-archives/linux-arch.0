Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:49303 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbXKOVax (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 16:30:53 -0500
Date: Thu, 15 Nov 2007 22:30:51 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: Should PAGE_CACHE_SIZE be discarded?
Message-ID: <20071115213051.GA30158@wotan.suse.de>
References: <473C5470.70005@panasas.com> <20071114213543.GC31048@wotan.suse.de> <20071114152345.GB20973@wotan.suse.de> <17161.1195048613@redhat.com> <22558.1195055979@redhat.com> <311.1195128303@redhat.com> <26150.1195138006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26150.1195138006@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Benny Halevy <bhalevy@panasas.com>, torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Nov 15, 2007 at 02:46:46PM +0000, David Howells wrote:
> Benny Halevy <bhalevy@panasas.com> wrote:
> 
> > I think that what Nick was trying to say is that PAGE_CACHE_SIZE should
> > always be used properly as the size of the memory struct Page covers (while
> > PAGE_SIZE is the hardware page size and the constraint is that
> > PAGE_CACHE_SIZE == (PAGE_SIZE << k) for some k >= 0).  If everybody does
> > that then "None of the filesystems should really care at all". That said, it
> > doesn't seem like the current usage in fs/ and drivers/ is consistent with
> > this convention.
> 
> Indeed.  One thing you have to consider is kmap().  I would expect it to
> present an area of PAGE_SIZE for access.  However, if the filesystem gets an
> area of PAGE_CACHE_SIZE to fill, then I would have to do multiple kmap() calls
> in the process of filling that 'pagecache page' in AFS.
> 
> Furthermore, if a page struct covers a PAGE_CACHE_SIZE chunk of memory, then I
> suspect the page allocator is also wrong, as it I believe it deals with
> PAGE_SIZE chunks of memory, assuming a struct page for each.

That's because you're thinking about all these difficulties outside the
filesystem. Really, pagecache is in PAGE_CACHE_SIZE. Nobody said pagecache
> PAGE_SIZE will work by changing a single define, but filesystems are
about the least problematic here.
