Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41969 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbfJOVrY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 17:47:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so15645633lfn.8
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:47:23 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m15sm5231067ljh.50.2019.10.15.14.47.18
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 14:47:19 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v24so21822758ljj.3
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-4-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-4-vgupta@synopsys.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Oct 2019 14:47:02 -0700
Message-ID: <CAHk-=wg470=r9YPMLyJdgr-aLvHSnDOFwFx=Y=_HPAW-aqyFRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linux-MM <linux-mm@kvack.org>, linux-snps-arc@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20191015214702.OlaeBTufYdA0fLEawy0plUh2UVDk5gqWJhtNuEfeq84@z>

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
> from this routine not required in a 2-level paging setup

Similarly acked,

          Linus
