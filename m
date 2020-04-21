Return-Path: <SRS0=lzY1=6F=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 21 Apr 2020 19:13:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 1/6] arm64: Detect the ARMv8.4 TTL feature
Message-ID: <20200421171328.GW20730@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-2-yezhenyu2@huawei.com>
 <20200421165346.GA11171@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421165346.GA11171@infradead.org>
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhenyu Ye <yezhenyu2@huawei.com>, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, xiexiangyou@huawei.com, zhangshaokun@hisilicon.com, linux-mm@kvack.org, arm@kernel.org, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, linux-arm-kernel@lists.infradead.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200421171328.o4yjCzR2j-QEXRPk8rg9pZPlFIMbjNC62S3GdxyOAtg@z>

On Tue, Apr 21, 2020 at 09:53:46AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 03, 2020 at 05:00:43PM +0800, Zhenyu Ye wrote:
> > From: Marc Zyngier <maz@kernel.org>
> > 
> > In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> > feature allows TLBs to be issued with a level allowing for quicker
> > invalidation.
> 
> What does "issued with a level" mean?

What I understood it to be is page-size based on page-table hierarchy.
Just like we have on x86, 4k, 2m, 1g etc..

So where x86 INVLPG will tear down any sized page for the address given,
you can now day, kill me the PMD level translation for @addr.

Power9 radix also has things like this.
