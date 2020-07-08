From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Wed, 8 Jul 2020 10:32:10 +0200
Message-ID: <20200708083210.GD597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 07, 2020 at 11:33:45PM -0400, Waiman Long wrote:
> From 5d7941a498935fb225b2c7a3108cbf590114c3db Mon Sep 17 00:00:00 2001
> From: Waiman Long <longman@redhat.com>
> Date: Tue, 7 Jul 2020 22:29:16 -0400
> Subject: [PATCH 2/9] locking/pvqspinlock: Introduce
>  CONFIG_PARAVIRT_QSPINLOCKS_LITE
> 
> Add a new PARAVIRT_QSPINLOCKS_LITE config option that allows
> architectures to use the PV qspinlock code without the need to use or
> implement a pv_kick() function, thus eliminating the atomic unlock
> overhead. The non-atomic queued_spin_unlock() can be used instead.
> The pv_wait() function will still be needed, but it can be a dummy
> function.
> 
> With that option set, the hybrid PV queued/unfair locking code should
> still be able to make it performant enough in a paravirtualized

How is this supposed to work? If there is no kick, you have no control
over who wakes up and fairness goes out the window entirely.

You don't even begin to explain...
