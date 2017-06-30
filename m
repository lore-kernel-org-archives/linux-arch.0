Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60493 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751584AbdF3AKO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 20:10:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5U08fs6069068
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:10:04 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bd8cwpswe-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 20:10:03 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 20:10:02 -0400
Date: Thu, 29 Jun 2017 17:09:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 25/26] tile: Remove spin_unlock_wait() arch-specific
 definitions
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170629235918.GA6445@linux.vnet.ibm.com>
 <1498780894-8253-25-git-send-email-paulmck@linux.vnet.ibm.com>
 <CA+55aFxf=4+LEk6wSE3HPFdwSf_F0Ny9NRGXaA6daikY+TGbDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxf=4+LEk6wSE3HPFdwSf_F0Ny9NRGXaA6daikY+TGbDg@mail.gmail.com>
Message-ID: <20170630000956.GI2393@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <20170630000956.c90j6jAlaZXj-B4yNKoAnywhAX9YhmxgHk9_3vVk4j8@z>

On Thu, Jun 29, 2017 at 05:06:16PM -0700, Linus Torvalds wrote:
> On Thu, Jun 29, 2017 at 5:01 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > There is no agreed-upon definition of spin_unlock_wait()'s semantics,
> > and it appears that all callers could do just as well with a lock/unlock
> > pair.  This commit therefore removes the underlying arch-specific
> > arch_spin_unlock_wait().
> 
> Please don't make this one commit fopr every architecture.
> 
> Once something gets removed, it gets removed. There's no point in
> "remove it from architecture X". If there are no more users, we're
> done with it, and making it be 25 patches with the same commit message
> instead of just one doesn't help anybody.

Apologies, I will merge them.

							Thanx, Paul
