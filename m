From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/27] score: create head files cache.h cacheflush.h checksum.h cputime.h current.h
Date: Sun, 14 Jun 2009 00:40:05 +0200
Message-ID: <200906140040.06017.arnd@arndb.de>
References: <OF3577968C.E669F4B8-ON482575D4.0023707C-482575D4.0024726F@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63716 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760326AbZFMWkd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Jun 2009 18:40:33 -0400
In-Reply-To: <OF3577968C.E669F4B8-ON482575D4.0023707C-482575D4.0024726F@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Saturday 13 June 2009, liqin.chen@sunplusct.com wrote:
> 
> > This is a somewhat unusual way to express these functions. It seems
> > that you only have one implementation for each of them, so I wonder
> > why you keep them as function pointers. Do you plan to add more CPUs
> > in the future that do these differently?
> > 
> 
> S+core series have score7 core and score3 core, they use different ISA,
> this patch only include score7 code. We will provide score3 code latter.

Ok. Is the ISA similar enough that you still intend to provide binary
kernels that work on both, with just overriding a few functions?
If a kernel gets built only for one architecture or another, a compile-time
switch would be quicker than a runtime switch here.

A common way to express this kind of runtime dependency is to put all
the function pointers into a single data structure and just flip a
single pointer at boot time, e.g.

struct score_cpu_ops {
	void (*flush_cache_all)(void);
	void (*flush_cache_mm)(struct mm_struct *mm);
	void (*flush_cache_range)(struct vm_area_struct *vma,
	                            unsigned long start, unsigned long end);
	void (*flush_cache_page)(struct vm_area_struct *vma,
                           unsigned long page, unsigned long pfn);
	void (*flush_cache_sigtramp)(unsigned long addr);
	void (*flush_icache_all)(void);
	void (*flush_icache_range)(unsigned long start, unsigned long end);
	void (*flush_data_cache_page)(unsigned long addr);
};

extern struct score_cpu_ops *score_cpu_ops;

static inline flush_cache_all(void)
{
	return score_cpu_ops->flush_cache_all();
}
...

	Arnd <><
