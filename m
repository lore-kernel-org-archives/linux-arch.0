Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 11 Aug 2005 12:44:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] consolidate sys_ptrace
In-Reply-To: <20050810080057.GA5295@lst.de>
Message-ID: <Pine.LNX.4.61.0508111226530.3743@scrub.home>
References: <20050810080057.GA5295@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
List-ID: <linux-arch.vger.kernel.org>

Hi,

On Wed, 10 Aug 2005, Christoph Hellwig wrote:

> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.

No objection really, but I recently reformatted the m68k sys_ptrace() so 
it would be easier to regenerate your changes on top of this. I can do 
this for you if we can agree on to merge at least the m68k ptrace changes 
before this.
For reference I put the patches at www.xs4all.nl/~zippel/m68k_merge/
(tf, p_ws, p_c are the relevant patches).

Al, this also includes the updated thread_info patches, I fixed some of 
m68k specific parts. Could you please expand a little on the objections 
you made on IRC?

bye, Roman
