Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 5 Nov 2005 01:19:17 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH consolidate sys_ptrace
Message-ID: <20051105001917.GA11100@lst.de>
References: <20051101051221.GA26017@lst.de> <20051101050900.GA25793@lst.de> <10611.1130845074@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10611.1130845074@warthog.cambridge.redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Nov 01, 2005 at 11:37:54AM +0000, David Howells wrote:
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
> 
> Otherwise, the patch looks valid:

As BKL usage indicates this is a real slowpath.  No one cares about one
function call or less here.
