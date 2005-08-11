Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 11 Aug 2005 19:33:05 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050811173305.GA10372@lst.de>
References: <20050810080057.GA5295@lst.de> <20050811173203.GA31610@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811173203.GA31610@twiddle.net>
To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 11, 2005 at 10:32:03AM -0700, Richard Henderson wrote:
> On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> > The sys_ptrace boilerplate code (everything outside the big switch
> > statement for the arch-specific requests) is shared by most
> > architectures.  This patch moves it to kernel/ptrace.c and leaves the
> > arch-specific code as arch_ptrace.
> 
> The signature of arch_ptrace needs to return long, and not int.
> The PTRACE_PEEK{TEXT,DATA,USR} requests return a "word", which 
> on 64-bit arches needs to be a 64-bit type.

Ok.  Will be that way in the next patch.
