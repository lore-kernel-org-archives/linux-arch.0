From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 2/2] x86/kvm: Provide optimized version of
	vcpu_is_preempted() for x86-64
Date: Thu, 16 Feb 2017 16:00:10 -0500
Message-ID: <9c101df4-7320-556a-ca41-e024629e9a67@redhat.com>
References: <1487194670-6319-1-git-send-email-longman@redhat.com>
	<1487194670-6319-3-git-send-email-longman@redhat.com>
	<20170216164815.GD6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170216164815.GD6515@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, andrew.cooper3@citrix.com, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/16/2017 11:48 AM, Peter Zijlstra wrote:
> On Wed, Feb 15, 2017 at 04:37:50PM -0500, Waiman Long wrote:
>> +/*
>> + * Hand-optimize version for x86-64 to avoid 8 64-bit register saving and
>> + * restoring to/from the stack. It is assumed that the preempted value
>> + * is at an offset of 16 from the beginning of the kvm_steal_time structure
>> + * which is verified by the BUILD_BUG_ON() macro below.
>> + */
>> +#define PREEMPTED_OFFSET	16
> As per Andrew's suggestion, the 'right' way is something like so.

Thanks for the tip. I was not aware of the asm-offsets stuff. I will
update the patch to use it.

Cheers,
Longman
