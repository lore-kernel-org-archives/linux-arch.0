Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j5LNdm6s007107
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 19:39:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j5LNdmKK261684
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 19:39:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j5LNdlNo031364
	for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2005 19:39:48 -0400
Subject: Re: sparsemem patches in -mm
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20050621130150.62fbd353.akpm@osdl.org>
References: <20050621021352.46fc3b81.akpm@osdl.org>
	 <20050621141755.GX11655@parcelfarce.linux.theplanet.co.uk>
	 <42B83771.1050304@shadowen.org>  <20050621130150.62fbd353.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 16:39:36 -0700
Message-Id: <1119397176.18457.39.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, matthew@wil.cx, linux-arch@vger.kernel.org, Matthew E Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2005-06-21 at 13:01 -0700, Andrew Morton wrote: 
> The patches I have there seem fairly logical, although there's a lot of
> Kconfig futzing going on.  Do you spy any patches which should be collapsed
> together there?  If so, which?

I've broken the mm/Kconfig ones up into four parts, each using the title
of the first one in the set that was combined.  There was a bit of
unnecessary context that required rediffing.  

The resultant four patches can be found here:
http://sr71.net/~dave/sparsemem/all-condensed/

I'd be happy to post these to LKML or linux-arch if anyone wants to see
them in normal emailed patch form.

order:
create-mm-kconfig-for-arch-independent-memory-options.patch
make-each-arch-use-mm-kconfig.patch
update-all-defconfigs-for-arch_discontigmem_enable.patch
introduce-new-kconfig-option-for-numa-or-discontig.patch

Applied, they produce the exact same output as the source nine patches
from 2.6.12-mm1:
> create-mm-kconfig-for-arch-independent-memory-options.patch
> make-each-arch-use-mm-kconfig.patch
> make-each-arch-use-mm-kconfig-fix.patch
> update-all-defconfigs-for-arch_discontigmem_enable.patch
> introduce-new-kconfig-option-for-numa-or-discontig.patch
> sparsemem-fix-minor-defaults-issue-in-mm-kconfig.patch
> mm-kconfig-kill-unused-arch_flatmem_disable.patch
> mm-kconfig-hide-memory-model-selection-menu.patch
> mm-kconfig-give-discontig-more-help-text.patch

Into this order, in these groups:

create-mm-kconfig-for-arch-independent-memory-options.patch
sparsemem-fix-minor-defaults-issue-in-mm-kconfig.patch
mm-kconfig-hide-memory-model-selection-menu.patch
mm-kconfig-give-discontig-more-help-text.patch
#
make-each-arch-use-mm-kconfig.patch
mm-kconfig-kill-unused-arch_flatmem_disable.patch
make-each-arch-use-mm-kconfig-fix.patch
# 
update-all-defconfigs-for-arch_discontigmem_enable.patch
#
introduce-new-kconfig-option-for-numa-or-discontig.patch


-- Dave
