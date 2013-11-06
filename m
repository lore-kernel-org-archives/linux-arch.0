From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: create a separate slab for page->ptl allocation
Date: Wed, 6 Nov 2013 12:02:00 +0100
Message-ID: <20131106110200.GI10651@twins.programming.kicks-ass.net>
References: <1382442839-7458-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20131105150145.734a5dd5b5d455800ebfa0d3@linux-foundation.org>
 <20131105224217.GC20167@shutemov.name>
 <20131105155619.021f32eba1ca8f15a73ed4c9@linux-foundation.org>
 <20131105231310.GE20167@shutemov.name>
 <20131106103403.GB21074@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51914 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab3KFLCQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2013 06:02:16 -0500
Content-Disposition: inline
In-Reply-To: <20131106103403.GB21074@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wed, Nov 06, 2013 at 10:34:03AM +0000, Will Deacon wrote:
> FWIW: if the architecture selects ARCH_USE_CMPXCHG_LOCKREF, then a spinlock_t
> is 32-bit (assuming that unsigned int is also 32-bit).

Egads, talk about fragile. That thing relies on someone actually keeping
lib/Kconfig up-to-date.
