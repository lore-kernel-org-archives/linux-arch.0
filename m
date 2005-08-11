Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 11 Aug 2005 10:32:03 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050811173203.GA31610@twiddle.net>
References: <20050810080057.GA5295@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810080057.GA5295@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.

The signature of arch_ptrace needs to return long, and not int.
The PTRACE_PEEK{TEXT,DATA,USR} requests return a "word", which 
on 64-bit arches needs to be a 64-bit type.


r~
