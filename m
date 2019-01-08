Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:37144 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfAHV3U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2019 16:29:20 -0500
MIME-Version: 1.0
References: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
 <20190108200959.1686520-1-arnd@arndb.de>
In-Reply-To: <20190108200959.1686520-1-arnd@arndb.de>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 8 Jan 2019 13:29:09 -0800
Message-ID: <CABeXuvpprn_AXF0ama9CsHyZ1yb8FuUH25MXauLzHyahxr+Vwg@mail.gmail.com>
Subject: Re: [PATCH] socket: move compat timeout handling into sock.c
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Miller <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, ccaulfie@redhat.com, Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, cluster-devel <cluster-devel@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>
Message-ID: <20190108212909.m7FtokL_tx_xMyUbFOJOMfUgG5jFdgH_f_s8UjZI-kQ@z>

On Tue, Jan 8, 2019 at 12:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This is a cleanup to prepare for the addition of 64-bit time_t
> in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
> unnecessarily complex and error-prone, moving it all into the
> main setsockopt()/getsockopt() implementation requires half
> as much code and is easier to extend.
>
> 32-bit user space can now use old_timeval32 on both 32-bit
> and 64-bit machines, while 64-bit code can use
> __old_kernel_timeval.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This will make the other series so much nicer. Thank you.

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
