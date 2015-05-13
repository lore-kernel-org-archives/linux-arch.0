Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59550 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbEMIVl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 04:21:41 -0400
Date: Wed, 13 May 2015 10:19:56 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 11/15] arm/futex: UP futex_atomic_op_inuser() relies
 on disabled preemption
Message-ID: <20150513081956.GB21106@linutronix.de>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1431359540-32227-12-git-send-email-dahi@linux.vnet.ibm.com>
 <20150512190014.GD25464@linutronix.de>
 <20150513093812.65fdac96@thinkpad-w530>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150513093812.65fdac96@thinkpad-w530>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, yang.shi@windriver.com, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org
Message-ID: <20150513081956.iaYdonjj_mwIq_Za1rLzo2aPNZE5fWw1ibTvhfhqXvs@z>

* David Hildenbrand | 2015-05-13 09:38:12 [+0200]:

>Thanks, I'll include it in the next version.
>
>So I assume the cleanest thing to do would be:
>
>#if __LINUX_ARM_ARCH__ < 6
>	preempt_disable();
>#endif

Correct. But also for futex_atomic_cmpxchg_inatomic() which also behind
CONFIG_SMP curtain. That is why I suggested a new patch :)

>David

Sebastian
