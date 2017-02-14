Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbdBNJlG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2017 04:41:06 -0500
Date: Tue, 14 Feb 2017 10:39:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] x86/paravirt: Don't make vcpu_is_preempted() a
 callee-save function
Message-ID: <20170214093946.GM6500@twins.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933ba8c6-4ebe-63e2-3c3a-2e5afef9269a@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170214093946.QfS4cFKehlFPROfI6-_yvtJb4dfMkC-aHBlLJAob8r8@z>

On Mon, Feb 13, 2017 at 05:34:01PM -0500, Waiman Long wrote:
> It is the address of &steal_time that will exceed the 32-bit limit.

That seems extremely unlikely. That would mean we have more than 4G
worth of per-cpu variables declared in the kernel.
