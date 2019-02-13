Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387500AbfBMTbe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 14:31:34 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DJNagh108715
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 14:31:32 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qms3n0ver-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 14:31:31 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Feb 2019 19:31:31 -0000
Date: Wed, 13 Feb 2019 11:31:27 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Reply-To: paulmck@linux.ibm.com
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
 <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
 <20190213183314.GB32494@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7D4FF0DE@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D4FF0DE@ORSMSX110.amr.corp.intel.com>
Message-ID: <20190213193127.GH4240@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>
Message-ID: <20190213193127.Qjnca4mi5RKcfaR-017qCdecTw-uXtu0UHpG_jJplTw@z>

On Wed, Feb 13, 2019 at 06:43:41PM +0000, Luck, Tony wrote:
> > I think the last time this came up, it was said that those people still
> > running Linux on Itanium were running old distro kernels, not upstream.
> >
> > So yeah, we could probably do whatever and nobody would ever notice,
> > except maybe Al, who is rumoured to still have an ia64 :-)
> 
> I haven't heard of anyone taking upstream kernels and actually using them
> for production work in a long time. It's mostly just a few folks keeping ia64
> alive "just because" these days.  I doubt any of them have an SGI Altix
> to test on (so realistically Altix was probably broken upstream many releases
> ago).

That would require a well-healed computer collector, wouldn't it?  Just to
run the thing.  ;-)

								Thanx, Paul
