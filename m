From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: What if a TLB flush needed to sleep?
Date: Wed, 26 Mar 2008 06:32:39 -0600
Message-ID: <20080326123239.GG16721@parisc-linux.org>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1FE6DD409037234FAB833C420AA843ECE9DF60-7XlYjKTK0pM64kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Mar 25, 2008 at 01:49:54PM -0700, Luck, Tony wrote:
> 1) Is holding a spin lock a problem for any other arch when
> doing a TLB flush (I'm particularly thinking of those that
> need to use IPI shootdown for the purge)?

parisc certainly has that problem too.  It won't happen very often, but
it will do an on_each_cpu() and wait for the outcome once in a while.

> 2) Is it feasible to rearrange the MM code so that we don't
> hold any locks while doing a TLB flush?  Or should I implement
> some sort of spin_only_semaphore?

down_spin() is trivial to implement without knowing the details of the
semaphore code:

void down_spin(struct semaphore *sem)
{
	while (down_trylock(sem))
		cpu_relax();
}

Of course, someone who wrote it could do better ;-)

void down_spin(struct semaphore *sem)
{
	unsigned long flags;
	int count;

	spin_lock_irqsave(&sem->lock, flags);
	count = sem->count - 1;
	if (likely(count >= 0))
		sem->count = count;
	else
		__down_spin(sem);
	spin_unlock_irqrestore(&sem->lock, flags);
}

void __down_spin(struct semaphore *sem)
{
	struct semaphore_waiter waiter;

	list_add_tail(&waiter.list, &sem->wait_list);
	waiter.task = current;
	waiter.up = 0;

	spin_unlock_irq(&sem->lock);
	while (!waiter.up)
		cpu_relax();
	spin_lock_irq(&sem->lock);
}

This more complex implementation is better because:
 - It queues properly (see also down_timeout)
 - It spins on a stack-local variable, not on a global structure

Having done all that ... I bet parisc and ia64 aren't the only two
architectures which can sleep in their tlb flush handlers.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
