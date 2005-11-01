Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051101051221.GA26017@lst.de> 
References: <20051101051221.GA26017@lst.de>  <20051101050900.GA25793@lst.de> 
Subject: Re: [PATCH consolidate sys_ptrace 
Date: Tue, 01 Nov 2005 11:37:54 +0000
Message-ID: <10611.1130845074@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Christoph Hellwig <hch@lst.de> wrote:

> > The sys_ptrace boilerplate code (everything outside the big switch
> > statement for the arch-specific requests) is shared by most
> > architectures.  This patch moves it to kernel/ptrace.c and leaves the
> > arch-specific code as arch_ptrace.

Looks okay to me. I do have a concern about all the extra indirections we're
acquiring by this mad rush to centralise everything. It's going to slow things
down and consume more stack space. Is there any way we can:

 (1) Make a sys_ptrace() *jump* to arch_ptrace() instead of calling it, thus
     obviating the extra return step.

 (2) Drop the use of lock_kernel().

Otherwise, the patch looks valid:

Acked-By: David Howells <dhowells@redhat.com>

David
