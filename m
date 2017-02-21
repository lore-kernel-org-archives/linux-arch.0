From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 0/2] x86/kvm: Reduce vcpu_is_preempted() overhead
Date: Tue, 21 Feb 2017 12:49:07 +0100
Message-ID: <62938e9e-6d25-80e3-2fb2-2812ad948605@redhat.com>
References: <1487615764-1343-1-git-send-email-longman@redhat.com>
	<20170220195426.GF6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170220195426.GF6515@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alok Kataria <akataria@vmware.com>
List-Id: linux-arch.vger.kernel.org



On 20/02/2017 20:54, Peter Zijlstra wrote:
> On Mon, Feb 20, 2017 at 01:36:02PM -0500, Waiman Long wrote:
>> Waiman Long (2):
>>   x86/paravirt: Change vcp_is_preempted() arg type to long
>>   x86/kvm: Provide optimized version of vcpu_is_preempted() for x86-64
>>
>>  arch/x86/include/asm/paravirt.h      |  2 +-
>>  arch/x86/include/asm/qspinlock.h     |  2 +-
>>  arch/x86/kernel/asm-offsets_64.c     |  9 +++++++++
>>  arch/x86/kernel/kvm.c                | 26 +++++++++++++++++++++++++-
>>  arch/x86/kernel/paravirt-spinlocks.c |  2 +-
>>  5 files changed, 37 insertions(+), 4 deletions(-)
> 
> I'm assuming this will go through the KVM tree, if people want me to
> take it through the tip tree, please let me know.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infraded.org>

Applied, thanks.

Paolo
