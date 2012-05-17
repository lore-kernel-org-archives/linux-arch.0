From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 01/10] Use __kernel_long_t in struct timex
Date: Thu, 17 May 2012 15:41:54 -0700
Message-ID: <4FB57EB2.4050208@zytor.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-2-git-send-email-hjl.tools@gmail.com> <CA+55aFx98qvVg1JhMV0JjgNGb++xtir5ocseY3xgQNc3qAtWdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38063 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030488Ab2EQWmJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 18:42:09 -0400
In-Reply-To: <CA+55aFx98qvVg1JhMV0JjgNGb++xtir5ocseY3xgQNc3qAtWdQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On 05/17/2012 03:32 PM, Linus Torvalds wrote:
> 
> The whole __kernel_ prefix was a mistake, but it at least makes sense
> for certain things where it is really about some random kernel choice
> (ie __kernel_pid_t). Even there I despise it, because it's not really
> about "kernel choice", it's about just the real native type for uid_t
> - the fact that user-mode then occasionally screwed up because glibc
> has chosen crazy extended types is really not a "kernel" issue at all.
> So the naming in general is painful.
> 
> When it comes to the x32 thing I think it's *doubly* wrong, because
> this isn't even about a "kernel choice". It's damn well the native
> machine word-size. The fact that a limited user-mode ABI then limits
> "long" to 32-bit is not the kernels problem.
>
> So I'd really like to see some discussion about naming. What does this
> have to do with "kernel"? Nothing. It's the native word-size of the
> machine, for crying out loud. The fact that some user interfaces may
> limit themselves is not a "user mode vs kernel" thing.

It also puts a clear line between the kernel and user space namespaces,
which has been an ongoing problem (we *still* haven't cleaned out some
namespace pollution in the i386 <asm/signal.h> for example.)

That being said, this is a lot like the __u* and __s* types which we use
instead of <stdint.h> for similar reasons.  I don't know if
__ulong/__slong or __uword/__sword would be better here?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
