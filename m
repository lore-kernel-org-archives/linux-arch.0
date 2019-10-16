Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40283 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfJPXLV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 19:11:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id f23so269480lfk.7
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 16:11:20 -0700 (PDT)
Date: Thu, 17 Oct 2019 02:11:16 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
Message-ID: <20191016231116.inv5stimz6fg7gof@box.shutemov.name>
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Pinski <apinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, mm-commits@vger.kernel.org, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Kostya Serebryany <kcc@google.com>, Ingo Molnar <mingo@elte.hu>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Wed, Oct 16, 2019 at 03:23:42PM -0700, Linus Torvalds wrote:
> [ Coming back to this, because it was annoying me ]
> 
> On Tue, Oct 11, 2016 at 4:06 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > HOWEVER - and this is really annoying - we'd need to use "-std=gnu99/gnu11"
> 
> Hmm.
> 
> I just tried it again after a long time, and "-std=gnu99" seems to
> work fine for me on the kernel these days. The old "compound literal"
> issues we had at some point seem gone.
> 
> Maybe we've cleaned everything up that used to cause problems. Or
> maybe I just mis-remembered and we should have done this long ago?

Looks like it was fixed soon after the complain:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63567

-- 
 Kirill A. Shutemov
