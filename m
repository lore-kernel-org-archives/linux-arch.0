Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753325AbdCTKXx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Mar 2017 06:23:53 -0400
Date: Mon, 20 Mar 2017 10:24:04 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/3] arm64: enable pci resource mapping using sysfs
Message-ID: <20170320102403.GC17263@arm.com>
References: <1489598266.86622.12.camel@infradead.org>
 <20170315175353.GA29452@leverpostej>
 <1489605496.4195.182.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1489605496.4195.182.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20170320102404.pSk5DalzqmGVnYX0Jycofgx9hUpgbFWfQ9jILrTiaDE@z>

On Wed, Mar 15, 2017 at 07:18:16PM +0000, David Woodhouse wrote:
> On Wed, 2017-03-15 at 17:54 +0000, Mark Rutland wrote:
> > It's not so much "broken" as "not currently supported".
> 
> Yeah, I thought that when I inherited the commit, but didn't get as far
> as rephrasing it. Will do so.
> 
> > [...]
> > 
> > > 
> > > +#define HAVE_PCI_MMAP
> > > +extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> > > +			       enum pci_mmap_state mmap_state, int write_combine);
> > > +
> > Per the prior attempt at this [1], we only want to expose the sysfs
> > interface, and not the legacy procfs interface, and need the two
> > decoupled [2].
> 
> I do not like that idea. The procfs horridness is legacy, sure, but
> it's not actually an arch-specific interface. You get to mess with
> 'legacy' syscalls all you like on a new architecture, but there could
> exist arch-agnostic code which uses the procfs interface, surely?

Just to be clear here: I'm not against exposing the proc interface if
something actually needs it, but all the requests we've had for this have
been concerned only with the sysfs API. So I'd rather start with just that,
instead of exposing both and have new software written to the proc interface,
which we certainly want to discourage.

Will
