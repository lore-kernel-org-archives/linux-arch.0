Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:12980 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261950AbUB1X4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 18:56:38 -0500
Date: Sat, 28 Feb 2004 15:55:29 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: SHMLBA and compat tasks
Message-Id: <20040228155529.64bc0741.davem@redhat.com>
In-Reply-To: <20040228014128.GA6897@intel.com>
References: <20040228014128.GA6897@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 27 Feb 2004 17:41:28 -0800
Arun Sharma <arun.sharma@intel.com> wrote:

> man page:
> 
> > If shmaddr isn’t NULL and SHM_RND is asserted  in  shmflg,  the  attach
> > occurs at the address equal to shmaddr rounded down to the nearest mul-
> > tiple of SHMLBA.  Otherwise shmaddr must be a page-aligned  address  at
> > which the attach occurs.

When the user specifies a specific address, things get real interesting because
of cache aliasing issues.

Platforms with virtually indexed caches use SHMLBA of a size such that
it is the largest cache virtual aliasing factor.  In this way, processes
with different SHM mappings of the shared writable memory will immediately
see writes done by other processes and aliases cannot enter the cache due
to virtual addresses being "just right".

Otherwise we'll need to special case now this SHM_RND thing and mark PTE's
as non-cacheable and other horrible things like this, and in fact this particular
scheme is not even possible on some architectures.

So your proposal is going to break things for some people, sparc64, mips, parisc,
and probably a slew of others.
