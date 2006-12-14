Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:53414 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964865AbWLNWTU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Dec 2006 17:19:20 -0500
Date: Thu, 14 Dec 2006 14:45:26 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: + disable-init-initramfsc-updated.patch added to -mm tree
Message-ID: <20061214214526.GU21070@parisc-linux.org>
References: <200612142139.kBELdXC4028925@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612142139.kBELdXC4028925@shell0.pdx.osdl.net>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: mm-commits@vger.kernel.org, jean-paul.saman@nxp.com, linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Thu, Dec 14, 2006 at 01:39:33PM -0800, akpm@osdl.org wrote:
> diff -puN init/Makefile~disable-init-initramfsc-updated init/Makefile
> --- a/init/Makefile~disable-init-initramfsc-updated
> +++ a/init/Makefile
> @@ -2,7 +2,12 @@
>  # Makefile for the linux kernel.
>  #
>  
> -obj-y				:= main.o version.o mounts.o initramfs.o
> +obj-y                          := main.o version.o mounts.o
> +ifneq ($(CONFIG_BLK_DEV_INITRD),y)
> +obj-y                          += noinitramfs.o
> +else
> +obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
> +endif
>  obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
>  
>  mounts-y			:= do_mounts.o

I thought we tried to avoid if/else/endif constructs in Makefiles these
days, opting for a more declarative:

init-y				:= noinitramfs.o
init-$(CONFIG_BLK_DEV_INITRD)	:= initramfs.o
obj-y				:= main.o version.o mounts.o $(init-y)

