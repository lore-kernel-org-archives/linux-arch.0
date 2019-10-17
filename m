Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46552 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732271AbfJQPrU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 11:47:20 -0400
MIME-Version: 1.0
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
 <20191017125637.1041949-1-arnd@arndb.de> <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
 <20191017153755.jh6iherf2ywmwbss@box>
In-Reply-To: <20191017153755.jh6iherf2ywmwbss@box>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Oct 2019 17:47:01 +0200
Message-ID: <CAK8P3a1TrOippPUh6Fc_McHcp2LOerdD6ifmcieuy0bAFPvs8g@mail.gmail.com>
Subject: Re: [PATCH] [RFC, EXPERIMENTAL] allow building with --std=gnu99
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Pinski <apinski@cavium.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, mm-commits@vger.kernel.org, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Kostya Serebryany <kcc@google.com>, Ingo Molnar <mingo@elte.hu>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Thu, Oct 17, 2019 at 5:37 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Oct 17, 2019 at 08:05:28AM -0700, Linus Torvalds wrote:
> > What distros are still stuck on gcc-4?
>
> According to Distowatch:
>
> - Debian 8.0 Jessie has 4.9.2, EOL 2020-05
>
> - Ubuntu 14.04 LTS Trusty has 4.8.2, EOL 2019-04;
>
> - Fedora 21 has 4.9.2, EOL 2015-12;
>
> - OpenSUSE 42.3 has 4.8.5, EOL 2019-06;
>
> - RHEL 7.7 has 4.8.5, EOL 2024-06;
>
> - RHEL 6.9 has 4.4.7, EOL 2020-11;
>
> - SUSE 12-SP4 has 4.8.6, EOL ?;

EOL 2024 as well, extended support 2027

> - Oracle 7.6 has 4.8.5, EOL ?;
>
> Missed somebody?

I started a similar list, the only other one I found was

Slackware 14.1 (no EOL announced): gcc-4.8

For the record, that seems to mean that moving to gcc-4.8
would likely not cause a lot of problems and would let us do
some other cleanups, but unfortunately would not help with
the compound literals.

     Arnd
