From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: + separate-atomic_t-declaration-from-asm-atomich-into-asm-atomic_defh.patch added to -mm tree
Date: Sat, 30 Aug 2008 23:56:25 +0200
Message-ID: <200808302356.26240.zippel@linux-m68k.org>
References: <200808222056.m7MKucHA016131@imap1.linux-foundation.org> <20080822213624.GX8318@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:2663 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbYH3V5M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 30 Aug 2008 17:57:12 -0400
In-Reply-To: <20080822213624.GX8318@parisc-linux.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, ying.huang@intel.com, linux-arch@vger.kernel.org

Hi,

On Friday 22. August 2008, Matthew Wilcox wrote:

> Seems to me like all architectures could use:
>
> +++ include/linux/atomic_type.h
> +typedef struct { volatile int counter; } atomic_t;
> +#ifdef CONFIG_64BIT
> +typedef struct { volatile long counter; } atomic64_t;
> +#endif
>
> S390 has an __aligned__((4)) on theirs -- is this really necessary?
> Doesn't s390 align ints to 4 bytes automatically?  If it doesn't, it
> shouldn't be harmful to add it to other architectures

I don't think it really needs its own header either, <linux/types.h> should 
work fine too.

> (iirc m68k only 
> requires 2-byte alignment for ints ... hmm, wonder if their atomic_t is
> really atomic if, say, it cross a page boundary ...)

There is a performance penalty and the bus fault handler could treat it 
specially too.

bye, Roman
