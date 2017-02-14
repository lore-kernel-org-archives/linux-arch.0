From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2] x86/paravirt: Don't make
 vcpu_is_preempted() a callee-save function
Date: Tue, 14 Feb 2017 16:18:55 +0000
Message-ID: <5c3c2a13-b397-6e9f-8772-a8aaa3f70771@citrix.com>
References: <1486741389-8513-1-git-send-email-longman@redhat.com>
 <20170210161928.GI6515@twins.programming.kicks-ass.net>
 <1c949ed0-1b88-ae6e-4e6c-426502bfab5f@redhat.com>
 <14854496-0baa-1bf6-c819-f3d7fae13c2c@redhat.com>
 <20170213104716.GM6515@twins.programming.kicks-ass.net>
 <20170213105343.GJ6536@twins.programming.kicks-ass.net>
 <3dc50409-60dd-ad47-f971-448191e66038@redhat.com>
 <6f69b112-7ae4-bf8f-b767-29a68fd48632@redhat.com>
 <20170213215220.GN25813@worktop.programming.kicks-ass.net>
 <933ba8c6-4ebe-63e2-3c3a-2e5afef9269a@redhat.com>
 <20170214093946.GM6500@twins.programming.kicks-ass.net>
 <fc65322b-902e-6589-f64c-62be5abdb093@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <fc65322b-902e-6589-f64c-62be5abdb093@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 14/02/17 14:46, Waiman Long wrote:
> On 02/14/2017 04:39 AM, Peter Zijlstra wrote:
>> On Mon, Feb 13, 2017 at 05:34:01PM -0500, Waiman Long wrote:
>>> It is the address of &steal_time that will exceed the 32-bit limit.
>> That seems extremely unlikely. That would mean we have more than 4G
>> worth of per-cpu variables declared in the kernel.
> I have some doubt about if the compiler is able to properly use
> RIP-relative addressing for this. Anyway, it seems like constraints
> aren't allowed for asm() when not in the function context, at least for
> the the compiler that I am using (4.8.5). So it is a moot point.

You can work the issue of not having parameters in a plain asm()
statement by using an asm-offset, stringizing it, and have C put the
string fragments back together.

"cmpb $0, " STR(STEAL_TIME_preempted) "(%rax);"

~Andrew
