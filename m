Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34000 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFQSQW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jun 2019 14:16:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so10294827ljg.1
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 11:16:21 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id v14sm2194894ljh.51.2019.06.17.11.16.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id a21so10259423ljh.7
        for <linux-arch@vger.kernel.org>; Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com> <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
 <87k1dkdr9c.fsf@oldenburg2.str.redhat.com> <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
In-Reply-To: <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Jun 2019 11:16:03 -0700
Message-ID: <CAHk-=whkCOVzXeju8H8iWeh-vWorpWSZG6USFKcOWQ36XokZMA@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Joseph Myers <joseph@codesourcery.com>, Arnd Bergmann <arnd@arndb.de>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, Laura Abbott <labbott@redhat.com>, Paul Burton <pburton@wavecomp.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-ID: <20190617181603.WrnTmSMXzLO-96dYBdMf142J7xy5PwSQFtwuhwNxngE@z>

On Mon, Jun 17, 2019 at 11:13 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That one we might be able to just fix by renaming "fds_bits" to "__fds_bits".

That said, moving it to another file might be the better option anyway.

I think fd_set and friends are now supposed to be in <sys/select.h>
anyway, and the "it was in <sys/types.h>" is all legacy.

                 Linus
