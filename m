From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
Date: Tue, 12 Feb 2019 11:58:03 -0800
Message-ID: <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1549913486-16799-3-git-send-email-longman@redhat.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 11, 2019 at 11:31 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to make it generate slightly better code
> (smaller and maybe a tiny bit faster).

This looks good, but I would ask you to try one slightly different approach.

Instead of this:

>        long tmp = atomic_long_read(&sem->count);
>
>        while (tmp >= 0) {
>                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
>                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
>                        return 1;
>                }
>        }

try doing this instead:

        long tmp = 0;

        do {
                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
                        return 1;
        } while (tmp >= 0);
        return 0;

because especially when it comes to locking, it's usually better to
just *guess* that the lock is unlocked, than it is to actually read
from the line to see what the state is.

Often - but certainly not always - the lock is the first access to the
target cacheline, and assuming the trylock is successful (which I
think is the case we want to optimize for), we're much better off
causing that first access to be a read-for-ownership, rather than a
read-for-sharing.

Because if you first read from the line, and then do a cmpxchg, and if
the line was not in the cache, your cache coherency protocol will
generally go through two states: first shared (for the initial read)
and then exclusive-dirty (for the cmpxchg).

Now, this is obviously very micro-architecture dependent, and in fact
the microarchitecture could even see the "predict fallthrough to a
cmpxchg with the same address" and turn the first read into a
read-for-ownership, but we've done this at some point before, and the
"guess unlocked" was actually the one that performed better.

Of course, the downside is that it might be worse when the guess is
incorrect - either because of a nested read lock or due to an actual
conflict with a write, but on the whole those *should* be the rare
cases, and not the cases where we necessarily optimize for latency of
the operation.

Hmm?

                    Linus
