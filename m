Return-Path: <SRS0=zFKq=3O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgAYE6p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 23:58:45 -0500
Date: Fri, 24 Jan 2020 20:58:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Message-ID: <20200125045844.GC2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200124222434.GA7196@paulmck-ThinkPad-P72>
 <6AAE7FC6-F5DE-4067-8BC4-77F27948CD09@oracle.com>
 <20200125005713.GZ2935@paulmck-ThinkPad-P72>
 <02defadb-217d-7803-88a1-ec72a37eda28@redhat.com>
 <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb4fb09-f374-4d64-096b-ba9ad8b35fd5@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com
Message-ID: <20200125045845.rUzdzr_RfayrZWouEJCERoFOgOd_1gfCgTJ4ZbNr8_Q@z>

On Fri, Jan 24, 2020 at 09:17:05PM -0500, Waiman Long wrote:
> On 1/24/20 8:59 PM, Waiman Long wrote:
> >> You called it!  I will play with QEMU's -numa argument to see if I can get
> >> CNA to run for me.  Please accept my apologies for the false alarm.
> >>
> >> 							Thanx, Paul
> >>
> > CNA is not currently supported in a VM guest simply because the numa
> > information is not reliable. You will have to run it on baremetal to
> > test it. Sorry for that.
> 
> Correction. There is a command line option to force CNA lock to be used
> in a VM. Use the "numa_spinlock=on" boot command line parameter.

As I understand it, I need to use a series of -numa arguments to qemu
combined with the numa_spinlock=on (or =1) on the kernel command line.
If the kernel thinks that there is only one NUMA node, it appears to
avoid doing CNA.

Correct?

							Thanx, Paul
