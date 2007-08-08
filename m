Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:50210 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbXHHK06 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Aug 2007 06:26:58 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 2/2] x86_64: ticket lock spinlock
Date: Wed, 8 Aug 2007 12:26:55 +0200
References: <20070808042234.GE11018@wotan.suse.de> <20070808042444.GF11018@wotan.suse.de>
In-Reply-To: <20070808042444.GF11018@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708081226.55651.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


>   *
>   * (the type definitions are in asm/spinlock_types.h)
>   */
>  
> +#if (NR_CPUS > 256)
> +#error spinlock supports a maximum of 256 CPUs
> +#endif
> +
>  static inline int __raw_spin_is_locked(raw_spinlock_t *lock)
>  {
> -	return *(volatile signed int *)(&(lock)->slock) <= 0;
> +	int tmp = *(volatile signed int *)(&(lock)->slock);

Why is slock not volatile signed int in the first place? 

> -	int oldval;
> +	short tmp;
> +        short oldval;

Broken white space?


-Andi
