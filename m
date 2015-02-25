Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38193 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbbBYLu2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2015 06:50:28 -0500
MIME-Version: 1.0
In-Reply-To: <21951.1424787288@warthog.procyon.org.uk>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<21951.1424787288@warthog.procyon.org.uk>
Date: Wed, 25 Feb 2015 12:50:25 +0100
Message-ID: <CALszF6CKDjp-AK4OhjA7XcXqEMNBArvaQPpkXg8E3qDXcvo4LA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Add support to STMicroelectronics STM32 family
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150225115025.iK2VkvOmXhthR6vuGco_ZW5gX4XuTvGfrMBbyS6hxRo@z>

Hello David,

2015-02-24 15:14 GMT+01:00 David Howells <dhowells@redhat.com>:
> Is support for this in upstream binutils and gcc?  What's the preferred target
> tuple?  I'll add support to Fedora's cross-binutils and cross-gcc sets if I
> can.

I just rebuilt using latest upstream binutils and gcc.
To compile Kernel and bootloader, I build a Bare Metal toolchain with
this configuration:

--target=arm-none-eabi --with-cpu=cortex-m4 --with-fpu=fpv4-sp-d16
--with-float=hard --with-mode=thumb

BR,
Maxime
>
> David
