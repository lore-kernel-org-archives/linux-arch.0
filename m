From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/3] sched/preempt: include asm/current.h
Date: Fri, 14 Oct 2016 10:16:38 +0200
Message-ID: <20161014081638.GA4047@osiris>
References: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
 <20161013115712.29517-3-heiko.carstens@de.ibm.com>
 <20161013232556.GA24167@remoulade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754344AbcJNIQq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Oct 2016 04:16:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9E8EPVE109676
        for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2016 04:16:46 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 262rva864e-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2016 04:16:45 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 14 Oct 2016 09:16:43 +0100
Content-Disposition: inline
In-Reply-To: <20161013232556.GA24167@remoulade>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Fri, Oct 14, 2016 at 12:25:56AM +0100, Mark Rutland wrote:
> Hi,
> 
> On Thu, Oct 13, 2016 at 01:57:11PM +0200, Heiko Carstens wrote:
> > The generic preempt code needs to include <asm/current.h>. Otherwise
> > compilation fails if THREAD_INFO_IN_TASK is selected and the generic
> > preempt code is used:
> > 
> > ./include/linux/thread_info.h:17:54: error: 'current' undeclared (first use in this function)
> >  #define current_thread_info() ((struct thread_info *)current)
> 
> I don't think this is the right fix. Users of current_thread_info() should only
> have to include <linux/thread_info.h>, as <asm-generic/preempt.h> already does.
> 
> I have a patch [1] which has <linux/thread_info.h> include <asm/current.h> the
> THREAD_INFO_IN_TASK case (while avoiding circular includes over <asm/current.h>
> and <asm/thread_info.h> in the !THREAD_INFO_IN_TASK case).

I added that include initially to <linux/thread_info.h> too, but was afraid
of include dependency hell. So I tried the minimal version, and it worked.

However with the ifdef within your patch you make sure that nothing breaks
by accident; so I think your version is better.

> I was planning on posting an updated series with that come -rc1.

That could/should also go into 4.9, so architectures could independently
convert to THREAD_INFO_IN_TASK for the next merge window.
