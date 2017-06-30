From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 12/26] arm64: Remove spin_unlock_wait() arch-specific
 definitions
Date: Fri, 30 Jun 2017 10:29:43 -0700
Message-ID: <20170630172943.GY2393@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
 <1498780894-8253-12-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170630092057.GD9726@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751710AbdF3R3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jun 2017 13:29:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5UHTHuO070611
        for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2017 13:29:50 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bdm0wa24j-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2017 13:29:49 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 30 Jun 2017 13:29:49 -0400
Content-Disposition: inline
In-Reply-To: <20170630092057.GD9726@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org

On Fri, Jun 30, 2017 at 10:20:57AM +0100, Will Deacon wrote:
> On Thu, Jun 29, 2017 at 05:01:20PM -0700, Paul E. McKenney wrote:
> > There is no agreed-upon definition of spin_unlock_wait()'s semantics,
> > and it appears that all callers could do just as well with a lock/unlock
> > pair.  This commit therefore removes the underlying arch-specific
> > arch_spin_unlock_wait().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Andrea Parri <parri.andrea@gmail.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > ---
> >  arch/arm64/include/asm/spinlock.h | 58 ++++-----------------------------------
> >  1 file changed, 5 insertions(+), 53 deletions(-)
> 
> I'm going to miss this code.

;-) ;-) ;-)

> Acked-by: Will Deacon <will.deacon@arm.com>

Applied, thank you!

							Thanx, Paul
