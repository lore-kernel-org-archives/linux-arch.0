Return-Path: <adsharma@sc.intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:20420 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261423AbUCAUU2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Mar 2004 15:20:28 -0500
Date: Mon, 1 Mar 2004 12:16:13 -0800
From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: SHMLBA and compat tasks
Message-ID: <20040301201613.GA13349@intel.com>
References: <20040228014128.GA6897@intel.com> <20040228155529.64bc0741.davem@redhat.com> <20040229021105.GA6964@intel.com> <20040229215752.3a6f0ce7.davem@redhat.com> <20040301193308.GA13305@intel.com> <16451.37325.109790.457348@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16451.37325.109790.457348@napali.hpl.hp.com>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 01, 2004 at 11:41:01AM -0800, David Mosberger wrote:
> 
> I assume you're asking me here (too many David's!).

Virtual name cache aliasing ? :)

> The answer is that it's NOT OK to force 1MB alignment for IA-32 tasks.
> It'll eat up address space like there is no tomorrow.  In fact, the
> reason the code is there is because some versions of the open-office
> installer used to crash due to address-space exhaustion.  Probably a
> bug in open-office, but the point is that for ia32-emulation purposes,
> we want/need to be bug-for-bug compatible with x86.

Sounds like we have sufficient grounds for using different alignment
rules for different architectures ?

	-Arun
