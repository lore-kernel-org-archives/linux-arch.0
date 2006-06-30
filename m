Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:37796 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932705AbWF3OUk
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 10:20:40 -0400
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.6/8.13.6) with ESMTP id k5UEKds8040464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 14:20:39 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5UEM39d097714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 15:22:03 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5UEKbpA001149
	for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2006 15:20:38 +0100
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200606301605.53258.ak@suse.de>
References: <1151670404.11575.5.camel@localhost>
	 <200606301509.16981.ak@suse.de> <1151674086.11575.24.camel@localhost>
	 <200606301605.53258.ak@suse.de>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 16:20:36 +0200
Message-Id: <1151677236.29984.11.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-06-30 at 16:05 +0200, Andi Kleen wrote:
> > None of them seems appropriate. The things the patch deactives for s390
> > are vastly different (ATA/IDE, Parallel port, Plug and Play, I2C, I2O
> > and so on). You will end up adding a lot of new config options. 
> 
> ATA/IDE, parallel port, PNP could be PC_STYLE_HARDWARE. 

Sounds like a plan. To have a clean patch from the start that new config
option PC_STYLE_HARDWARE needs to be added to almost all architectures.

> I2O should be definitely PCI

That is good to know, so I will add a "depends on PCI" for I2O.

> I2C is an oddball. 

So I leave "depends on !S390" for now.

There are still a few more config options:
  IPMI
  VT
  SERIAL_NONSTANDARD
  SCSI_SATA

and numerous menues:
  "TPM devices" - PC_STYLE_HARDWARE
  "EDAC - error detection and reporting" - PC_STYLE_HARDWARE
  "Hardware monitoring support" - PC_STYLE_HARDWARE
  "InfiniBand support" - don't think this is pc style hardware
  "Input device support" - ??
  "ISDN subsystem" - PC_STYLE_HARDWARE
  "LED devices" - PC_STYLE_HARDWARE
  "Multimedia devices" - PC_STYLE_HARDWARE
  "Misc devices" - PC_STYLE_HARDWARE
  "MMC/SD Card support" - PC_STYLE_HARDWARE
  "Memory Technology Devices (MTD)" - PC_STYLE_HARDWARE
  "PHY device support" - PC_STYLE_HARDWARE
  "Wireless LAN (non-hamradio)" - PC_STYLE_HARDWARE
  "Real Time Clock" - PC_STYLE_HARDWARE
  "Serial drivers" - PC_STYLE_HARDWARE
  "SPI support" - PC_STYLE_HARDWARE
  "Telephony Support" - PC_STYLE_HARDWARE
  "USB support" - PC_STYLE_HARDWARE
  "Graphics support" - PC_STYLE_HARDWARE
  "Dallas's 1-wire bus" - PC_STYLE_HARDWARE
  "Amateur Radio support" - PC_STYLE_HARDWARE
  "Bluetooth subsystem support" - PC_STYLE_HARDWARE
  "IrDA (infrared) subsystem support" - PC_STYLE_HARDWARE
  "Sound" - PC_STYLE_HARDWARE

Looks like PC_STYLE_HARDWARE is the clever idea I've been looking for.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


