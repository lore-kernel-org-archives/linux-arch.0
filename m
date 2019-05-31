Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38814 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfEaSbP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 14:31:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id o13so10533207lji.5
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 11:31:14 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y2sm1315542lfc.35.2019.05.31.11.31.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 11:31:12 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id h19so10534271ljj.4
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 11:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190528120453.27374-1-npiggin@gmail.com>
In-Reply-To: <20190528120453.27374-1-npiggin@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 May 2019 11:30:55 -0700
Message-ID: <CAHk-=whHWqVPWMeNRYuxAd8xnZscshoXUP8SFPmJivJfds5-HQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/large system hash: use vmalloc for size >
 MAX_ORDER when !hashdist
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>

On Tue, May 28, 2019 at 5:08 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The kernel currently clamps large system hashes to MAX_ORDER when
> hashdist is not set, which is rather arbitrary.

I think the *really* arbitrary part here is "hashdist".

If you enable NUMA support, hashdist is just set to 1 by default on
64-bit, whether the machine actually has any numa characteristics or
not. So you take that vmalloc() TLB overhead whether you need it or
not.

So I think your series looks sane, and should help the vmalloc case
for big hash allocations, but I also think that this whole
alloc_large_system_hash() function should be smarter in general.

Yes, it's called "alloc_large_system_hash()", but it's used on small
and perfectly normal-sized systems too, and often for not all that big
hashes.

Yes, we tend to try to make some of those hashes large (dentry one in
particular), but we also use this for small stuff.

For example, on my machine I have several network hashes that have
order 6-8 sizes, none of which really make any sense to use vmalloc
space for (and which are smaller than a large page, so your patch
series wouldn't help).

So on the whole I have no issues with this series, but I do think we
should maybe fix that crazy "if (hashdist)" case. Hmm?

                   Linus
