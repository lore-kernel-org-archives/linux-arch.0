Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbfFCUNb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 16:13:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53KDOX8083623
        for <linux-arch@vger.kernel.org>; Mon, 3 Jun 2019 16:13:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sw9kxj5mn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 03 Jun 2019 16:13:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 3 Jun 2019 21:13:28 +0100
Date: Mon, 3 Jun 2019 13:13:24 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Reply-To: paulmck@linux.ibm.com
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190531082112.GH2623@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2522B5B@us01wembx1.internal.synopsys.com>
Message-ID: <20190603201324.GN28207@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190603201324.ma2QVxgVh2_uqTELWbKfdGCB_DlfpTovT8KvmNMAZGo@z>

On Mon, Jun 03, 2019 at 06:08:35PM +0000, Vineet Gupta wrote:
> On 5/31/19 1:21 AM, Peter Zijlstra wrote:
> >> I'm not sure how to interpret "natural alignment" for the case of double
> >> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> >> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> > Natural alignment: !((uintptr_t)ptr % sizeof(*ptr))
> >
> > For any u64 type, that would give 8 byte alignment. the problem
> > otherwise being that your data spans two lines/pages etc..
> 
> Sure, but as Paul said, if the software doesn't expect them to be atomic by
> default, they could span 2 hardware lines to keep the implementation simpler/sane.

I could imagine 8-byte types being only four-byte aligned on 32-bit systems,
but it would be quite a surprise on 64-bit systems.

							Thanx, Paul
