From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all architectures
Date: Wed, 31 May 2017 23:13:01 +0200
Message-ID: <CAK8P3a2umsN_fTLbRmMofFYBzfOSdfFTqYcKdtesAdXk9Dbwvg@mail.gmail.com>
References: <20170529081103.29999-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32881 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdEaVNC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2017 17:13:02 -0400
In-Reply-To: <20170529081103.29999-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, May 29, 2017 at 10:11 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> Supporting two different intermediate-artifact packaging schemes
> was only ever intended as a temporary transition.
>
> This has so far caused no problems for powerpc, after a small fix
> for how the arch invoked ar. So now allow any arch to select the
> option, continue defaulting to N.
>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> The next step will be to have archs always select THIN_ARCHIVES
> when they are known to work. Then remove the option entirely.
>
> x86 has always just worked for me, so that should be easy.

I have build-tested many thousand randconfig kernels on arm32 with
this option enabled, and did not run into build-time regressions
besides some initial problems from a broken binutils snapshot
(all released binutils versions should be fine).

       Arnd
