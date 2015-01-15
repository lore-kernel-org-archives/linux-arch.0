Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46890 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbbAOTjs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Jan 2015 14:39:48 -0500
Date: Thu, 15 Jan 2015 20:38:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 4/8] x86/spinlock: Leftover conversion
	ACCESS_ONCE->READ_ONCE
Message-ID: <20150115193839.GA28727@redhat.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com> <1421312314-72330-5-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421312314-72330-5-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
Message-ID: <20150115193839.rddqXA26rg7STL10czn0xa1RwgwtoeZHWEm80Ne2L0M@z>

On 01/15, Christian Borntraeger wrote:
>
> --- a/arch/x86/include/asm/spinlock.h
> +++ b/arch/x86/include/asm/spinlock.h
> @@ -186,7 +186,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
>  	__ticket_t head = ACCESS_ONCE(lock->tickets.head);
>  
>  	for (;;) {
> -		struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
> +		struct __raw_tickets tmp = READ_ONCE(lock->tickets);

Agreed, but what about another ACCESS_ONCE() above?

Oleg.

