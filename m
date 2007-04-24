Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:46252 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883AbXDXGBJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Apr 2007 02:01:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17965.36284.754539.23879@cargo.ozlabs.ibm.com>
Date: Tue, 24 Apr 2007 14:55:24 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix Kconfig for usb/input
In-Reply-To: <46224BCD.3010106@gmail.com>
References: <46224BCD.3010106@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: "Jory A. Pratt" <geekypenguin@gmail.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Jory A. Pratt writes:

>  config USB_HIDINPUT_POWERBOOK
>  	bool "Enable support for iBook/PowerBook special keys"
>  	default n
> -	depends on USB_HID
> +	depends on USB_HID && PPC32
>  	help
>  	  Say Y here if you want support for the special keys (Fn, Numlock) on
>  	  Apple iBooks and PowerBooks.
> @@ -339,7 +339,7 @@ config USB_KEYSPAN_REMOTE
>  
>  config USB_APPLETOUCH
>  	tristate "Apple USB Touchpad support"
> -	depends on USB && INPUT
> +	depends on USB && INPUT && PPC32
>  	---help---
>  	  Say Y here if you want to use an Apple USB Touchpad.

Are these options needed on intel-based MacBooks these days?

Paul.


