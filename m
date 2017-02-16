From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/2] x86/paravirt: Change vcp_is_preempted() arg type
	to long
Date: Thu, 16 Feb 2017 17:09:30 +0100
Message-ID: <20170216160930.GC6515@twins.programming.kicks-ass.net>
References: <1487194670-6319-1-git-send-email-longman@redhat.com>
	<1487194670-6319-2-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1487194670-6319-2-git-send-email-longman@redhat.com>
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

On Wed, Feb 15, 2017 at 04:37:49PM -0500, Waiman Long wrote:
> The cpu argument in the function prototype of vcpu_is_preempted()
> is changed from int to long. That makes it easier to provide a better
> optimized assembly version of that function.
> 
> For Xen, vcpu_is_preempted(long) calls xen_vcpu_stolen(int), the
> downcast from long to int is not a problem as vCPU number won't exceed
> 32 bits.
> 

Note that because of the cast in PVOP_CALL_ARG1() this patch is
pointless.

Then again, it doesn't seem to affect code generation, so why not. Takes
away the reliance on that weird cast.
