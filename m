Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39547 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfJOVqs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 17:46:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so21830482ljj.6
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:46:47 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d26sm5265287ljc.64.2019.10.15.14.46.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 14:46:43 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id q12so15644167lfc.11
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-3-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-3-vgupta@synopsys.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Oct 2019 14:46:27 -0700
Message-ID: <CAHk-=whtRuGdsm0BR50vpwJBRJgP3u6Suz0LNa6WzR9RMtJjbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] asm-generic/tlb: stub out pud_free_tlb() if nopud ...
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linux-MM <linux-mm@kvack.org>, linux-snps-arc@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20191015214627.zTWMmL0qYQDj-DOTd10k3bn0Og3afdBC_e_B8_asAYA@z>

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
> from this routine which is not required in a 2-level paging setup

Ack, looks good.

           Linus
