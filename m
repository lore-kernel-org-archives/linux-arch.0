Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfEaIZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:25:37 -0400
Date: Fri, 31 May 2019 10:25:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Message-ID: <20190531082528.GJ2623@hirez.programming.kicks-ass.net>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <20190530185358.GG28207@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530185358.GG28207@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Will Deacon <Will.Deacon@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190531082528.ZGsTQxUNYlehNWI1H7m5Ond-VZr8zwhNBw6Ux7lwW-Y@z>

On Thu, May 30, 2019 at 11:53:58AM -0700, Paul E. McKenney wrote:
> On Thu, May 30, 2019 at 11:22:42AM -0700, Vineet Gupta wrote:
> > Hi Peter,
> > 
> > Had an interesting lunch time discussion with our hardware architects pertinent to
> > "minimal guarantees expected of a CPU" section of memory-barriers.txt
> > 
> > 
> > |  (*) These guarantees apply only to properly aligned and sized scalar
> > |     variables.  "Properly sized" currently means variables that are
> > |     the same size as "char", "short", "int" and "long".  "Properly
> > |     aligned" means the natural alignment, thus no constraints for
> > |     "char", two-byte alignment for "short", four-byte alignment for
> > |     "int", and either four-byte or eight-byte alignment for "long",
> > |     on 32-bit and 64-bit systems, respectively.
> > 
> > 
> > I'm not sure how to interpret "natural alignment" for the case of double
> > load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
> > alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)
> > 
> > I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
> > be atomic unless 8-byte aligned
> 
> I would not expect 8-byte accesses to be atomic on 32-bit systems unless
> some special instruction was in use.  But that usually means special
> intrinsics or assembly code.

If the GCC of said platform defaults to the double-word instructions for
long long, then I would very much expect natural alignment on it too.

If the feature is only available through inline asm or intrinsics, then
we can be a little more lenient perhaps.
