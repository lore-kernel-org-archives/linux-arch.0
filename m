Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33020 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405250AbfJQIuS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 04:50:18 -0400
MIME-Version: 1.0
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
 <20191016231116.inv5stimz6fg7gof@box.shutemov.name> <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
 <20191017001613.watsu7vhqujufjxv@box.shutemov.name> <CAK7LNAT8968tYxePbS_RD0n52dLfs1vx+tdKc_64PwCzwGOgAw@mail.gmail.com>
In-Reply-To: <CAK7LNAT8968tYxePbS_RD0n52dLfs1vx+tdKc_64PwCzwGOgAw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Oct 2019 10:50:00 +0200
Message-ID: <CAK8P3a2UWyNsguPvfCiHjuk1K=iY_8ASUrG3m=gRK+p+bRWysQ@mail.gmail.com>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Pinski <apinski@cavium.com>, Michal Marek <michal.lkml@markovi.net>, mm-commits@vger.kernel.org, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Kostya Serebryany <kcc@google.com>, Ingo Molnar <mingo@elte.hu>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Thu, Oct 17, 2019 at 7:21 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Thu, Oct 17, 2019 at 9:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Wed, Oct 16, 2019 at 04:29:54PM -0700, Linus Torvalds wrote:
> I can no longer get the toolchains for hexagon, unicore32.

Guan Xuetao said in 2018 that he'd try to make a new gcc available, but
I don't think anything ever came out of that.

> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> provides hexagon compilers, but only for GCC 4.6.1

For all I know, Qualcomm use clang internally to build hexagon kernels,
it may be a good idea to try again with clang-9. The last I know about it,
clang itself should have all the required patches, but there were still
issues with using llvm as a binutils replacement (as and/or ld). Not sure
if that has been resolved by now.

      Arnd
