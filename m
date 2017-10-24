From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/19] net: average: Kill off ACCESS_ONCE()
Date: Tue, 24 Oct 2017 06:49:39 -0700
Message-ID: <20171024134939.GY3659@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
 <1508792849-3115-9-git-send-email-paulmck@linux.vnet.ibm.com>
 <1508824691.2639.26.camel@sipsolutions.net>
 <20171024093412.slvps6vmluzmteru@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751692AbdJXNtp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Oct 2017 09:49:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9ODhHa3062386
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2017 09:49:44 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dt6jqs3f6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 24 Oct 2017 09:49:44 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 24 Oct 2017 09:49:43 -0400
Content-Disposition: inline
In-Reply-To: <20171024093412.slvps6vmluzmteru@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "snitzer@redhat.com" <snitzer@redhat.com>, "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>, "shuah@kernel.org" <shuah@kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "tj@kernel.org" <tj@kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>

On Tue, Oct 24, 2017 at 11:34:13AM +0200, Ingo Molnar wrote:
> 
> * Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> > On Mon, 2017-10-23 at 21:07 +0000, Paul E. McKenney wrote:
> > > From: Mark Rutland <mark.rutland@arm.com>
> > > 
> > > For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
> > > preference to ACCESS_ONCE(), and new code is expected to use one of the
> > > former. So far, there's been no reason to change most existing uses of
> > > ACCESS_ONCE(), as these aren't currently harmful.
> > > 
> > > However, for some features it is necessary to instrument reads and
> > > writes separately, which is not possible with ACCESS_ONCE(). This
> > > distinction is critical to correct operation.
> > > 
> > > It's possible to transform the bulk of kernel code using the Coccinelle
> > > script below. However, this doesn't pick up some uses, including those
> > > in <linux/average.h>. As a preparatory step, this patch converts the
> > > file to use {READ,WRITE}_ONCE() consistently.
> > > 
> > > At the same time, this patch addds missing includes necessary for
> > > {READ,WRITE}_ONCE(), *BUG_ON*(), and ilog2().
> > > 
> > > ----
> > > virtual patch
> > > 
> > > @ depends on patch @
> > > expression E1, E2;
> > > @@
> > > 
> > > - ACCESS_ONCE(E1) = E2
> > > + WRITE_ONCE(E1, E2)
> > > 
> > > @ depends on patch @
> > > expression E;
> > > @@
> > > 
> > > - ACCESS_ONCE(E)
> > > + READ_ONCE(E)
> > > ----
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Johannes Berg <johannes.berg@intel.com>
> > 
> > Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Thanks!
> 
> > Let me know if you want me to apply this, since I seem to be the
> > average.h maintainer :-)
> 
> Would be nice to keep these patches together if possible, so that we can remove 
> ACCESS_ONCE() - or at least add a build warning.

My goal is to remove it.  After all, I am the guy who added it.  ;-)

							Thanx, Paul
