Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 4 Feb 2005 21:52:44 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050204215244.1d2532f7.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>
References: <200502050150.j151osl11380@mail.osdl.org>
	<Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
	<Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 4 Feb 2005 19:29:17 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> For example, replacing TASK_SIZE in fs/namei.c with "thread->addr_limit" 
> would actually clean up the code: it would mean that the games with 
> "get_fs()" etc would just go away, to be replaced with something like

I think that looks nice too.

Would you be against a "mm->addr_limit"?  That's what an approach
by Paulus implemented, and I was in the camp supporting that kind
of direction.

"mm"'s exist potentially long after the "thread" part goes away.
That's why my position is that logically any "limit" on the address
space is an mm property.

And thusly, this is what that mmap() et al. stuff should be checking
not some arg'less macro called TASK_SIZE.

As an aside, while I realize the bad side effects of making
USER_PTRS_PER_PGD dynamic, it makes 32-bit process teardown
a lot faster so it's no surprise all the platforms do it.
