Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:16575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262248AbUCAF54 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 00:57:56 -0500
Date: Sun, 29 Feb 2004 21:57:52 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: SHMLBA and compat tasks
Message-Id: <20040229215752.3a6f0ce7.davem@redhat.com>
In-Reply-To: <20040229021105.GA6964@intel.com>
References: <20040228014128.GA6897@intel.com>
	<20040228155529.64bc0741.davem@redhat.com>
	<20040229021105.GA6964@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 28 Feb 2004 18:11:06 -0800
Arun Sharma <arun.sharma@intel.com> wrote:

> I read that to mean that there is a correctness problem, apart from
> performance issues on some platforms.
> 
> How about something like:
> 
> 			else
> #ifndef ARCH_HAS_VCACHE
> 			if (addr & ~PAGE_MASK)
> #endif
>  				return -EINVAL;
> 
> So that platforms with virtually indexed caches are not affected ?

By your own admittance this will break the conformance in question on
such architectures, and it's also bad to have different rules like
this in general.

Why don't we declare that SHM_LBA must be abided by on all platforms?
POSIX is not a high and mighty law which we must follow blindly, to me
this restriction is nonsensicle and supporting it fully will cause more
grief than just declaring that we don't support it.
