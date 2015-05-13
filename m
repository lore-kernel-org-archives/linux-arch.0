Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:48327 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbbEMHi0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 03:38:26 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Wed, 13 May 2015 08:38:24 +0100
Date: Wed, 13 May 2015 09:38:12 +0200
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 11/15] arm/futex: UP futex_atomic_op_inuser() relies
 on disabled preemption
Message-ID: <20150513093812.65fdac96@thinkpad-w530>
In-Reply-To: <20150512190014.GD25464@linutronix.de>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1431359540-32227-12-git-send-email-dahi@linux.vnet.ibm.com>
	<20150512190014.GD25464@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org
Message-ID: <20150513073812.Aiqi3VRGQ64VbQcLMXJ7YaAvtG_ZSCBgUDDHCX76LbQ@z>

> * David Hildenbrand | 2015-05-11 17:52:16 [+0200]:
> 
> >The !CONFIG_SMP implementation of futex_atomic_op_inuser() seems to rely
> >on disabled preemption to guarantee mutual exclusion.
> 
> Yes, this is what the code looks like. It is more the requirement for
> ldrex/strex opcodes which are ARMv6+ and so is SMP support (here).
> Documentation wise you could replace CONFIG_SMP by 
>      __LINUX_ARM_ARCH__ >= 6
> in a later patch if you like. This would be more in-sync with
> arch/arm/include/asm/cmpxchg.h :)
> 
> Sebastian

Thanks, I'll include it in the next version.

So I assume the cleanest thing to do would be:

#if __LINUX_ARM_ARCH__ < 6
	preempt_disable();
#endif


David

