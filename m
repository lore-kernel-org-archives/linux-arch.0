Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:38475 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbbEKPw6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2015 11:52:58 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Mon, 11 May 2015 16:52:56 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH v1 11/15] arm/futex: UP futex_atomic_op_inuser() relies on disabled preemption
Date: Mon, 11 May 2015 17:52:16 +0200
Message-ID: <1431359540-32227-12-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org, dahi@linux.vnet.ibm.com
Message-ID: <20150511155216.Kn0L3zm9k4VCTOWJOWbViK98MA0JPGnR7lJaIcumIno@z>

The !CONFIG_SMP implementation of futex_atomic_op_inuser() seems to rely
on disabled preemption to guarantee mutual exclusion.
