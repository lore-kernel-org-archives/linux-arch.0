Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54056 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdBHU4L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2017 15:56:11 -0500
Date: Wed, 8 Feb 2017 20:05:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] locking/mutex,rwsem: Reduce vcpu_is_preempted()
 calling frequency
Message-ID: <20170208190533.GB6515@twins.programming.kicks-ass.net>
References: <1486576825-17058-1-git-send-email-longman@redhat.com>
 <1486576825-17058-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486576825-17058-2-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170208190533.ZOK8PACysi7DhrzQUtsRjpF7dvPpcQLyDn1PVi2ad-Y@z>

On Wed, Feb 08, 2017 at 01:00:25PM -0500, Waiman Long wrote:
> As the vcpu_is_preempted() call is pretty costly compared with other
> checks within mutex_spin_on_owner() and rwsem_spin_on_owner(), they
> are done at a reduce frequency of once every 256 iterations.

That's just disgusting.
