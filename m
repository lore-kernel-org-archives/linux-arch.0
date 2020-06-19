Return-Path: <SRS0=lJ0G=AA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732015AbgFSSiI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2020 14:38:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD03C0613EF
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 11:38:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so12615177ljn.6
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 11:38:06 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 5sm1286398ljr.64.2020.06.19.11.38.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:38:04 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id g139so5319233lfd.10
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2020 11:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210645.GB2212102@localhost.localdomain>
In-Reply-To: <20200618210645.GB2212102@localhost.localdomain>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Jun 2020 11:37:47 -0700
Message-ID: <CAHk-=whz7xz1EBqfyS-C8zTx3_q54R1GuX9tDHdK1-TG91WH-Q@mail.gmail.com>
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, NetFilter <netfilter-devel@vger.kernel.org>
Message-ID: <20200619183747.FVSaV8qu-x7bcvekL9Gf007SaBaYORW7La4fNLd0Ur4@z>

On Thu, Jun 18, 2020 at 2:06 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Rename
>         struct notifier_block *this
> to
>         struct notifier_block *nb
>
> "nb" is arguably a better name for notifier block.

Maybe it's a better name. But it doesn't seem worth it.

Because C++ reserved words are entirely irrelevant.

We did this same dance almost three decades ago, and the fact is, C++
has other reserved words that make it all pointless.

There is no way I will accept the renaming of various "new" variables.
We did it, it was bad, we undid it, and we now have a _lot_ more uses
of 'new' and 'old', and no, we're not changing it for a braindead
language that isn't relevant to the kernel.

The fact is, C++ chose bad identifiers to make reserved words.

If you want to build the kernel with C++, you'd be a lot better off just doing

   /* C++ braindamage */
   #define this __this
   #define new __new

and deal with that instead.

Because no, the 'new' renaming will never happen, and while 'this'
isn't nearly as common or relevant a name, once you have the same
issue with 'new', what's the point of trying to deal with 'this'?

             Linus
