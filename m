From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 00/18] Add support to STMicroelectronics STM32 family
Date: Wed, 25 Feb 2015 12:50:25 +0100
Message-ID: <CALszF6CKDjp-AK4OhjA7XcXqEMNBArvaQPpkXg8E3qDXcvo4LA@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<21951.1424787288@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21951.1424787288@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
