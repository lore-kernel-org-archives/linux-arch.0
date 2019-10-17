Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35879 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437754AbfJQPZf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 11:25:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so3036193ljj.3
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 08:25:33 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t24sm1069973lfq.13.2019.10.17.08.25.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:25:32 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id n14so2996838ljj.10
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 08:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
 <20191016231116.inv5stimz6fg7gof@box.shutemov.name> <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
 <20191017001613.watsu7vhqujufjxv@box.shutemov.name> <CAK7LNAT8968tYxePbS_RD0n52dLfs1vx+tdKc_64PwCzwGOgAw@mail.gmail.com>
In-Reply-To: <CAK7LNAT8968tYxePbS_RD0n52dLfs1vx+tdKc_64PwCzwGOgAw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Oct 2019 08:17:20 -0700
Message-ID: <CAHk-=wjj_FB-PvBVqAo4h+bKgnaHiFKPw_+84X8P7uBo+qYukw@mail.gmail.com>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Pinski <apinski@cavium.com>, Michal Marek <michal.lkml@markovi.net>, mm-commits@vger.kernel.org, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Kostya Serebryany <kcc@google.com>, Ingo Molnar <mingo@elte.hu>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Wed, Oct 16, 2019 at 10:21 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I tested -std=gnu99 for ARM with pre-built Linaro toolchains.
>
> GCC 4.9.4 was NG,
> GCC 5.3.1 was OK.

Ok, so the gcc-5.1 cut-off from my gcc git tree conversion looks to be
the right one. I wasn't sure how official/complete the git conversion
was.

> If we increase the minimal GCC version, we might end up with dropping
> more architecture.

That I wouldn't worry about. If some architecture can't get a gcc
version from the last five years, I think we _should_ drop it.

Historically, the problem has more been distro gcc versions. An
unmaintained architecture that has a compiler that is ancient I don't
much care about, but if we lose testers that use ancient distros, that
loses real coverage.

That's true even if it's just one or two actual users that upgrade
kernels - we found a real bug not that long ago because rmk used some
ancient Debian install with a new kernel. That's the kind of odd use
we want to encourage, and that matters. Hexagon? Not so much.

Although I think rmk actually had a new compiler and cross-built the
new kernel, so that likely wasn't the issue in _that_ particular case,
but in other cases it might have been.

              Linus
