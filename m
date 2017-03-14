Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36395 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdCNShB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2017 14:37:01 -0400
MIME-Version: 1.0
In-Reply-To: <20170313052213.11411-1-kirill.shutemov@linux.intel.com>
References: <20170313052213.11411-1-kirill.shutemov@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Mar 2017 19:36:58 +0100
Message-ID: <CAMuHMdVu-ZZz-JtuMn4eqpwBgEp3NduFkCQXQ-3GNFzu0fBcig@mail.gmail.com>
Subject: Re: [PATCH] mm, gup: fix typo in gup_p4d_range()
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>
Message-ID: <20170314183658.rbeP4shV4u-CYkiLJKwg-CG8AyEbiSXKm543sIQNmSQ@z>

Hi Kirill,

On Mon, Mar 13, 2017 at 6:22 AM, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
> gup_p4d_range() should call gup_pud_range(), not itself.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Fixes: c2febafc6773 ("mm: convert generic code to 5-level paging")

FTR, this (now commit ce70df089143c493) fixes the strange crashes I saw
with plain v4.11-rc2 and renesas-devel-20170313-v4.11-rc2 during shutdown on
Renesas R-Car Gen2 (arm) and R-Car Gen3 (arm64) (but not on older
SH/R-Mobile), and that I bisected to commit c2febafc6773.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
