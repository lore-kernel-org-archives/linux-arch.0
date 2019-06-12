Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36435 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408385AbfFLCS2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jun 2019 22:18:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so10806980lfc.3
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2019 19:18:26 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2sm1969797lju.52.2019.06.11.19.18.24
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:18:24 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a21so13621852ljh.7
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2019 19:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
In-Reply-To: <156025961444.27052.12727156666287330749.stgit@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2019 16:18:07 -1000
Message-ID: <CAHk-=wih2Ko+9CBRrdp36G7DPy4EDZKxZQ6q0CNyXRWsy5ujyA@mail.gmail.com>
Subject: Re: [RFC PATCH] Add script to add/remove/rename/renumber syscalls and
 resolve conflicts
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-ID: <20190612021807.TZky6P396ThoDONUXQRIiZToIPHlMy15VtiICsWi6iQ@z>

On Tue, Jun 11, 2019 at 3:27 AM David Howells <dhowells@redhat.com> wrote:
>
> Add a script that simplifies the process of altering system call tables in
> the kernel sources.  It has five functions available:

Ugh, I hate it.

I'm sure the script is all kinds of clever and useful, but I really
think the solution is not this kind of helper script, but simply that
we should work at not having each architecture add new system calls
individually in the first place.

IOW, we should look at having just one unified table for new system
call numbers, and aim for the per-architecture ones to be for "legacy
numbering".

Maybe that won't happen, but in the _hope_ that it happens, I really
would prefer that people not work at making scripts for the current
nasty situation.

                 Linus
