Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:59006 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932185AbcKHLlJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2016 06:41:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mm: only enable sys_pkey* when ARCH_HAS_PKEYS
Date: Tue, 08 Nov 2016 12:39:28 +0100
Message-ID: <1596342.1rV5HksyDO@wuerfel>
In-Reply-To: <20161108093042.GC3528@osiris>
References: <1477958904-9903-1-git-send-email-mark.rutland@arm.com> <20161104234459.GA18760@remoulade> <20161108093042.GC3528@osiris>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Russell King <rmk+kernel@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org
Message-ID: <20161108113928.5iVEEo2Zi7fbCNUJ54BB7UerP5Ve4DlnhR4r55JGrgs@z>

On Tuesday, November 8, 2016 10:30:42 AM CET Heiko Carstens wrote:
> Three architectures (parisc, powerpc, s390) decided to ignore the system
> calls completely, but still have the pkey code linked into the kernel
> image.

Wouldn't it actually make sense to hook this up to the storage keys
in the s390 page tables?

	Arnd
