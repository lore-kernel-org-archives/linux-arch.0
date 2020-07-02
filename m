From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/8] powerpc/pseries: use smp_rmb() in H_CONFER spin yield
Date: Thu, 2 Jul 2020 10:28:40 +0200
Message-ID: <20200702082840.GC4781@hirez.programming.kicks-ass.net>
References: <20200702074839.1057733-1-npiggin@gmail.com>
 <20200702074839.1057733-3-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200702074839.1057733-3-npiggin@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 02, 2020 at 05:48:33PM +1000, Nicholas Piggin wrote:
> There is no need for rmb(), this allows faster lwsync here.

Since you determined this; I'm thinking you actually understand the
ordering here. How about recording this understanding in a comment?

Also, should the lock->slock load not use READ_ONCE() ?
