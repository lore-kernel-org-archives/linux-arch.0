Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41369 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfJPXaP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 19:30:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so479220ljg.8
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 16:30:13 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 77sm139679ljj.84.2019.10.16.16.30.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 16:30:11 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w6so315576lfl.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 16:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com> <20191016231116.inv5stimz6fg7gof@box.shutemov.name>
In-Reply-To: <20191016231116.inv5stimz6fg7gof@box.shutemov.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Oct 2019 16:29:54 -0700
Message-ID: <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Pinski <apinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, mm-commits@vger.kernel.org, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, Kostya Serebryany <kcc@google.com>, Ingo Molnar <mingo@elte.hu>, linux-arch <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Wed, Oct 16, 2019 at 4:11 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Looks like it was fixed soon after the complain:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63567

Ahh, so there are gcc versions which essentially do this wrong, and
I'm not seeing it because it was fixed.

Ho humm. Considering that this was fixed in gcc five years ago, and we
already require gc-4.6, and did that two years ago, maybe we can just
raise the requirement a bit further.

BUT.

It's not clear which versions are ok with this. In your next email you said:

> It would mean bumping GCC version requirements to 4.7.

which I think would be reasonable, but is it actually ok in 4.7?

The bugzilla entry says "Target Milestone: 5.0", and I'm not sure how
to check what that "revision=216440" ends up actually meaning.

I have a git tree of gcc, and in that one 216440 is commit
d303aeafa9b, but that seems to imply it only made it into 5.1:

  [torvalds@i7 gcc]$ git name-rev --tags
d303aeafa9b46e06cd853696acb6345dff51a6b9
  d303aeafa9b46e06cd853696acb6345dff51a6b9 tags/gcc-5_1_0-release~3943

so we'd have to jump forward a _lot_.

That's a bit sad and annoying. I'd be ok with jumping to 4.7, but I'm
not sure we can jump to 5.1.

Although maybe we should be a _lot_ more aggressive about gcc
versions, I'm on gcc-9.2.1 right now, and gcc-5.1 is from April 22,
2015.

              Linus
