Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41033 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRd3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2019 12:33:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so3526160lfj.8
        for <linux-arch@vger.kernel.org>; Tue, 08 Jan 2019 09:33:28 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a127sm13292049lfe.73.2019.01.08.09.33.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:33:25 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id a16so3550744lfg.3
        for <linux-arch@vger.kernel.org>; Tue, 08 Jan 2019 09:33:25 -0800 (PST)
MIME-Version: 1.0
References: <1546964798-30067-1-git-send-email-guoren@kernel.org> <1546964798-30067-4-git-send-email-guoren@kernel.org>
In-Reply-To: <1546964798-30067-4-git-send-email-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jan 2019 09:33:09 -0800
Message-ID: <CAHk-=wh0H6_Vh3XNQ0EKWa96UFkr7j=v-++2L4kraSLR-RVciQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] csky: fixup compile error with pte_alloc
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, marc.zyngier@arm.com, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Guo Ren <ren_guo@c-sky.com>, Joel Fernandes <joel@joelfernandes.org>
Message-ID: <20190108173309.vfxMNxhPWkb29egaNvmdymlZ6pBPgzd0Omew6fNRROs@z>

On Tue, Jan 8, 2019 at 8:27 AM <guoren@kernel.org> wrote:
>
> +       for (i = 0; i < PAGE_SIZE/sizeof(pte_t); i++)
> +               (pte + i)->pte_low = _PAGE_GLOBAL;

When I first read this, I went "hmm. pte_high is not initialized".

But csky doesn't have a pte_high, and it seems that csky and SH both
decided to call their (single-word) pte member 'pte_low'.

Which is a bit odd, but whatever.

Other than that oddity, it looks fine to me. I assume I'll get a pull
request sooner or later,

              Linus
