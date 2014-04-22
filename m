From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/28] nios2 Linux kernel port
Date: Tue, 22 Apr 2014 12:56:08 +0200
Message-ID: <16597012.pEkDc99HDN@wuerfel>
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <5354AD36.5090809@zytor.com> <CAFiDJ5861HE4AXtio-8uNJppWE2oaPt9_OKyGV=Myb_3vPrOVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:53916 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbaDVK6I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 06:58:08 -0400
In-Reply-To: <CAFiDJ5861HE4AXtio-8uNJppWE2oaPt9_OKyGV=Myb_3vPrOVA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com

On Tuesday 22 April 2014 18:37:11 Ley Foon Tan wrote:
> Hi Arnd and Peter Anvin,
> 
> Other than 64-bit time_t, clock_t and suseconds_t, can you confirm
> that we don't need to have 64 bit off_t? See detail in link below.
> I can submit the patches for 64-bit time changes
> (include/asm-generic/posix_types.h and other archs) if everyone is
> agreed on this.

Yes.

> Excerpt from https://lkml.org/lkml/2012/11/14/358 :
> "Obviously, we want to use 64-bit off_t, but this is achieved already
> through loff_t, which is used in all places in the asm-generic
> ABI anyway (the syscalls using off_t are stripped out). I don't
> think we want to have the other ones set to 64 bit on ARC or Meta,
> although I'm not 100% sure about ino_t and nlink_t. "

This is all still true. You should have no syscall using 'off_t',
only loff_t.

I still don't know whether we would want 32 or 64 bit ino_t and nlink_t
for new architectures. It seems it would gain very little, but have
a noticeable overhead.

	Arnd
