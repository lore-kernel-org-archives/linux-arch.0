From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 00/18] Add support to STMicroelectronics STM32 family
Date: Wed, 25 Feb 2015 16:34:10 +0000
Message-ID: <25322.1424882050@warthog.procyon.org.uk>
References: <CALszF6CKDjp-AK4OhjA7XcXqEMNBArvaQPpkXg8E3qDXcvo4LA@mail.gmail.com> <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com> <21951.1424787288@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbbBYQeR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2015 11:34:17 -0500
In-Reply-To: <CALszF6CKDjp-AK4OhjA7XcXqEMNBArvaQPpkXg8E3qDXcvo4LA@mail.gmail.com>
Content-ID: <25321.1424882050.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: dhowells@redhat.com, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Maxime Coquelin <mcoquelin.stm32@gmail.com> wrote:

> > Is support for this in upstream binutils and gcc?  What's the preferred
> > target tuple?  I'll add support to Fedora's cross-binutils and cross-gcc
> > sets if I can.
> 
> I just rebuilt using latest upstream binutils and gcc.
> To compile Kernel and bootloader, I build a Bare Metal toolchain with
> this configuration:
> 
> --target=arm-none-eabi --with-cpu=cortex-m4 --with-fpu=fpv4-sp-d16
> --with-float=hard --with-mode=thumb

Ah, no matter.  I thought this was a new arch.  I already have 32-bit and
64-bit cross-compilers that should work.

Thanks anyway,
David
