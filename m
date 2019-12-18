From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/3] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
Date: Wed, 18 Dec 2019 15:15:01 +0100
Message-ID: <20191218141501.GT2844@hirez.programming.kicks-ass.net>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
 <20191218053530.73053-2-aneesh.kumar@linux.ibm.com>
 <20191218091733.GO2844@hirez.programming.kicks-ass.net>
 <0f0bea3b-b7b5-fa8c-f75c-396cf78c47b4@linux.ibm.com>
 <87v9qdn5df.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87v9qdn5df.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, akpm@linux-foundation.org, npiggin@gmail.com, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, Scott Wood <oss@buserror.net>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 19, 2019 at 12:13:48AM +1100, Michael Ellerman wrote:

> >> I'm a little confused though; if nohash is a software TLB fill, why do
> >> you need a TLBI for tables?
> >> 
> >
> > nohash (AKA book3e) has different mmu modes. I don't follow all the 
> > details w.r.t book3e. Paul or Michael might be able to explain the need 
> > for table flush with book3e.
> 
> Some of the Book3E CPUs have a partial hardware table walker. The IBM one (A2)
> did, before we ripped that support out. And the Freescale (NXP) e6500
> does, see eg:
> 
>   28efc35fe68d ("powerpc/e6500: TLB miss handler with hardware tablewalk support")
> 
> They only support walking one level IIRC, ie. you can create a TLB entry
> that points to a PTE page, and the hardware will dereference that to get
> a PTE and load that into the TLB.

Shiny!, all the embedded goodness. Thanks for the info.
