Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:43149 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1030188AbWIEQud (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 12:50:33 -0400
Date: Tue, 5 Sep 2006 10:50:32 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch 1/5] Kconfig: refine some depend statements.
Message-ID: <20060905165032.GI2558@parisc-linux.org>
References: <20060905163305.GB6510@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905163305.GB6510@skybase>
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 05, 2006 at 06:33:05PM +0200, Martin Schwidefsky wrote:
>  config DTLK
>  	tristate "Double Talk PC internal speech card support"
> +	depends on ISA

Yup, only available as an ISA card

>  menu "Ftape, the floppy tape device driver"
> +	depends on BROKEN_ON_SMP && (ALPHA || X86)

I vaguely remember this being the right answer last time this subject
came up ...

>  config TELCLOCK
>  	tristate "Telecom clock driver for MPBL0010 ATCA SBC"
>  	depends on EXPERIMENTAL
> +	depends on X86
>  	default n
>  	help
>  	  The telecom clock device is specific to the MPBL0010 ATCA computer and

	depends on EXPERIMENTAL && X86
perhaps?  Also the "default n" can go -- n is the default default anyway ;-)

>  menu "IEEE 1394 (FireWire) support"
> +	depends on PCI || BROKEN

Why the || BROKEN?

>  menu "Fusion MPT device support"
> +	depends on PCI

Makes sense.  Might want to submit that one to linux-scsi, cc'ing Eric
Moore, since the driver is actively maintained.

>  menu "I2O device support"
> +	depends on PCI

I suspect we'll never see I2O on anything other than PCI, so makes sense.
