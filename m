Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:8935 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932066AbWGCXPo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2006 19:15:44 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Date: Tue, 4 Jul 2006 01:15:16 +0200
References: <1151670404.11575.5.camel@localhost> <200606301605.53258.ak@suse.de> <1151677236.29984.11.camel@localhost>
In-Reply-To: <1151677236.29984.11.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607040115.18194.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 30 June 2006 16:20, Martin Schwidefsky wrote:
> There are still a few more config options:
>   IPMI
>   SERIAL_NONSTANDARD
>   SCSI_SATA
> 
> and numerous menues:
>   "TPM devices" - PC_STYLE_HARDWARE
>   "Hardware monitoring support" - PC_STYLE_HARDWARE
>   "InfiniBand support" - don't think this is pc style hardware
>   "ISDN subsystem" - PC_STYLE_HARDWARE
>   "LED devices" - PC_STYLE_HARDWARE
>   "Multimedia devices" - PC_STYLE_HARDWARE
>   "MMC/SD Card support" - PC_STYLE_HARDWARE
>   "PHY device support" - PC_STYLE_HARDWARE
>   "Serial drivers" - PC_STYLE_HARDWARE
>   "SPI support" - PC_STYLE_HARDWARE
>   "Telephony Support" - PC_STYLE_HARDWARE
>   "USB support" - PC_STYLE_HARDWARE
>   "Graphics support" - PC_STYLE_HARDWARE
>   "Dallas's 1-wire bus" - PC_STYLE_HARDWARE
>   "Amateur Radio support" - PC_STYLE_HARDWARE
>   "Bluetooth subsystem support" - PC_STYLE_HARDWARE
>   "IrDA (infrared) subsystem support" - PC_STYLE_HARDWARE
>   "EDAC - error detection and reporting" - PC_STYLE_HARDWARE
>   "Sound" - PC_STYLE_HARDWARE

I would assume that all of these depend on memory mapped I/O
access. So they might be more correctly depend on CONFIG_MMIO.

>   VT
>   "Input device support" - ??
>   "Misc devices" - PC_STYLE_HARDWARE
>   "Memory Technology Devices (MTD)" - PC_STYLE_HARDWARE
>   "Wireless LAN (non-hamradio)" - PC_STYLE_HARDWARE
>   "Real Time Clock" - PC_STYLE_HARDWARE

For these, it's not so clear, so maybe just let the HW drivers
depend on CONFIG_MMIO, but not the architecture in dependant
parts.

	Arnd <><
