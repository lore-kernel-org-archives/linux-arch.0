Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162AbXKOOvw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 09:51:52 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <473C5470.70005@panasas.com>
References: <473C5470.70005@panasas.com> <20071114213543.GC31048@wotan.suse.de> <20071114152345.GB20973@wotan.suse.de> <17161.1195048613@redhat.com> <22558.1195055979@redhat.com> <311.1195128303@redhat.com>
Subject: Re: Should PAGE_CACHE_SIZE be discarded?
Date: Thu, 15 Nov 2007 14:46:46 +0000
Message-ID: <26150.1195138006@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Benny Halevy <bhalevy@panasas.com>
Cc: dhowells@redhat.com, Nick Piggin <npiggin@suse.de>, torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Benny Halevy <bhalevy@panasas.com> wrote:

> I think that what Nick was trying to say is that PAGE_CACHE_SIZE should
> always be used properly as the size of the memory struct Page covers (while
> PAGE_SIZE is the hardware page size and the constraint is that
> PAGE_CACHE_SIZE == (PAGE_SIZE << k) for some k >= 0).  If everybody does
> that then "None of the filesystems should really care at all". That said, it
> doesn't seem like the current usage in fs/ and drivers/ is consistent with
> this convention.

Indeed.  One thing you have to consider is kmap().  I would expect it to
present an area of PAGE_SIZE for access.  However, if the filesystem gets an
area of PAGE_CACHE_SIZE to fill, then I would have to do multiple kmap() calls
in the process of filling that 'pagecache page' in AFS.

Furthermore, if a page struct covers a PAGE_CACHE_SIZE chunk of memory, then I
suspect the page allocator is also wrong, as it I believe it deals with
PAGE_SIZE chunks of memory, assuming a struct page for each.

David
