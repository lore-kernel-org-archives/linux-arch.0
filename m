Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lazybastard.de ([212.112.238.170]:52057 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbXKORpP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2007 12:45:15 -0500
Date: Thu, 15 Nov 2007 18:09:30 +0100
From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: Should PAGE_CACHE_SIZE be discarded?
Message-ID: <20071115170930.GD10165@lazybastard.org>
References: <17161.1195048613@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17161.1195048613@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, npiggin@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Wed, 14 November 2007 13:56:53 +0000, David Howells wrote:
> 
> Are we ever going to have PAGE_CACHE_SIZE != PAGE_SIZE?  If not, why not
> discard PAGE_CACHE_SIZE as it's then redundant.

I did some digging.  The code was merged between 28.4.1999 and
11.5.1999, as it first appears in 2.2.8 and 2.3.0:

/*
 * The page cache can done in larger chunks than
 * one page, because it allows for more efficient
 * throughput (it can then be mapped into user
 * space in smaller chunks for same flexibility).
 *
 * Or rather, it _will_ be done in larger chunks.
 */
#define PAGE_CACHE_SHIFT        PAGE_SHIFT
#define PAGE_CACHE_SIZE         PAGE_SIZE
#define PAGE_CACHE_MASK         PAGE_MASK

#define page_cache_alloc()      __get_free_page(GFP_USER)
#define page_cache_free(x)      free_page(x)
#define page_cache_release(x)   __free_page(x)

Looks like PAGE_CACHE_SIZE>PAGE_SIZE was planned before 2.3 opened, but
never went very far.  So judging by the last eight years of history,
PAGE_CACHE_SIZE is dead.

Completely discarding it might be a bad idea, as it serves as code
annotation.  Christoph Lameters "Large Blocksize Support" patches seem
to globally replace PAGE_CACHE_SIZE with a different macro.  Having
PAGE_CACHE_SIZE makes such an effort easier.  Dropping existing
annotation seems useless, when maintaining them is zero effort.

Large code audits for the PAGE_SIZE/PAGE_CACHE_SIZE distinction seem
completely useless, though.  For as long as the macro existed, it never
ever mattered.  My take is to keep it and let it bitrot until someone
actually cares.

Jörn

-- 
Joern's library part 6:
http://www.gzip.org/zlib/feldspar.html
