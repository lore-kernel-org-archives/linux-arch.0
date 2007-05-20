Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from holomorphy.com ([66.93.40.71]:59638 "EHLO holomorphy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759441AbXETH0V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 May 2007 03:26:21 -0400
Date: Sun, 20 May 2007 00:26:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [rfc] increase struct page size?!
Message-ID: <20070520072605.GE19966@holomorphy.com>
References: <20070518040854.GA15654@wotan.suse.de> <Pine.LNX.4.64.0705181112250.11881@schroedinger.engr.sgi.com> <20070519012530.GB15569@wotan.suse.de> <20070519181501.GC19966@holomorphy.com> <20070519150934.bdabc9b5.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070519150934.bdabc9b5.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 19 May 2007 11:15:01 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
>> Much the same holds for the atomic_t's; 32 + PAGE_SHIFT is
>> 44 bits or more, about as much as is possible, and one reference per
>> page per page is not even feasible. Full-length atomic_t's are just
>> not necessary.

On Sat, May 19, 2007 at 03:09:34PM -0700, Andrew Morton wrote:
> You can overflow a page's refcount by mapping it 4G times.  That requires
> 32GB of pagetable memory.  It's quite feasible with remap_file_pages().

Oh dear, worst-case app behavior. I'm just wrong.


-- wli
