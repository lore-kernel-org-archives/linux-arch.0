From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/5] locking/qspinlock: Make
 arch_mcs_spin_unlock_contended more generic
Date: Tue, 16 Jul 2019 12:23:14 +0200
Message-ID: <20190716102314.GO3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-2-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-2-alex.kogan@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 15, 2019 at 03:25:32PM -0400, Alex Kogan wrote:

> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index e14b32c69639..961781624638 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -558,7 +558,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	if (!next)
>  		next = smp_cond_load_relaxed(&node->next, (VAL));
>  
> -	arch_mcs_spin_unlock_contended(&next->locked);
> +	arch_mcs_spin_unlock_contended(&next->locked, 1);
>  	pv_kick_node(lock, next);

My problem with this patch is that the above reads really daft. Should
we rename the whole function? arch_mcs_pass_lock() perhaps?
