Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40824 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1725940AbfDUGjJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Sun, 21 Apr 2019 02:39:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1]) by
 mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3L6XWxe132198
 for <linux-arch@vger.kernel.org>; Sun, 21 Apr 2019 02:39:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100]) by
 mx0a-001b2d01.pphosted.com with ESMTP id 2s0ggvv4vs-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Sun, 21 Apr 2019 02:39:08 -0400
Received: from localhost by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>; Sun, 21 Apr 2019
 07:39:06 +0100
Date: Sun, 21 Apr 2019 09:38:59 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: DISCONTIGMEM is deprecated
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419140521.GI7751@bombadil.infradead.org>
Message-ID: <20190421063859.GA19926@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20190421063859.RrhQP176gjy7R7y6eXYQqyNsYLTVi-YmIOCgoderMfk@z>

On Fri, Apr 19, 2019 at 07:05:21AM -0700, Matthew Wilcox wrote:
> On Fri, Apr 19, 2019 at 10:43:35AM +0100, Mel Gorman wrote:
> > DISCONTIG is essentially deprecated and even parisc plans to move to
> > SPARSEMEM so there is no need to be fancy, this patch simply disables
> > watermark boosting by default on DISCONTIGMEM.
> 
> I don't think parisc is the only arch which uses DISCONTIGMEM for !NUMA
> scenarios.  Grepping the arch/ directories shows:
> 
> alpha (does support NUMA, but also non-NUMA DISCONTIGMEM)
> arc (for supporting more than 1GB of memory)
> ia64 (looks complicated ...)
> m68k (for multiple chunks of memory)
> mips (does support NUMA but also non-NUMA)
> parisc (both NUMA and non-NUMA)

i386 NUMA as well

> I'm not sure that these architecture maintainers even know that DISCONTIGMEM
> is deprecated.  Adding linux-arch to the cc.
> 

-- 
Sincerely yours,
Mike.
