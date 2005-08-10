Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 10 Aug 2005 10:08:37 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050810170837.GA25403@twiddle.net>
References: <20050810080057.GA5295@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810080057.GA5295@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> Some architectures have a too different ptrace so we have to exclude
> them: alpha...

Alpha could be updated to use this, I think.  Just a matter of
using force_successful_syscall_return instead of pt_regs directly.

I'll have a look at testing this.


r~
