From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/2] locking/mutex,rwsem: Reduce vcpu_is_preempted()
	calling frequency
Date: Wed, 8 Feb 2017 14:09:26 -0500
Message-ID: <f82bd691-073c-ced1-a1f3-f3cc5b2d9c96@redhat.com>
References: <1486576825-17058-1-git-send-email-longman@redhat.com>
	<1486576825-17058-2-git-send-email-longman@redhat.com>
	<20170208190533.GB6515@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170208190533.GB6515@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/08/2017 02:05 PM, Peter Zijlstra wrote:
> On Wed, Feb 08, 2017 at 01:00:25PM -0500, Waiman Long wrote:
>> As the vcpu_is_preempted() call is pretty costly compared with other
>> checks within mutex_spin_on_owner() and rwsem_spin_on_owner(), they
>> are done at a reduce frequency of once every 256 iterations.
> That's just disgusting.

I do have some doubt myself on the effectiveness of this patch. Anyway,
it is the first patch that I think is more beneficial.

Cheers,
Longman
