Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 2 Nov 2005 15:31:43 +1100
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH consolidate sys_ptrace
Message-Id: <20051102153143.5005a87b.akpm@osdl.org>
In-Reply-To: <10611.1130845074@warthog.cambridge.redhat.com>
References: <20051101051221.GA26017@lst.de>
	<20051101050900.GA25793@lst.de>
	<10611.1130845074@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells <dhowells@redhat.com> wrote:
>
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > The sys_ptrace boilerplate code (everything outside the big switch
> > > statement for the arch-specific requests) is shared by most
> > > architectures.  This patch moves it to kernel/ptrace.c and leaves the
> > > arch-specific code as arch_ptrace.
> 
> Looks okay to me. I do have a concern about all the extra indirections we're
> acquiring by this mad rush to centralise everything. It's going to slow things
> down and consume more stack space. Is there any way we can:
> 
>  (1) Make a sys_ptrace() *jump* to arch_ptrace() instead of calling it, thus
>      obviating the extra return step.
> 
>  (2) Drop the use of lock_kernel().

If we can remove the lock_kernel() and move the final put_task_struct()
into each arch_ptrace() then we can end sys_ptrace() with

	return arch_ptrace(....);

and with luck, gcc will convert it into a tailcall for us.

It's probably not the first place to start doing such optimisation tho.
