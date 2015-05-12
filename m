Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56838 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbbELTBC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 May 2015 15:01:02 -0400
Date: Tue, 12 May 2015 21:00:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 11/15] arm/futex: UP futex_atomic_op_inuser() relies
 on disabled preemption
Message-ID: <20150512190014.GD25464@linutronix.de>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1431359540-32227-12-git-send-email-dahi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1431359540-32227-12-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org
Message-ID: <20150512190014.ADGAGvAI76VUYfZGo1nH7AtUK1266zmP6eViPBHis9Q@z>

* David Hildenbrand | 2015-05-11 17:52:16 [+0200]:

>The !CONFIG_SMP implementation of futex_atomic_op_inuser() seems to rely
>on disabled preemption to guarantee mutual exclusion.

Yes, this is what the code looks like. It is more the requirement for
ldrex/strex opcodes which are ARMv6+ and so is SMP support (here).
Documentation wise you could replace CONFIG_SMP by 
     __LINUX_ARM_ARCH__ >= 6
in a later patch if you like. This would be more in-sync with
arch/arm/include/asm/cmpxchg.h :)

Sebastian
