Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:56623 "EHLO
	lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbbKCCgv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Nov 2015 21:36:51 -0500
Date: Tue, 3 Nov 2015 11:36:51 +0900
From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 3/8] arch: uapi: asm: mman.h: Let MADV_FREE have same
 value for all architectures
Message-ID: <20151103023651.GI17906@bbox>
References: <1446188504-28023-1-git-send-email-minchan@kernel.org>
 <1446188504-28023-4-git-send-email-minchan@kernel.org>
 <alpine.LSU.2.11.1511011542030.11427@eggly.anvils>
 <20151103023250.GH17906@bbox>
MIME-Version: 1.0
In-Reply-To: <20151103023250.GH17906@bbox>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-api@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, zhangyanfei@cn.fujitsu.com, Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, David Miller <davem@davemloft.net>, "Darrick J. Wong" <darrick.wong@oracle.com>, Roland Dreier <roland@kernel.org>, Jason Evans <je@fb.com>, Daniel Micay <danielmicay@gmail.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Michal Hocko <mhocko@suse.cz>, yalin.wang2010@gmail.com, Shaohua Li <shli@kernel.org>, Chen Gang <gang.chen.5i5j@gmail.com>, "rth@twiddle.net" <rth@twiddle.net>, "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>, "mattst88@gmail.com" <mattst88@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "deller@gmx.de" <deller@gmx.de>, "chris@zankel.net" <chris@zankel.net>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20151103023651.pg2GjExK7EvmffROp3Kj2tCkbzgPFLkTNVEXXb9LJcI@z>

On Tue, Nov 03, 2015 at 11:32:51AM +0900, Minchan Kim wrote:
> On Sun, Nov 01, 2015 at 04:08:27PM -0800, Hugh Dickins wrote:
> > On Fri, 30 Oct 2015, Minchan Kim wrote:
> > > From: Chen Gang <gang.chen.5i5j@gmail.com>
> > > 
> > > For uapi, need try to let all macros have same value, and MADV_FREE is
> > > added into main branch recently, so need redefine MADV_FREE for it.
> > > 
> > > At present, '8' can be shared with all architectures, so redefine it to
> > > '8'.
> > > 
> > > Cc: rth@twiddle.net <rth@twiddle.net>,
> > > Cc: ink@jurassic.park.msu.ru <ink@jurassic.park.msu.ru>
> > > Cc: mattst88@gmail.com <mattst88@gmail.com>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > Cc: jejb@parisc-linux.org <jejb@parisc-linux.org>
> > > Cc: deller@gmx.de <deller@gmx.de>
> > > Cc: chris@zankel.net <chris@zankel.net>
> > > Cc: jcmvbkbc@gmail.com <jcmvbkbc@gmail.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: linux-arch@vger.kernel.org
> > > Cc: linux-api@vger.kernel.org
> > > Acked-by: Minchan Kim <minchan@kernel.org>
> > > Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> > 
> > Let me add
> > Acked-by: Hugh Dickins <hughd@google.com>
> > to this one too.
> > 
> > But I have extended your mail's Cc list: Darrick pointed out earlier
> > that dietlibc has a Solaris #define MADV_FREE 0x5 in its mman.h,
> > and that was in the kernel's sparc mman.h up until 2.6.25.  I doubt
> > that presents any obstacle nowadays, but Dave Miller should be Cc'ed.

For the convenience for Dave, I found this.

commit ec98c6b9b47df6df1c1fa6cf3d427414f8c2cf16
Author: David S. Miller <davem@davemloft.net>
Date:   Sun Apr 20 02:14:23 2008 -0700

    [SPARC]: Remove SunOS and Solaris binary support.
    
    As per Documentation/feature-removal-schedule.txt
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

Hello Dave,
Could you confirm it?

Thanks.

