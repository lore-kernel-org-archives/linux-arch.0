Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:5300 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261949AbUB1X43 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 18:56:29 -0500
Date: Sat, 28 Feb 2004 15:56:26 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: compat tasks and O_LARGEFILE
Message-Id: <20040228155626.4e45aaa6.davem@redhat.com>
In-Reply-To: <20040228015709.GB6897@intel.com>
References: <20040228015709.GB6897@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 27 Feb 2004 17:57:09 -0800
Arun Sharma <arun.sharma@intel.com> wrote:

> This code sequence in linux/fs/open.c:
 ...
> > #if BITS_PER_LONG != 32
> > 	flags |= O_LARGEFILE;
> > #endif
> 
> is problematic for compat tasks. For eg: negative seeks can result in 
> ~4GB files getting created.
> 
> Are there any objections to letting a task reset this flag using a fcntl?
> There are some corner cases, such as what if the file pointer is already
> beyond 4GB etc, but I think they're solvable.

See arch/sparc64/kernel/sys_sparc32.c:sparc32_open(), old and known issue.
That piece of code belongs in fs/compat.c so that it isn't duplicated all
over.
