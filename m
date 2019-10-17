Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f45.google.com ([209.85.167.45]:37338 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390135AbfJQPiA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 11:38:00 -0400
Received: by mail-lf1-f45.google.com with SMTP id g21so1146096lfh.4
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 08:37:59 -0700 (PDT)
Date: Thu, 17 Oct 2019 18:37:55 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] [RFC, EXPERIMENTAL] allow building with --std=gnu99
Message-ID: <20191017153755.jh6iherf2ywmwbss@box>
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
 <20191017125637.1041949-1-arnd@arndb.de>
 <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Pinski <apinski@cavium.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, mm-commits@vger.kernel.org, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Kostya Serebryany <kcc@google.com>, Ingo Molnar <mingo@elte.hu>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Thu, Oct 17, 2019 at 08:05:28AM -0700, Linus Torvalds wrote:
> What distros are still stuck on gcc-4?

According to Distowatch:

- Debian 8.0 Jessie has 4.9.2, EOL 2020-05

- Ubuntu 14.04 LTS Trusty has 4.8.2, EOL 2019-04;

- Fedora 21 has 4.9.2, EOL 2015-12;

- OpenSUSE 42.3 has 4.8.5, EOL 2019-06;

- RHEL 7.7 has 4.8.5, EOL 2024-06;

- RHEL 6.9 has 4.4.7, EOL 2020-11;

- SUSE 12-SP4 has 4.8.6, EOL ?;

- Oracle 7.6 has 4.8.5, EOL ?;

Missed somebody?

-- 
 Kirill A. Shutemov
