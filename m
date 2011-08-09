From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/24] C6X: build infrastructure
Date: Tue, 9 Aug 2011 17:21:29 +0200
Message-ID: <201108091721.29977.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-5-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51725 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1HIPVe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 11:21:34 -0400
In-Reply-To: <1312839879-13592-5-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:
> +
> +config NR_IRQS
> +       int "Number of virtual interrupt numbers"
> +       range 32 32768
> +       default "256"
> +       help
> +         This defines the number of virtual interrupt numbers the kernel
> +         can manage. Virtual interrupt numbers are what you see in
> +         /proc/interrupts. If you configure your system to have too few,
> +         drivers will fail to load or worse - handle with care.
>

Does this need to be configurable? I think you can simply hardcode it to 
a reasonably high number, because with sparse IRQs the cost is relatively
low.

> +
> +menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
> +
> +config PCI
> +       bool "PCI support"
> +       help
> +         Support for PCI bus.
> +endmenu
> +

Do you actually support PCI? I don't see any of the required code for that
and you can save a lot of trouble by not allowing PCI at all.

	Arnd
