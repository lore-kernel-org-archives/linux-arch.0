Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50399 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbcFKJtp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jun 2016 05:49:45 -0400
Date: Sat, 11 Jun 2016 11:47:44 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/9] mm: implement new pkey_mprotect() system call
In-Reply-To: <20160609000120.A3DD5140@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.11.1606111147000.5839@nanos>
References: <20160609000117.71AC7623@viggo.jf.intel.com> <20160609000120.A3DD5140@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com
Message-ID: <20160611094744.nQW-l2a_E7OCt3El-K6O1zXc6r_wdJc7Umyx1xNAwSg@z>

On Wed, 8 Jun 2016, Dave Hansen wrote:
> Proposed semantics:
> 1. protection key 0 is special and represents the default,
>    unassigned protection key.  It is always allocated.
> 2. mprotect() never affects a mapping's pkey_mprotect()-assigned
>    protection key. A protection key of 0 (even if set explicitly)
>    represents an unassigned protection key.
>    2a. mprotect(PROT_EXEC) on a mapping with an assigned protection
>        key may or may not result in a mapping with execute-only
>        properties.  pkey_mprotect() plus pkey_set() on all threads
>        should be used to _guarantee_ execute-only semantics.
> 3. mprotect(PROT_EXEC) may result in an "execute-only" mapping. The
>    kernel will internally attempt to allocate and dedicate a
>    protection key for the purpose of execute-only mappings.  This
>    may not be possible in cases where there are no free protection
>    keys available.

Shouldn't we just reserve a protection key for PROT_EXEC unconditionally?

Thanks,

	tglx
