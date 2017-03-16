Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44211 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753717AbdCPTLN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Mar 2017 15:11:13 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2GJ4DfM071821
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2017 15:11:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 297we8h2af-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 16 Mar 2017 15:11:07 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 16 Mar 2017 15:11:06 -0400
Date: Thu, 16 Mar 2017 12:11:02 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/7] x86/mm: Switch to generic get_user_page_fast()
 implementation
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
 <20170316152655.37789-8-kirill.shutemov@linux.intel.com>
 <20170316172046.sl7j5elg77yjevau@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170316172046.sl7j5elg77yjevau@hirez.programming.kicks-ass.net>
Message-ID: <20170316191102.GM3637@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Steve Capper <steve.capper@linaro.org>, Dann Frazier <dann.frazier@canonical.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170316191102.mI-zo0G4-2_Nt9DdewSLwBFIxvg48rDlSHn5XOV1Whc@z>

On Thu, Mar 16, 2017 at 06:20:46PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 16, 2017 at 06:26:55PM +0300, Kirill A. Shutemov wrote:
> > +config HAVE_GENERIC_RCU_GUP
> > +	def_bool y
> > +
> 
> Nothing immediately jumped out to me; except that this option might be
> misnamed.
> 
> AFAICT that code does not in fact rely on HAVE_RCU_TABLE_FREE; it will
> happily work with the (x86) broadcast IPI invalidate model, as you show
> here.
> 
> Architectures that do not do that obviously need HAVE_RCU_TABLE_FREE,
> but that is not the point I feel.
> 
> Also, this code hard relies on IRQ-disable delaying grace periods, which
> is mostly true I think, but has always been something Paul didn't really
> want to commit too firmly to.

That is quite true!

The only case where IRQ-disable is guaranteed to delay grace periods is
when you are using RCU-sched, in other words synchronize_sched() and
call_rcu_sched().  And even then, the CPU cannot be in the idle loop,
cannot be offline, and cannot be a nohz_full CPU on its way to/from
userspace execution.

							Thanx, Paul
