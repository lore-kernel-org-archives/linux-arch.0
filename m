Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j1S9QvFa054850
	for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2005 09:26:57 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j1S9QvEl131576
	for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2005 10:26:57 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j1S9QuZD014660
	for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2005 10:26:57 +0100
In-Reply-To: <20050225154340.6351ad34.davem@davemloft.net>
Subject: Re: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in flush_hash_one_pte())
Message-ID: <OFD7F7A9B4.F974A695-ON41256FB6.0032AFFD-41256FB6.0033EA43@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 28 Feb 2005 10:27:03 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: "David S. Miller" <davem@davemloft.net>
Cc: benh@au1.ibm.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> The only thing I could see breaking the build is that the structure
> layout of "vma" is not available at the time pgtable.h is parsed, so
> the vma->vm_mm causes a parse error.

That is indeed the cause of the compile error on s390.

> In that case, please fix this simply by turning ptep_clear_flush()
> (and thus ptep_establish) into a macro to fix the build as we have
> done on the other platforms.

Please don't. There are too many macros from hell as things are now.
I prefer to sort out the compile errors with my inline functions than
to introduce more of that macro crap.

Simply expand the pte_clear inline into ptep_get_and_clear &
ptep_clear_flush gets you around the problem with deferencing "vma"
because on s390 we don't need the mm struct in pte_clear.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
