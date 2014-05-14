From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 00/25] Change time_t and clock_t to 64 bit
Date: Wed, 14 May 2014 18:13:41 +0800
Message-ID: <CAFiDJ5-No1Uw6gxSDXvsv60iyxH=dZKaVTckyZLVEWYUpR504w@mail.gmail.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
	<alpine.DEB.2.02.1405131727480.6261@ionos.tec.linutronix.de>
	<20140513174640.GA20961@infradead.org>
	<6202090.0OtAjefIFT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34311 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbaENKNm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 06:13:42 -0400
In-Reply-To: <6202090.0OtAjefIFT@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>

On Wed, May 14, 2014 at 2:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I've just spent two days looking at stuff that uses time_t inside
> of the kernel, to get a better idea of what we actually need to
> do to get provide new user interfaces for the existing architectures.
>
> My impression so far is that we're better off fixing it for the
> existing architectures first and then using the new interfaces
> exclusively on new ones, rather than changing over the ABI for
> all new architectures at this point, which would likely create
> yet another variant to maintain in the long run.
>
> Using 64-bit time_t on x32 is fine, because it's fast to operate
> in user space with 64-bit registers, and the kernel is 64-bit
> anyway. Inside of the kernel, we may get into trouble using
> a 64-bit time_t on 32-bit architectures because of the overhead
> in 64-bit math, e.g. all the timekeeping code that is based on
> timespec or some code paths in file systems and network code where
> we actually require division of time_t values.
> We clearly have to change that code in some for to deal with y2038,
> but 64-bit time_t may not be the best option. A lot of the
> in-kernel code can probably use ktime_t, which we can change
> to a different representation (e.g. 34 bit seconds) if needed,
> and all the code that is only interested in relative time
> (e.g. nanosleep) doesn't have to change at all.

Hi Arnd,

From your comment above, can I assume we don't need this patchset any more?

Regards
Ley Foon
