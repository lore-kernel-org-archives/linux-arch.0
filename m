From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v13 10/11] pvqspinlock, x86: Enable PV qspinlock for KVM
Date: Tue, 2 Dec 2014 14:10:58 -0500
Message-ID: <20141202191058.GA357@laptop.dumpdata.com>
References: <1414613951-32532-1-git-send-email-Waiman.Long@hp.com>
	<1414613951-32532-11-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1414613951-32532-11-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 29, 2014 at 04:19:10PM -0400, Waiman Long wrote:
> This patch adds the necessary KVM specific code to allow KVM to
> support the CPU halting and kicking operations needed by the queue
> spinlock PV code.
> 
> Two KVM guests of 20 CPU cores (2 nodes) were created for performance
> testing in one of the following three configurations:
>  1) Only 1 VM is active
>  2) Both VMs are active and they share the same 20 physical CPUs
>     (200% overcommit)
> 
> The tests run included the disk workload of the AIM7 benchmark on
> both ext4 and xfs RAM disks at 3000 users on a 3.17 based kernel. The
> "ebizzy -m" test and futextest was was also run and its performance
> data were recorded.  With two VMs running, the "idle=poll" kernel
> option was added to simulate a busy guest. If PV qspinlock is not
> enabled, unfairlock will be used automically in a guest.

What is the unfairlock? Isn't it just using a bytelock at this point?
