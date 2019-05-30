Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbfE3SzS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 14:55:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UIq8Fp032216
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 14:55:17 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stkat3h71-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 14:55:17 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 19:55:15 +0100
Date: Thu, 30 May 2019 11:53:58 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Reply-To: paulmck@linux.ibm.com
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
Message-ID: <20190530185358.GG28207@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190530185358.VHVADbILAImcqmeAbun6jEgu35uAOq1iLNXx43BIISc@z>

On Thu, May 30, 2019 at 11:22:42AM -0700, Vineet Gupta wrote:
> Hi Peter,
> 
> Had an interesting lunch time discussion with our hardware architects pertinent to
> "minimal guarantees expected of a CPU" section of memory-barriers.txt
> 
> 
> |  (*) These guarantees apply only to properly aligned and sized scalar
> |     variables.  "Properly sized" currently means variables that are
> |     the same size as "char", "short", "int" and "long".  "Properly
> |     aligned" means the natural alignment, thus no constraints for
> |     "char", two-byte alignment for "short", four-byte alignment for
> |     "int", and either four-byte or eight-byte alignment for "long",
> |     on 32-bit and 64-bit systems, respectively.
> 
> 
> I'm not sure how to interpret "natural alignment" for the case of double
> load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> 
> I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
> be atomic unless 8-byte aligned

I would not expect 8-byte accesses to be atomic on 32-bit systems unless
some special instruction was in use.  But that usually means special
intrinsics or assembly code.

> ARMv7 arch ref manual seems to confirm this. Quoting
> 
> | LDM, LDC, LDC2, LDRD, STM, STC, STC2, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR,
> | VSTM, and VSTR instructions are executed as a sequence of word-aligned word
> | accesses. Each 32-bit word access is guaranteed to be single-copy atomic. A
> | subsequence of two or more word accesses from the sequence might not exhibit
> | single-copy atomicity
> 
> While it seems reasonable form hardware pov to not implement such atomicity by
> default it seems there's an additional burden on application writers. They could
> be happily using a lockless algorithm with just a shared flag between 2 threads
> w/o need for any explicit synchronization. But upgrade to a new compiler which
> aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
> causing the code to suddenly stop working. Is the onus on them to declare such
> memory as c11 atomic or some such.

There are also GCC extensions that allow specifying the alignment of
structure fields.

								Thanx, Paul
