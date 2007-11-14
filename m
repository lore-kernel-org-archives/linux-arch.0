Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:59137 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbXKNPXr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2007 10:23:47 -0500
Date: Wed, 14 Nov 2007 16:23:46 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: Should PAGE_CACHE_SIZE be discarded?
Message-ID: <20071114152345.GB20973@wotan.suse.de>
References: <17161.1195048613@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17161.1195048613@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 14, 2007 at 01:56:53PM +0000, David Howells wrote:
> 
> Are we ever going to have PAGE_CACHE_SIZE != PAGE_SIZE?  If not, why not
> discard PAGE_CACHE_SIZE as it's then redundant.
> 

Christoph Lameter has patches exactly to make PAGE_CACHE_SIZE larger than
PAGE_SIZE, and they seem to work without much effort. I happen to hate the
patches ;) but that doesn't change the fact that PAGE_CACHE_SIZE is
relatively useful and it is not at all an ill-defined concept.


> PAGE_CACHE_SIZE is also an ill-defined concept.  Just grep in Documentation/
> and it only comes up in a couple of places, neither particularly informative.
> 
> If there's a possibility that it will be used, then someone who knows how it's
> supposed to work needs to sit down and document what it is, what it represents,
> where it applies, how it interacts with PG_compound and how the page flags
> distribute over a page cache slot.

No, this was an *example*. It has nothing to do with PG_compound upsream.
That was just an example. Basically, anything that goes in the page cache
is in units of PAGE_CACHE_SIZE, and nothing else. For filesystems it
should be pretty easy...

 
> One further thing to consider: actually making PAGE_CACHE_SIZE > PAGE_SIZE
> work will be an interesting problem, as I'm certain most filesystems will
> break horribly without a lot of work (ramfs might be only exception).

I think most filesystems actually don't have much problem with it. mm
code has bigger problems, eg. due to ptes <-> pagecache no longer being
equal size.... but why would filesystems care?

