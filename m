Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 7 Feb 2005 11:30:00 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050207113000.79c60358.davem@davemloft.net>
In-Reply-To: <24245.1107773953@redhat.com>
References: <20050204215244.1d2532f7.davem@davemloft.net>
	<200502050150.j151osl11380@mail.osdl.org>
	<Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
	<Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>
	<24245.1107773953@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 07 Feb 2005 10:59:13 +0000
David Howells <dhowells@redhat.com> wrote:

> David S. Miller <davem@davemloft.net> wrote:
> 
> > > For example, replacing TASK_SIZE in fs/namei.c with "thread->addr_limit" 
> > > would actually clean up the code: it would mean that the games with 
> > > "get_fs()" etc would just go away, to be replaced with something like
> > 
> > I think that looks nice too.
> > 
> > Would you be against a "mm->addr_limit"?  That's what an approach
> > by Paulus implemented, and I was in the camp supporting that kind
> > of direction.
> 
> On the other hand, this value is constant on some archs, and in those cases,
> wouldn't it be better for it to be a compile-time constant?

How can it be constant?  It would need to change when a set_fs(KERNEL_DS)
is performed.
