Return-Path: <adsharma@sc.intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:59840 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261971AbUB2Cl1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 21:41:27 -0500
Date: Sat, 28 Feb 2004 18:38:02 -0800
From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: compat tasks and O_LARGEFILE
Message-ID: <20040229023802.GB6964@intel.com>
References: <20040228015709.GB6897@intel.com> <20040228155626.4e45aaa6.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228155626.4e45aaa6.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Feb 28, 2004 at 03:56:26PM -0800, David S. Miller wrote:
> 
> See arch/sparc64/kernel/sys_sparc32.c:sparc32_open(), old and known issue.
> That piece of code belongs in fs/compat.c so that it isn't duplicated all
> over.

This approach doesn't work for completely user level 32 bit emulation.
One example is IA-32 EL:

http://www.intel.com/pressroom/archive/releases/20040113comp.htm
[ The Linux version is in the pipeline ]

There's also something in POSIX that requires user level access to
such bits via a fcntl. I don't have the spec handy right now...

	-Arun
