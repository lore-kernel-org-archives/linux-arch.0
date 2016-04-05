Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:34842 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbcDEXZT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2016 19:25:19 -0400
Date: Tue, 05 Apr 2016 19:25:07 -0400 (EDT)
Message-ID: <20160405.192507.1323523820451519013.davem@davemloft.net>
Subject: Re: [PATCH 10/10] arch: fix has_transparent_hugepage()
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LSU.2.11.1604051355280.5965@eggly.anvils>
References: <alpine.LSU.2.11.1604051329480.5965@eggly.anvils>
	<alpine.LSU.2.11.1604051355280.5965@eggly.anvils>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hughd@google.com
Cc: akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, aarcange@redhat.com, andreslc@google.com, yang.shi@linaro.org, quning@gmail.com, arnd@arndb.de, ralf@linux-mips.org, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, schwidefsky@de.ibm.com, gerald.schaefer@de.ibm.com, cmetcalf@tilera.com, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20160405232507.MNur8N7Dw6xUoucZoPSZ0AHw2r0ar5jSilcYFPqQEDA@z>

From: Hugh Dickins <hughd@google.com>
Date: Tue, 5 Apr 2016 14:02:49 -0700 (PDT)

> I've just discovered that the useful-sounding has_transparent_hugepage()
> is actually an architecture-dependent minefield: on some arches it only
> builds if CONFIG_TRANSPARENT_HUGEPAGE=y, on others it's also there when
> not, but on some of those (arm and arm64) it then gives the wrong answer;
> and on mips alone it's marked __init, which would crash if called later
> (but so far it has not been called later).
> 
> Straighten this out: make it available to all configs, with a sensible
> default in asm-generic/pgtable.h, removing its definitions from those
> arches (arc, arm, arm64, sparc, tile) which are served by the default,
> adding #define has_transparent_hugepage has_transparent_hugepage to those
> (mips, powerpc, s390, x86) which need to override the default at runtime,
> and removing the __init from mips (but maybe that kind of code should be
> avoided after init: set a static variable the first time it's called).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
