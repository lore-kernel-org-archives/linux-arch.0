Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35560 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAOwq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2019 10:52:46 -0400
MIME-Version: 1.0
References: <1561786601-19512-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1561786601-19512-1-git-send-email-guoren@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 1 Jul 2019 16:52:29 +0200
Message-ID: <CAK8P3a0F5-wtJHbLvEwUXE8EnALMpQb5KeX4FK3S90Ce81oN-Q@mail.gmail.com>
Subject: Re: [PATCH] csky: Improve abiv1 mem ops performance with glibc codes
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190701145229.8DIHdUKttp-hV1nHRMPGceizl79EGPKMuBLdbzX6V7I@z>

On Sat, Jun 29, 2019 at 7:36 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> These codes are copied from glibc/string directory, they are the generic
> implementation for string operations. We may further optimize them with
> assembly code in the future.
>
> In fact these code isn't tested enough for kernel, but we've tested them
> on glibc and it seems good. We just trust them :)

Are these files from the architecture independent portion of glibc or
are they csky specific? If they are architecture independent, we might
want to see if they make sense for other architectures as well, and
add them to lib/ rather than arch/csky/lib/

Should the SPDX identifier list the original LGPL-2.1 license instead
of GPL-2.0?

       Arnd
