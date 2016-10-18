From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] thread_info: include <current.h> for THREAD_INFO_IN_TASK
 (WAS: [PATCH 2/3] sched/preempt: include asm/current.h)
Date: Tue, 18 Oct 2016 12:34:40 +0200
Message-ID: <20161018103440.GA4061@osiris>
References: <20161014081638.GA4047@osiris>
 <1476441745-10765-1-git-send-email-mark.rutland@arm.com>
 <20161017144700.GA11204@leverpostej>
 <20161017173315.GB23170@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46865 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933906AbcJRKeu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Oct 2016 06:34:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9IAYPux035370
        for <linux-arch@vger.kernel.org>; Tue, 18 Oct 2016 06:34:49 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 265hpt14r6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 18 Oct 2016 06:34:49 -0400
Received: from localhost
        by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 18 Oct 2016 11:34:46 +0100
Content-Disposition: inline
In-Reply-To: <20161017173315.GB23170@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Mon, Oct 17, 2016 at 06:33:15PM +0100, Mark Rutland wrote:
> On Mon, Oct 17, 2016 at 03:48:13PM +0100, Mark Rutland wrote:
> > On Fri, Oct 14, 2016 at 11:42:25AM +0100, Mark Rutland wrote:
> > > When CONFIG_THREAD_INFO_IN_TASK is selected, the current_thread_info()
> > > macro relies on current having been defined prior to its use. However,
> > > not all users of current_thread_info() include <asm/current.h>, and thus
> > > current is not guaranteed to be defined.
> > > 
> > > When CONFIG_THREAD_INFO_IN_TASK is not selected, it's possible that
> > > get_current() / current are based upon current_thread_info(), and
> > > <asm/current.h> includes <asm/thread_info.h>. Thus always including
> > > <asm/current.h> would result in circular dependences on some platforms.
> > > 
> > > To ensure both cases work, this patch includes <asm/current.h>, but only
> > > when CONFIG_THREAD_INFO_IN_TASK is selected.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > ---
> > >  include/linux/thread_info.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > As discussed, it would be great if this could go in along with the patch to
> > > make thread_info arch-specific again, to make merging the arch-specific parts
> > > easier (for arm64 and s390).
> > 
> > Urrgh; I've just recalled that this patch alone is insufficient. The
> > h8300 arch code has an unfixed bug [1], and relies on some implicit
> > definition ordering that will be broken by this patch.
> > 
> > I have a workaround/cleanup for core code that I'll send with an updated
> > version of my arm64 series shortly.
> 
> Looks like I spoke too soon. I have another circular include issue with
> raw_smp_processor_id() and task_struct::cpu to solve -- it looks like
> s390 doesn't suffer from that per my reading of your headers.

That's correct.

> In the mean time, I've pushed out a branch [2] with the common patches,
> atop of v4.9-rc1.

I just verified that your branch works fine for s390 (with and without the
THREAD_INFO_IN_TASK conversion).

Thanks,
Heiko
