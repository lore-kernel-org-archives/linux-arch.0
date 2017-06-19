From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 5/5] kbuild: thin archives make default for all archs
Date: Mon, 19 Jun 2017 15:22:14 +0900
Message-ID: <CAK7LNATfQcjTWKBWPmJG9WQOVWw984MO0ag4LaazAb82d252qw@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170609052417.561-6-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:37032 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdFSGWW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 02:22:22 -0400
In-Reply-To: <20170609052417.561-6-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Nicholas,

2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> Make thin archives build the default, but keep the config option
> to allow exemptions if any breakage can't be quickly solved.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  Documentation/process/changes.rst | 9 ++++-----
>  arch/Kconfig                      | 2 +-
>  arch/powerpc/Kconfig              | 8 --------
>  3 files changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index e25d63f8c0da..56fd0687bd4a 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -31,7 +31,7 @@ you probably needn't concern yourself with isdn4k-utils.
>  ====================== ===============  ========================================
>  GNU C                  3.2              gcc --version
>  GNU make               3.81             make --version
> -binutils               2.12             ld -v
> +binutils               2.20             ld -v
>  util-linux             2.10o            fdformat --version
>  module-init-tools      0.9.10           depmod -V
>  e2fsprogs              1.41.4           e2fsck -V
> @@ -75,10 +75,9 @@ You will need GNU make 3.81 or later to build the kernel.
>  Binutils
>  --------
>
> -Linux on IA-32 has recently switched from using ``as86`` to using ``gas`` for
> -assembling the 16-bit boot code, removing the need for ``as86`` to compile
> -your kernel.  This change does, however, mean that you need a recent
> -release of binutils.
> +The build system has recently switched to using thin archives (`ar T`) rather
> +than incremental linking (`ld -r`) for built-in.o intermediate steps. This
> +requires binutils 2.20 or newer.

Sorry for my nit-picking.

If you see this document some years later,
"recently" may not be so recent.

Currently, this part is written like that already,
but perhaps is it better to reword it a bit?



-- 
Best Regards
Masahiro Yamada
