Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sa4.bezeqint.net ([192.115.104.18]:60240 "EHLO sa4.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756953AbXKOOkr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2007 09:40:47 -0500
Message-ID: <473C5470.70005@panasas.com>
Date: Thu, 15 Nov 2007 16:15:12 +0200
From: Benny Halevy <bhalevy@panasas.com>
MIME-Version: 1.0
Subject: Re: Should PAGE_CACHE_SIZE be discarded?
References: <20071114213543.GC31048@wotan.suse.de> <20071114152345.GB20973@wotan.suse.de> <17161.1195048613@redhat.com> <22558.1195055979@redhat.com> <311.1195128303@redhat.com>
In-Reply-To: <311.1195128303@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <npiggin@suse.de>, torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Nov. 15, 2007, 14:05 +0200, David Howells <dhowells@redhat.com> wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
>> It can be pretty well any power of 2 from PAGE_SIZE upwards, with
>> compound pages. None of the filesystems should really care at all.
>> It's not even a new concept, hugetlbfs uses HPAGE_SIZE...
> 
> Ummm... The filesystem has to care.  If the VFS/VM says 'fill this page' you
> do need to know how big the page is or whether it's even actually several
> pages.

I think that what Nick was trying to say is that PAGE_CACHE_SIZE should always
be used properly as the size of the memory struct Page covers (while PAGE_SIZE
is the hardware page size and the constraint is that PAGE_CACHE_SIZE == (PAGE_SIZE << k)
for some k >= 0).  If everybody does that then "None of the filesystems should really
care at all". That said, it doesn't seem like the current usage in fs/ and drivers/
is consistent with this convention.

> 
> David
> -

