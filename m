Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050204215244.1d2532f7.davem@davemloft.net> 
References: <20050204215244.1d2532f7.davem@davemloft.net>  <200502050150.j151osl11380@mail.osdl.org> <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org> 
Subject: Re: [patch 19/24] TASK_SIZE is variable. 
Date: Mon, 07 Feb 2005 10:59:13 +0000
Message-ID: <24245.1107773953@redhat.com>
Sender: dhowells@redhat.com
To: "David S. Miller" <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller <davem@davemloft.net> wrote:

> > For example, replacing TASK_SIZE in fs/namei.c with "thread->addr_limit" 
> > would actually clean up the code: it would mean that the games with 
> > "get_fs()" etc would just go away, to be replaced with something like
> 
> I think that looks nice too.
> 
> Would you be against a "mm->addr_limit"?  That's what an approach
> by Paulus implemented, and I was in the camp supporting that kind
> of direction.

On the other hand, this value is constant on some archs, and in those cases,
wouldn't it be better for it to be a compile-time constant?

David
