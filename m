Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 11 Aug 2005 10:20:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] consolidate sys_ptrace
Message-Id: <20050811102023.703ebb5e.sfr@canb.auug.org.au>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F041A27D7@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F041A27D7@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 10 Aug 2005 09:59:01 -0700 "Luck, Tony" <tony.luck@intel.com>
wrote:
>
> >Some architectures have a too different ptrace so we have to exclude
> >them: alpha, ia64, m32r, parisc, sparc, sparc64.  They continue to
> >keep their implementations.
> 
> So it should be no surprise that this patch works ok for ia64, but here
> is the ACK anyway.
> 
> >+#ifndef __ARCH_SYS_PTRACE
> 
> Most of the existing "#define ARCH_foo" uses don't have a prepended
> "__" (current score is 20 to 3).  So there is a small question of

As opposed to the 86 unique HAVE_ARCH_ defines ...

(like: HAVE_ARCH_COPY_AND_CSUM_FROM_USER, HAVE_ARCH_COPY_SIGINFO etc)
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
