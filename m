Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17255.15408.824123.131620@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 20:58:08 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH consolidate sys_ptrace
In-Reply-To: <20051101051221.GA26017@lst.de>
References: <20051101050900.GA25793@lst.de>
	<20051101051221.GA26017@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Christoph Hellwig writes:

> > Some architectures have a too different ptrace so we have to exclude
> > them.  They continue to keep their implementations.  For sh64 I had to
> > add a sh64_ptrace wrapper because it does some initialization on the
> > first call.  For um I removed an ifdefed SUBARCH_PTRACE_SPECIAL block,
> > but SUBARCH_PTRACE_SPECIAL isn't defined anywhere in the tree.
> 
> Umm, it might be a good idea to actually send the current patch instead
> of the old one.  I really should write this text from scratch instead
> of copying it :)
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Paul Mackerras <paulus@samba.org>
