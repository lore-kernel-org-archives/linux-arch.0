Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56685 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933903AbaCTWbQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Mar 2014 18:31:16 -0400
Message-ID: <532B6BC8.8010502@zytor.com>
Date: Thu, 20 Mar 2014 15:29:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v7 06/11] pvqspinlock, x86: Allow unfair queue spinlock
 in a KVM guest
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com> <1395260049-30839-7-git-send-email-Waiman.Long@hp.com> <532B6543.7050707@redhat.com>
In-Reply-To: <532B6543.7050707@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Scott J Norton <scott.norton@hp.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20140320222928.9I4jBARUrySajwplU_33mAd09J454DdL7wWadTEDm30@z>

On 03/20/2014 03:01 PM, Paolo Bonzini wrote:
> 
> No!  Please do what I asked you to do.  You are not handling Hyper-V or
> VMWare.  Just use X86_FEATURE_HYPERVISOR and it will cover all
> hypervisors that actually follow Intel's guidelines.
> 

And for those that don't, we should turn on X86_FEATURE_HYPERVISOR in
the Linux enumeration code as we do for other features we detect
independently.

	-hpa


