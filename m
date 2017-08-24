Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48678 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdHXItk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2017 04:49:40 -0400
Date: Thu, 24 Aug 2017 10:49:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 3/3] sched: depend on 64BIT_ATOMIC_ACCESS to determine if
 to use min_vruntime_copy
Message-ID: <20170824084906.mtmj6rz4igo63dl5@hirez.programming.kicks-ass.net>
References: <1503553377-3646-1-git-send-email-hoeun.ryu@gmail.com>
 <1503553377-3646-4-git-send-email-hoeun.ryu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503553377-3646-4-git-send-email-hoeun.ryu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@kernel.org>, Michal Marek <mmarek@suse.com>, Laura Abbott <labbott@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, mic@digikod.net, Russell King <linux@armlinux.org.uk>, Vladimir Murzin <vladimir.murzin@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jonathan Austin <jonathan.austin@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Message-ID: <20170824084906.H6RzqjDLM8ORgJS_bd2GOQNi-lBkGaQu-BptOBgSpnU@z>

On Thu, Aug 24, 2017 at 02:42:57PM +0900, Hoeun Ryu wrote:
> +#ifndef CONFIG_64BIT_ATOMIC_ALIGNED_ACCESS
>  	u64 min_vruntime;
> -#ifndef CONFIG_64BIT
> +#else
> +	u64 min_vruntime __attribute__((aligned(sizeof(u64))));
> +#endif

That's stupid, just make sure your platform defines u64 as naturally
aligned when you have this 64BIT_ATOMIC foo.

Also, please try and dig out more 32bit archs that can use this and make
sure to include performance numbers to justify this extra cruft.
