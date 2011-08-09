From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 04/24] C6X: build infrastructure
Date: Tue, 09 Aug 2011 11:56:58 -0400
Message-ID: <1312905419.2356.8.camel@deneb.redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
	 <1312839879-13592-5-git-send-email-msalter@redhat.com>
	 <201108091721.29977.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1033 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829Ab1HIP5D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Aug 2011 11:57:03 -0400
In-Reply-To: <201108091721.29977.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Tue, 2011-08-09 at 17:21 +0200, Arnd Bergmann wrote:
> On Monday 08 August 2011, Mark Salter wrote:
> > +
> > +config NR_IRQS
> > +       int "Number of virtual interrupt numbers"
> > +       range 32 32768
> > +       default "256"
> > +       help
> > +         This defines the number of virtual interrupt numbers the kernel
> > +         can manage. Virtual interrupt numbers are what you see in
> > +         /proc/interrupts. If you configure your system to have too few,
> > +         drivers will fail to load or worse - handle with care.
> >
> 
> Does this need to be configurable?

No, not really.

> 
> > +
> > +menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
> > +
> > +config PCI
> > +       bool "PCI support"
> > +       help
> > +         Support for PCI bus.
> > +endmenu
> > +
> 
> Do you actually support PCI?

Not for now.

--Mark
