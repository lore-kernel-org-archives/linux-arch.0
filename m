From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 6/6] arm64: tlb: Set the TTL field in flush_tlb_range
Date: Tue, 21 Apr 2020 10:30:43 +0200
Message-ID: <20200421083043.GP20730@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-7-yezhenyu2@huawei.com>
 <20200420121055.GF20696@hirez.programming.kicks-ass.net>
 <20200420200616.44c7c7ea@oasis.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200420200616.44c7c7ea@oasis.local.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, linux-mm@kvack.org, guohanjun@huawei.com, will@kernel.org, linux-arch@vger.kernel.org, yuzhao@google.com, maz@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, arm@kernel.org, Dave.Martin@arm.com, arnd@arndb.de, Zhenyu Ye <yezhenyu2@huawei.com>, npiggin@gmail.com, zhangshaokun@hisilicon.com, broonie@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 20, 2020 at 08:06:16PM -0400, Steven Rostedt wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Apr 03, 2020 at 05:00:48PM +0800, Zhenyu Ye wrote:

> > > +static inline int tlb_get_level(struct mmu_gather *tlb)
> > > +{
> > > +	int sum = tlb->cleared_ptes + tlb->cleared_pmds +
> > > +		  tlb->cleared_puds + tlb->cleared_p4ds;
> > > +
> > > +	if (sum != 1)
> > > +		return 0;
> > > +	else if (tlb->cleared_ptes)
> > > +		return 3;
> > > +	else if (tlb->cleared_pmds)
> > > +		return 2;
> > > +	else if (tlb->cleared_puds)
> > > +		return 1;
> > > +
> > > +	return 0;
> > > +}  
> > 
> > That's some mighty wonky code. Please look at the generated asm.
> 
> Without even looking at the generated asm, if a condition returns,
> there's no reason to add an else for that condition.

Not really the point; he wants to guarantee he only returns >0 when
there's a single bit set. But the thing is, cleared_* is a bitfield, and
I'm afraid that the above will result in some terrible code-gen.

Maybe something like:

	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
				   tlb->cleared_puds ||
				   tlb->cleared_p4ds))
		return 3;

	if (tlb->cleared_pmds && !(tlb->cleared_ptes ||
				   tlb->cleared_puds ||
				   tlb->cleared_p4ds))
		return 2;

	if (tlb->cleared_puds && !(tlb->cleared_ptes ||
				   tlb->cleared_pmds ||
				   tlb->cleared_p4ds))
		return 1;

	return 0;

Which I admit is far too much typing, but I suspect it generates far
saner code (just a few masks and branches).

But maybe the compiler surprises us, what do I konw.
