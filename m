From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove()
 notrace/NOKPROBE
Date: Wed, 19 Feb 2020 10:36:14 -0500
Message-ID: <20200219103614.2299ff61@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.604459293@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSPgS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:36:18 -0500
In-Reply-To: <20200219150744.604459293@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, 19 Feb 2020 15:47:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/arch/x86/lib/memcpy_32.c
> +++ b/arch/x86/lib/memcpy_32.c
> @@ -21,7 +21,7 @@ __visible void *memset(void *s, int c, s
>  }
>  EXPORT_SYMBOL(memset);
>  
> -__visible void *memmove(void *dest, const void *src, size_t n)
> +__visible notrace void *memmove(void *dest, const void *src, size_t n)
>  {
>  	int d0,d1,d2,d3,d4,d5;
>  	char *ret = dest;
> @@ -207,3 +207,8 @@ __visible void *memmove(void *dest, cons
>  
>  }
>  EXPORT_SYMBOL(memmove);

Hmm, for things like this, which is adding notrace because of a single
instance of it (although it is fine to trace in any other instance), it
would be nice to have a gcc helper that could call "memmove+5" which
would skip the tracing portion.

-- Steve
