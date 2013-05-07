From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Build errors caused by modalias generation patch
Date: Tue, 07 May 2013 18:40:54 +0200
Message-ID: <874neeu4ix.fsf@hase.home>
References: <20130506160253.GA27181@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:43447 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758941Ab3EGQk7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 May 2013 12:40:59 -0400
In-Reply-To: <20130506160253.GA27181@linux-mips.org> (Ralf Baechle's message
	of "Mon, 6 May 2013 18:02:54 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org

Ralf Baechle <ralf@linux-mips.org> writes:

> cobalt_defconfig:
>
>   CC [M]  drivers/hid/usbhid/hid-quirks.o
>   LD [M]  drivers/hid/usbhid/usbhid.o
> FATAL: drivers/hid/usbhid/usbhid: sizeof(struct usb_device_id)=32 is not a modulo of the size of section __mod_usb_device_table=48.
> Fix definition of struct usb_device_id in mod_devicetable.h

What are the contents of devicetable-offsets.[sh]?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
