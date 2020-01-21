From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 21 Jan 2020 14:50:34 +0100
Message-ID: <20200121135034.GA14946@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200121132949.GL14914@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, bristot@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 21, 2020 at 02:29:49PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:
> 
> > +/*
> > + * Controls the threshold for the number of intra-node lock hand-offs before
> > + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
> > + * another NUMA node. By default, the chosen value provides reasonable
> > + * long-term fairness without sacrificing performance compared to a lock
> > + * that does not have any fairness guarantees. The default setting can
> > + * be changed with the "numa_spinlock_threshold" boot option.
> > + */
> > +int intra_node_handoff_threshold __ro_after_init = 1 << 16;
> 
> There is a distinct lack of quantitative data to back up that
> 'reasonable' claim there.
> 
> Where is the table of inter-node latencies observed for the various
> values tested, and on what criteria is this number deemed reasonable?
> 
> To me, 64k lock hold times seems like a giant number, entirely outside
> of reasonable.

Daniel, IIRC you just did a paper on constructing worst case latencies
from measuring pieces. Do you have data on average lock hold times?
