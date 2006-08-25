Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:53992 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S965065AbWHYFbb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 01:31:31 -0400
Date: Fri, 25 Aug 2006 14:31:27 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Message-ID: <20060825053127.GA9066@localhost.hsdv.com>
References: <20060824234445.6B519D52@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824234445.6B519D52@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 24, 2006 at 04:44:45PM -0700, Dave Hansen wrote:
> This patch unifies all of those definitions.  It defines PAGE_SIZE in
> a single header which gets its definitions from Kconfig.  The new
> Kconfig options mirror what used to be done with #ifdefs and
> arch-specific Kconfig options.  The new Kconfig menu eliminates
> the need for parisc, ia64, and sparc64 to have their own "choice"
> menus for selecting page size.  The help text has been adapted from
> these three architectures, but is now more generic.
> 
I like the idea of asm-generic/page_size.h (though why not just use
asm-generic/page.h?) and ripping that out from the architecture headers,
though the mm/Kconfig bits look like something best left in the
architecture Kconfigs.

PAGE_SHIFT is really the only thing of interest, and that can be handled
without the CONFIG_PAGE_SIZE mess. The architectures that really care
about it can use their current hacks or just check PAGE_SHIFT.
