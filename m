From: peterz@infradead.org
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Date: Thu, 23 Jul 2020 20:47:59 +0200
Message-ID: <20200723184759.GS119549@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <845de183-56f5-2958-3159-faa131d46401@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Boqun Feng <boqun.feng@gmail.com>, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, kvm-ppc@vger.kernel.org, Anton Blanchard <anton@ozlabs.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
> BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
> I will have to update the patch to fix the reported 0-day test problem, but
> I want to collect other feedback before sending out v3.

I want to say I hate it all, it adds instructions to a path we spend an
aweful lot of time optimizing without really getting anything back for
it.

Will, how do you feel about it?
