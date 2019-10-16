Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35360 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbfJPXNc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 19:13:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so486510lji.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 16:13:31 -0700 (PDT)
Date: Thu, 17 Oct 2019 02:13:28 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
Message-ID: <20191016231328.bthzvze62epthymd@box.shutemov.name>
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
 <CAHk-=whaSMp_MOKgAa=AwLDAY0Rtjdrw-AFKuLXbFsTJSevosA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whaSMp_MOKgAa=AwLDAY0Rtjdrw-AFKuLXbFsTJSevosA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrew Pinski <apinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, mm-commits@vger.kernel.org, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Kostya Serebryany <kcc@google.com>, Ingo Molnar <mingo@elte.hu>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Wed, Oct 16, 2019 at 03:40:03PM -0700, Linus Torvalds wrote:
> On Wed, Oct 16, 2019 at 3:23 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I only tested gnu99 - which is sufficient for the above - and didn't
> > see if gnu11 ends up causing more issues..
> 
> I see at least no obvious issues with gnu11, so if this works for
> other architectures too, we should just switch over.

It would mean bumping GCC version requirements to 4.7. But no objections
on my side.

-- 
 Kirill A. Shutemov
