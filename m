From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v16 13/14] pvqspinlock: Improve slowpath performance by
	avoiding cmpxchg
Date: Mon, 4 May 2015 16:05:51 +0200
Message-ID: <20150504140551.GJ23123@twins.programming.kicks-ass.net>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
	<1429901803-29771-14-git-send-email-Waiman.Long@hp.com>
	<20150429181112.GI23123@twins.programming.kicks-ass.net>
	<55427936.4080900@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55427936.4080900@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 30, 2015 at 02:49:26PM -0400, Waiman Long wrote:
> On 04/29/2015 02:11 PM, Peter Zijlstra wrote:
> >On Fri, Apr 24, 2015 at 02:56:42PM -0400, Waiman Long wrote:
> >>In the pv_scan_next() function, the slow cmpxchg atomic operation is
> >>performed even if the other CPU is not even close to being halted. This
> >>extra cmpxchg can harm slowpath performance.
> >>
> >>This patch introduces the new mayhalt flag to indicate if the other
> >>spinning CPU is close to being halted or not. The current threshold
> >>for x86 is 2k cpu_relax() calls. If this flag is not set, the other
> >>spinning CPU will have at least 2k more cpu_relax() calls before
> >>it can enter the halt state. This should give enough time for the
> >>setting of the locked flag in struct mcs_spinlock to propagate to
> >>that CPU without using atomic op.
> >Yuck! I'm not at all sure you can make assumptions like that. And the
> >worst part is, if it goes wrong the borkage is subtle and painful.
> 
> I do think the code is OK. However, you are right that if my reasoning is
> incorrect, the resulting bug will be really subtle. 

So I do not think its correct, imagine the fabrics used for the 4096 cpu
SGI machine, now add some serious traffic to them. There is no saying
your random 2k relax loop will be enough to propagate the change.

Equally, another arch (this is generic code) might have starvation
issues on its inter-cpu fabric and delay the store just long enough.

The thing is, one should _never_ rely on timing for correctness, _ever_.

> So I am going to
> withdraw this particular patch as it has no functional impact to the overall
> patch series. Please let me know if you have any other comments on other
> parts of the series and I will send send out a new series without this
> particular patch.

Please wait a little while, I've queued the 'basic' patches, once that
settles in tip we can look at the others.

Also, I have some local changes (sorry, I could not help mysef) I should
post, I've been somewhat delayed by illness.
