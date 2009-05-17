From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 34/35] powerpc use generic ptemap.h
Date: Sun, 17 May 2009 13:55:00 +1000
Message-ID: <1242532500.9691.10.camel@pasglop>
References: <20090501144201.D31EF417@kernel>
	 <20090501144254.52127677@kernel>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33299 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbZEQDzF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 16 May 2009 23:55:05 -0400
In-Reply-To: <20090501144254.52127677@kernel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Kumar Gala <galak@gate.crashing.org>

On Fri, 2009-05-01 at 07:42 -0700, Dave Hansen wrote:
> powerpc is a bid of an oddball here.  It seems to have CONFIG_HIGHPTE
> behavior at all times when compiled as 32-bit.  There's even an
> #ifdef CONFIG_HIGHPTE in arch/powerpc/mm/pgtable_32.c, but there's no
> trace of HIGHPTE in Kconfig anywhere.
> 
> This gives ppc32 an explicit HIGHPTE in Kconfig so that we can use
> the #ifdef in asm-generic/ptemap.h and let ppc use the generic code
> with x86 and frv.

With a bit of lag as I was away...

> +config HIGHPTE
> +	def_bool y
> +	depends on HIGHMEM
> +

Make this a selectable option and mark it EXPERIMENTAL or something. I
wouldn't be surprised if some of our stuff bitrotted. Also I very much
doubt BookE 32-bit will cope with HIGHPTE since the TLB miss code runs
in virtual mode with only the linear mapping guaranteed to be available
and it's not re-entrant.

So at the very least, make it depends on 6xx and also mark it
EXPERIMENTAL.

Also, iirc (I'll have to dbl check), our recent changes to enable
freeing of PTE pages using RCU may have broken HIGHPTE due to abuse of
page_address() on PTE pages. Nothing unfixable but another reason not to
unconditionally enable it.

Cheers,
Ben.
