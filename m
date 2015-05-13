Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:57141 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368AbbEMI4F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 04:56:05 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Wed, 13 May 2015 09:56:03 +0100
Date: Wed, 13 May 2015 10:55:56 +0200
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 11/15] arm/futex: UP futex_atomic_op_inuser() relies
 on disabled preemption
Message-ID: <20150513105556.2607d99c@thinkpad-w530>
In-Reply-To: <20150513081956.GB21106@linutronix.de>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1431359540-32227-12-git-send-email-dahi@linux.vnet.ibm.com>
	<20150512190014.GD25464@linutronix.de>
	<20150513093812.65fdac96@thinkpad-w530>
	<20150513081956.GB21106@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org
Message-ID: <20150513085556.JbJVYWxY_rxGK4wxBI4VMpL_qsgHUtOfkYVJAM52hqY@z>

> * David Hildenbrand | 2015-05-13 09:38:12 [+0200]:
> 
> >Thanks, I'll include it in the next version.
> >
> >So I assume the cleanest thing to do would be:
> >
> >#if __LINUX_ARM_ARCH__ < 6
> >	preempt_disable();
> >#endif
> 
> Correct. But also for futex_atomic_cmpxchg_inatomic() which also behind
> CONFIG_SMP curtain. That is why I suggested a new patch :)
> 
> >David
> 
> Sebastian

Ah, okay I think now I got it :)

So both patches are fine for now, but we should replace CONFIG_SMP
by __LINUX_ARM_ARCH__ >=6 in both file, not only in the code I touch (to make
it map arch/arm/include/asm/cmpxchg.h style).

David

