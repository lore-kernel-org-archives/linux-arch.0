Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:46681 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbXKNVfo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2007 16:35:44 -0500
Date: Wed, 14 Nov 2007 22:35:43 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: Should PAGE_CACHE_SIZE be discarded?
Message-ID: <20071114213543.GC31048@wotan.suse.de>
References: <20071114152345.GB20973@wotan.suse.de> <17161.1195048613@redhat.com> <22558.1195055979@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22558.1195055979@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 14, 2007 at 03:59:39PM +0000, David Howells wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > Christoph Lameter has patches exactly to make PAGE_CACHE_SIZE larger than
> > PAGE_SIZE, and they seem to work without much effort. I happen to hate the
> > patches ;) but that doesn't change the fact that PAGE_CACHE_SIZE is
> > relatively useful and it is not at all an ill-defined concept.
> 
> Where, please? mm kernels?

Floating around. I'm not saying it will even get upstream. It's just
an example.

 
> > Basically, anything that goes in the page cache is in units of
> > PAGE_CACHE_SIZE, and nothing else. For filesystems it should be pretty
> > easy...
> 
> That depends on what the coverage of struct page is.  I don't actually know
> whether this is PAGE_SIZE or PAGE_CACHE_SIZE; I assumed it to be the former,
> but from what you've said, I'm not actually sure.

It can be pretty well any power of 2 from PAGE_SIZE upwards, with
compound pages. None of the filesystems should really care at all.
It's not even a new concept, hugetlbfs uses HPAGE_SIZE...
