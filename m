From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Sat, 25 Jan 2020 12:20:39 +0100
Message-ID: <20200125112039.GX11457@worktop.programming.kicks-ass.net>
References: <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <45660873-731a-a810-8c57-1a5a19d266b4@redhat.com>
 <b26837a9-d0cd-4413-95ec-1deaca184324@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b26837a9-d0cd-4413-95ec-1deaca184324@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, Arnd Bergmann <arnd@arndb.de>, dave.dice@oracle.com, Jan Glauber <jglauber@marvell.com>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, Alex Kogan <alex.kogan@oracle.com>, Steven Sistare <steven.sistare@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 24, 2020 at 01:51:34PM -0500, Waiman Long wrote:

< 71 lines of garbage >

> > You can use the in_task() macro in include/linux/preempt.h. This is
> > just a percpu preempt_count read and test. If in_task() is false, it
> > is in a {soft|hard}irq or nmi context. If it is true, you can check
> > the rt_task() macro to see if it is an RT task. That will access to
> > the current task structure. So it may cost a little bit more if you
> > want to handle the RT task the same way.
> >
> We may not need to do that for softIRQ context. If that is the case, you
> can use in_irq() which checks for hardirq and nmi only. Peter, what is
> your thought on that?

Can you lot please start trimming emails when you reply?
