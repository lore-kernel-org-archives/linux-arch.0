Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfFYUNZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 16:13:25 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723882146E
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 20:13:24 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id d18so55630wrs.5
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 13:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com> <201906251131.419D8ACB@keescook>
In-Reply-To: <201906251131.419D8ACB@keescook>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 25 Jun 2019 13:13:11 -0700
Message-ID: <CALCETrWg+vZWAdY-6etLnh=wyB1aXdG9s8ASUXX=cjjFm7CKZQ@mail.gmail.com>
Subject: Re: Detecting the availability of VSYSCALL
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>, Linux API <linux-api@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-x86_64@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Carlos O'Donell <carlos@redhat.com>
Message-ID: <20190625201311.bS4Kl_3CDm4yaQL8REgCKo3JMvFWXI3ZhCHhzEPPcDY@z>

On Tue, Jun 25, 2019 at 1:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jun 25, 2019 at 05:15:27PM +0200, Florian Weimer wrote:
> > Should we try mapping something at the magic address (without MAP_FIXED)
> > and see if we get back a different address?  Something in the auxiliary
> > vector would work for us, too, but nothing seems to exists there
> > unfortunately.
>
> It seems like mmap() won't even work because it's in the high memory
> area. I can't map something a page under the vsyscall page either, so I
> can't distinguish it with mmap, mprotect, madvise, or msync. :(
>

I keep contemplating making munmap() work on it.  That would nicely
answer the question: if munmap() fails, it's not there, and, if
munmap() succeeds, it's not there :)
