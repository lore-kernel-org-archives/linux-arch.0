From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v8 00/10] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Thu, 3 Apr 2014 13:23:34 -0400
Message-ID: <20140403172333.GA3877@localhost.localdomain>
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com>
	<20140402143201.GF12188@phenom.dumpdata.com>
	<533C7485.3030203@hp.com> <533CC309.3020607@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <533CC309.3020607@hp.com>
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
Cc: x86@kernel.org, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Marcos Matsunaga <Marcos.Matsunaga@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Scott J Norton <scott.norton@hp.com>, Paolo Bonzini <paolo.bonzini@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 02, 2014 at 10:10:17PM -0400, Waiman Long wrote:
> On 04/02/2014 04:35 PM, Waiman Long wrote:
> >On 04/02/2014 10:32 AM, Konrad Rzeszutek Wilk wrote:
> >>On Wed, Apr 02, 2014 at 09:27:29AM -0400, Waiman Long wrote:
> >>>N.B. Sorry for the duplicate. This patch series were resent as the
> >>>      original one was rejected by the vger.kernel.org list server
> >>>      due to long header. There is no change in content.
> >>>
> >>>v7->v8:
> >>>   - Remove one unneeded atomic operation from the slowpath, thus
> >>>     improving performance.
> >>>   - Simplify some of the codes and add more comments.
> >>>   - Test for X86_FEATURE_HYPERVISOR CPU feature bit to enable/disable
> >>>     unfair lock.
> >>>   - Reduce unfair lock slowpath lock stealing frequency depending
> >>>     on its distance from the queue head.
> >>>   - Add performance data for IvyBridge-EX CPU.
> >>FYI, your v7 patch with 32 VCPUs (on a 32 cpu socket machine) on an
> >>HVM guest under Xen after a while stops working. The workload
> >>is doing 'make -j32' on the Linux kernel.
> >>
> >>Completely unresponsive. Thoughts?
> >>
> >
> >Thank for reporting that. I haven't done that much testing on Xen.
> >My focus was in KVM. I will perform more test on Xen to see if I
> >can reproduce the problem.
> >
> 
> BTW, does the halting and sending IPI mechanism work in HVM? I saw

Yes.
> that in RHEL7, PV spinlock was explicitly disabled when in HVM mode.
> However, this piece of code isn't in upstream code. So I wonder if
> there is problem with that.

The PV ticketlock fixed it for HVM. It was disabled before because
the PV guests were using bytelocks while the HVM were using ticketlocks
and you couldnt' swap in PV bytelocks for ticketlocks during startup.

> 
> -Longman
