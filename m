From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 1/6] arm64: Detect the ARMv8.4 TTL feature
Date: Tue, 21 Apr 2020 19:13:28 +0200
Message-ID: <20200421171328.GW20730@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-2-yezhenyu2@huawei.com>
 <20200421165346.GA11171@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200421165346.GA11171@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, linux-mm@kvack.org, guohanjun@huawei.com, will@kernel.org, linux-arch@vger.kernel.org, yuzhao@google.com, maz@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, arm@kernel.org, Dave.Martin@arm.com, arnd@arndb.de, Zhenyu Ye <yezhenyu2@huawei.com>, npiggin@gmail.com, zhangshaokun@hisilicon.com, broonie@kernel.org, rostedt@goodmis.org, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, xiexiangyou@huawei.com, linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
