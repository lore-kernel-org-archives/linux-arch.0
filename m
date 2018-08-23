Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34749 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeHWXJV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Aug 2018 19:09:21 -0400
MIME-Version: 1.0
References: <20180823084709.19717-1-npiggin@gmail.com> <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
In-Reply-To: <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Aug 2018 12:37:58 -0700
Message-ID: <CA+55aFwEZftzAd9k-kjiaXonP2XeTDYshjY56jmd1CFBaXmGHA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Will Deacon <will.deacon@arm.com>, Rik van Riel <riel@surriel.com>, Jann Horn <jannh@google.com>, Adin Scannell <ascannell@google.com>, Dave Hansen <dave.hansen@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180823193758.0GnQFClOrrLSeA2jddeMQHg_DtO2LgNmvQt2nt1Jx3U@z>

On Thu, Aug 23, 2018 at 12:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So right now my "tlb-fixes" branch looks like this:
> [..]
>
> I'll do a few more test builds and boots, but I think I'm going to
> merge it in this cleaned-up and re-ordered form.

In the meantime, I decided to push out that branch in case anybody
wants to look at it.

I may rebase it if I - or anybody else - find anything bad there, so
consider it non-stable, but I think it's in its final shape modulo
issues.

              Linus
