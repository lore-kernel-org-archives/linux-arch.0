Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from embla.aitel.hist.no ([158.38.50.22]:51750 "HELO
	embla.aitel.hist.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756414AbXEUJ32 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 May 2007 05:29:28 -0400
Message-ID: <4651629B.2050505@aitel.hist.no>
Date: Mon, 21 May 2007 11:12:59 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
MIME-Version: 1.0
Subject: Re: [rfc] increase struct page size?!
References: <20070518040854.GA15654@wotan.suse.de>	<Pine.LNX.4.64.0705181112250.11881@schroedinger.engr.sgi.com>	<20070519012530.GB15569@wotan.suse.de>	<20070519181501.GC19966@holomorphy.com> <20070519150934.bdabc9b5.akpm@linux-foundation.org>
In-Reply-To: <20070519150934.bdabc9b5.akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton wrote:
> On Sat, 19 May 2007 11:15:01 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
>
>   
>> Much the same holds for the atomic_t's; 32 + PAGE_SHIFT is
>> 44 bits or more, about as much as is possible, and one reference per
>> page per page is not even feasible. Full-length atomic_t's are just
>> not necessary.
>>     
>
> You can overflow a page's refcount by mapping it 4G times.  That requires
> 32GB of pagetable memory.  It's quite feasible with remap_file_pages().
>   
But do anybody ever need to do that?
Such an attack is easily thwarted by refusing to map it more
than, say 3G times? 

Helge Hafting
