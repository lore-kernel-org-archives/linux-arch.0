Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41612 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbcKHKl1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2016 05:41:27 -0500
Date: Tue, 8 Nov 2016 10:41:12 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] mm: only enable sys_pkey* when ARCH_HAS_PKEYS
Message-ID: <20161108104112.GM1041@n2100.armlinux.org.uk>
References: <1477958904-9903-1-git-send-email-mark.rutland@arm.com>
 <c716d515-409f-4092-73d2-1a81db6c1ba3@linux.intel.com>
 <20161104234459.GA18760@remoulade>
 <20161108093042.GC3528@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108093042.GC3528@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Thomas Gleixner <tglx@linutronix.de>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org
Message-ID: <20161108104112.qZ3GaGEOJ2-QEs_6Go2XXTU_LK-zeiTra0eJlElGrN4@z>

On Tue, Nov 08, 2016 at 10:30:42AM +0100, Heiko Carstens wrote:
> Two architectures (arm, mips) have wired them up and thus allocated system
> call numbers, even though they don't have ARCH_HAS_PKEYS set. Which seems a
> bit pointless.

I don't think it's pointless at all.  First, read the LWN article for
the userspace side of the interface: https://lwn.net/Articles/689395/
