Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050810080057.GA5295@lst.de> 
References: <20050810080057.GA5295@lst.de> 
Subject: Re: [PATCH] consolidate sys_ptrace 
Date: Wed, 10 Aug 2005 10:36:31 +0100
Message-ID: <25167.1123666591@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Christoph Hellwig <hch@lst.de> wrote:

> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.

Looks okay for FRV.

My biggest concern with doing things like this is that it eats away at the
kernel stack space available for a syscall, though I don't think it'll be too
much of a problem in this case.

Is there also a way to get rid of the lock_kernel() call?

David
