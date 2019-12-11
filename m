Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKT06 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 14:26:58 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mt7Ll-1hqKMr2ziz-00tQbm for <linux-arch@vger.kernel.org>; Wed, 11 Dec
 2019 20:26:56 +0100
Received: by mail-qk1-f171.google.com with SMTP id r14so12513622qke.13
        for <linux-arch@vger.kernel.org>; Wed, 11 Dec 2019 11:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com> <20191211184027.20130-2-catalin.marinas@arm.com>
In-Reply-To: <20191211184027.20130-2-catalin.marinas@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Dec 2019 20:26:39 +0100
Message-ID: <CAK8P3a0OxNWPjekT_m55reuopHJeWZs6dm7YTtoLgd39P6y2PQ@mail.gmail.com>
Subject: Re: [PATCH 01/22] mm: Reserve asm-generic prot flags 0x10 and 0x20
 for arch use
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20191211192639.M7UrtkgvE72HIi9qw2aYVVtIYwMAPCh5v4QoasyGGuw@z>

On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> From: Dave Martin <Dave.Martin@arm.com>
>
> The asm-generic/mman.h definitions are used by a few architectures that
> also define arch-specific PROT flags with value 0x10 and 0x20. This
> currently applies to sparc and powerpc for 0x10, while arm64 will soon
> join with 0x10 and 0x20.
>
> To help future maintainers, document the use of this flag in the
> asm-generic header too.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> [catalin.marinas@arm.com: reserve 0x20 as well]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
