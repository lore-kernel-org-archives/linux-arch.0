Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EC4B1276;
	Mon,  5 Oct 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211649; cv=none; b=RKQ9G1vWC1/nrFZ4KdlMfAnGXbSWt7ERTb8o4D/WOf2jrK0ltFn/T64XM7plz6Mxue4H6VLh9iUFUQoKsFdyULXLpVCJVpVZ6Lup2Jc7Ze1uBcnKSD/en6vjxKRJi1OijjpeOBHZiJxF01ehwGq3xZybilEBs5yYDfCoaecyaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211649; c=relaxed/simple;
	bh=uMIu5Sox4TMYjmLgYpIkKpT2uwe5NQio8rVoWWq/45o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7tAIAWFl5dYYO+kb2bV6QbUSHMO6fW93cdlBvpWmRRhgypwnWRSMMt3x/xS/Y/PznV18Xb2SN9BzkN6Gcossxm6tVVixDfuZWB7pZ6CYBEYLd63QY4csp93qyXLv81wdey1WOWtCs9XAtAkmjocy72zqHNYHJT+UxSLm09NmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7KBvG7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7KBvG7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4001F00893;
	Mon,  5 Oct 2026 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791211646;
	bh=yd1SAc+Z/SeLtWDgli/OkIE3mIO8q60HpOea3gbr0Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K7KBvG7hmH2BPO9UY6c1HcDy6VC2GYcJjqnA/VxqhuIF+S+Cm79NDBl8hSDM7ZI3y
	 u+kZ09nJVS+2Ts/Qf7gPzK6Rx55W/1CN8Ojft5IU/YiWH/aKCS3Q7MrUo/vsa+84ox
	 ui8K1gez8Car+EGnXNdE8KSAxF/1ZmLICYsQwvRDIyAnpz2J9INjtLemOXIEaTBWOE
	 IFAvi0KgHQ4/WIqZLbdyL6JQdDGhNTdtBaZJdtJ7oTywFws9azkSHqu5JJGeFgPjgA
	 eC9m/b9crzrB2tkHO/6AMdrcBvKYdhAoFXEwu6IGIk3eOOhKng22ne8gE6xlT/Hdun
	 4mK06hCecKAWg==
Date: Mon, 5 Oct 2026 16:47:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: arnd@arndb.de, anna-maria@linutronix.de, mingo@kernel.org,
	tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/2] rwonce: Add READ_ONCE_THIS_CPU() and
 WRITE_ONCE_THIS_CPU()
Message-ID: <asO4ey3X6JK0IzlY@localhost.localdomain>
References: <20261002151757.3605081-1-kunwu.chan@gmail.com>
 <20261002151757.3605081-2-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002151757.3605081-2-kunwu.chan@gmail.com>

Le Fri, Oct 02, 2026 at 11:17:55PM +0800, Kunwu Chan a écrit :
> Per-CPU variables are sometimes accessed from different execution
> contexts on the same CPU, typically task context and an interrupt or
> NMI handler.
> 
> A plain READ_ONCE() or WRITE_ONCE() marks such an access as an
> intentional race but does not express where the racing accesses are
> expected to come from. This distinction allows concurrency tools such
> as KCSAN to tell an intentional same-CPU context race apart from an
> access that may race across CPUs.
> 
> Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() to identify accesses
> to a per-CPU variable which are intended to race only with accesses
> from other execution contexts on the same CPU. For now, they are
> simple wrappers around READ_ONCE() and WRITE_ONCE(), so generated code
> and tool behaviour are unchanged.

But there is a plan to handle that with KSCAN, right?

If so:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.


> 
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  include/asm-generic/rwonce.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index 52b969c7cef9..4d4e009a4489 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -61,6 +61,17 @@ do {									\
>  	__WRITE_ONCE(x, val);						\
>  } while (0)
>  
> +/*
> + * {READ,WRITE}_ONCE_THIS_CPU() identify accesses to a per-CPU variable
> + * which are intended to race only with accesses from other execution
> + * contexts on the same CPU, e.g. task and interrupt context.
> + *
> + * For now, these are simple wrappers around READ_ONCE() and
> + * WRITE_ONCE().
> + */
> +#define READ_ONCE_THIS_CPU(x)		READ_ONCE(x)
> +#define WRITE_ONCE_THIS_CPU(x, val)	WRITE_ONCE(x, val)
> +
>  static __no_sanitize_or_inline
>  unsigned long __read_once_word_nocheck(const void *addr)
>  {
> -- 
> 2.43.0
> 

-- 
Frederic Weisbecker
SUSE Labs
