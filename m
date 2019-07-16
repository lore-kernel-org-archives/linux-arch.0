From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Tue, 16 Jul 2019 13:04:27 +0200
Message-ID: <20190716110427.GP3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <77bba626-f3e6-45a8-aae8-43b945d0fab9@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Alex Kogan <alex.kogan@oracle.com>, steven.sistare@oracle.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 15, 2019 at 05:30:01PM -0400, Waiman Long wrote:
> On 7/15/19 3:25 PM, Alex Kogan wrote:
> >  /*
> > - * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
> > - * size and four of them will fit nicely in one 64-byte cacheline. For
> > - * pvqspinlock, however, we need more space for extra data. To accommodate
> > - * that, we insert two more long words to pad it up to 32 bytes. IOW, only
> > - * two of them can fit in a cacheline in this case. That is OK as it is rare
> > - * to have more than 2 levels of slowpath nesting in actual use. We don't
> > - * want to penalize pvqspinlocks to optimize for a rare case in native
> > - * qspinlocks.
> > + * On 64-bit architectures, the mcs_spinlock structure will be 20 bytes in
> > + * size. For pvqspinlock or the NUMA-aware variant, however, we need more
> > + * space for extra data. To accommodate that, we insert two more long words
> > + * to pad it up to 36 bytes.
> >   */

> The 20 bytes figure is wrong. It is actually 24 bytes for 64-bit as the
> mcs_spinlock structure is 8-byte aligned. For better cacheline
> alignment, I will like to keep mcs_spinlock to 16 bytes as before.
> Instead, you can use encode_tail() to store the CNA node pointer in
> "locked". For instance, use (encode_tail() << 1) in locked to
> distinguish it from the regular locked=1 value.

Yes, please don't bloat this. I already don't like what Waiman did for
the paravirt case, but this is horrible.
