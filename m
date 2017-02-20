From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/2] x86/kvm: Reduce vcpu_is_preempted() overhead
Date: Mon, 20 Feb 2017 20:54:26 +0100
Message-ID: <20170220195426.GF6515@twins.programming.kicks-ass.net>
References: <1487615764-1343-1-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1487615764-1343-1-git-send-email-longman@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 20, 2017 at 01:36:02PM -0500, Waiman Long wrote:
> Waiman Long (2):
>   x86/paravirt: Change vcp_is_preempted() arg type to long
>   x86/kvm: Provide optimized version of vcpu_is_preempted() for x86-64
> 
>  arch/x86/include/asm/paravirt.h      |  2 +-
>  arch/x86/include/asm/qspinlock.h     |  2 +-
>  arch/x86/kernel/asm-offsets_64.c     |  9 +++++++++
>  arch/x86/kernel/kvm.c                | 26 +++++++++++++++++++++++++-
>  arch/x86/kernel/paravirt-spinlocks.c |  2 +-
>  5 files changed, 37 insertions(+), 4 deletions(-)

I'm assuming this will go through the KVM tree, if people want me to
take it through the tip tree, please let me know.

Acked-by: Peter Zijlstra (Intel) <peterz@infraded.org>
