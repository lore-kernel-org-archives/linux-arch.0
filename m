From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH-tip v2 0/2] locking/qrwlock: Improve qrwlock performance
Date: Thu, 16 Jul 2015 16:53:12 +0100
Message-ID: <20150716155312.GK26390@arm.com>
References: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

Hi Waiman,

On Thu, Jul 09, 2015 at 05:32:21PM +0100, Waiman Long wrote:
> v1->v2:
>  - Take out patch 1 which had been merged to tip.
>  - Take out patch 4 as the change may impact light load performance
>  - Rebased to the latest tip branch
> 
> In converting some existing spinlocks to rwlock, it was found that
> the write lock slowpath performance isn't as good as the qspinlock.
> This patch series tries to improve qrwlock performance to close the
> gap between qspinlock and qrwlock.
> 
> With this patch series in place, we can start converting some spinlocks
> back to rwlocks where it makes sense and the lock size increase isn't
> a concern.

Both of these patches look fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
