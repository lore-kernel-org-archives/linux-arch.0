Return-Path: <adsharma@sc.intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:61652 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261746AbUCBTqo
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Mar 2004 14:46:44 -0500
Date: Tue, 2 Mar 2004 11:43:02 -0800
From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: SHMLBA and compat tasks
Message-ID: <20040302194302.GA17408@intel.com>
References: <20040228014128.GA6897@intel.com> <20040228155529.64bc0741.davem@redhat.com> <20040229021105.GA6964@intel.com> <20040229215752.3a6f0ce7.davem@redhat.com> <20040301193308.GA13305@intel.com> <16451.37325.109790.457348@napali.hpl.hp.com> <20040301201613.GA13349@intel.com> <20040301205510.GF25779@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040301205510.GF25779@parcelfarce.linux.theplanet.co.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 01, 2004 at 08:55:10PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 01, 2004 at 12:16:13PM -0800, Arun Sharma wrote:
> > Sounds like we have sufficient grounds for using different alignment
> > rules for different architectures ?
> 
> #ifndef COMPAT_SHMLBA
> #define COMPAT_SHMLBA SHMLBA
> #endif
> 
> should be enough, no?

I'm concerned that we'll have to duplicate/inline much of sys_shmat() in
ipc/compat.c and it might become a maintenance problem. Perhaps there is 
a way to do it in a better way, but I don't see it.

An ifdef in sys_shmat() that distinugishes between architectures that enforce 
SHMLBA in all cases and the ones which don't would be ideal for my purposes.

	-Arun
