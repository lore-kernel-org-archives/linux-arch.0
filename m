Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45490 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbdBTT4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2017 14:56:45 -0500
Date: Mon, 20 Feb 2017 20:54:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/2] x86/kvm: Reduce vcpu_is_preempted() overhead
Message-ID: <20170220195426.GF6515@twins.programming.kicks-ass.net>
References: <1487615764-1343-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487615764-1343-1-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170220195426.lng8v5XgI0pRV-hdmTDsuy-qel0X2NmJqcn3aDk008w@z>

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
