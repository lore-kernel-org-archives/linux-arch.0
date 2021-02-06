Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C311EC433E0
	for <linux-arch@archiver.kernel.org>; Sat,  6 Feb 2021 12:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8672C64E2C
	for <linux-arch@archiver.kernel.org>; Sat,  6 Feb 2021 12:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhBFMGJ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 6 Feb 2021 07:06:09 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:59041 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFMGI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Feb 2021 07:06:08 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 116C4sAC025439;
        Sat, 6 Feb 2021 21:04:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 116C4sAC025439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1612613095;
        bh=MyNqLeD8oVO7QhYdCXn23TUBvKfzTHuvCBPmk1/AVSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K3geEpuhiCQjYDuZ3lkjgTQU3ssF/X0s6aKbQRUl4gIQDC8lC0LAa6WnYeYGN6Xzd
         QqHLt1EVWxlSMZ+dsgOag6O6i9hFwO+Wc3A2FsYUgSJ317acyAnpIENuQVsjpXX6Ck
         oWuyNyP6lPTsKzJ15S/e7dzaKMStO6Ofl49JDrdzn1e2bT9xS2Lo9gHWrEVwnzH1YQ
         SjyLRkSXabu2V2IJK0OkHrE17Srtu0CBXddh+c5maVTB7PQKGLkw7yEPnVY/r6neFu
         xDY0IoDyrRjZ62M+kZ0mS62ayhkHl6JF1tsjyQh7KZArxZAIH3dkiYVDbP4Xj9LtTt
         kAElfzuu2AokA==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id z9so5312329pjl.5;
        Sat, 06 Feb 2021 04:04:54 -0800 (PST)
X-Gm-Message-State: AOAM532S3ekjDX8mYfpspKZME8xFhmV2IHvrPnE4ILRrY5tMlGSUuN/a
        lcxltvA9OaQCKDiEi/FxMDPTOVS44/Zjta3a8WQ=
X-Google-Smtp-Source: ABdhPJwNlPxaQhlrZOPfVop4v8yIt2lEK6B6xfhzZWKyP0MRXzE42NG6YouA87nqr8PtXiIIVdTNXol9eKU8k9mlaoA=
X-Received: by 2002:a17:90a:5403:: with SMTP id z3mr8631933pjh.198.1612613094061;
 Sat, 06 Feb 2021 04:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20210205202220.2748551-1-ndesaulniers@google.com> <CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com>
In-Reply-To: <CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 6 Feb 2021 21:04:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT8rjo=MdLqpjRXR2fnJ8XSeoA=uD633Pj1ENs5JOciXQ@mail.gmail.com>
Message-ID: <CAK7LNAT8rjo=MdLqpjRXR2fnJ8XSeoA=uD633Pj1ENs5JOciXQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] Kbuild: DWARF v5 support
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chris Murphy <bugzilla@colorremedies.com>,
        Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 6, 2021 at 6:00 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 9:22 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > DWARF v5 is the latest standard of the DWARF debug info format.
> >
> > DWARF5 wins significantly in terms of size and especially so when mixed
> > with compression (CONFIG_DEBUG_INFO_COMPRESSED).
> >
> > Link: http://www.dwarfstd.org/doc/DWARF5.pdf
> >
> > Patch 1 places the DWARF v5 sections explicitly in the kernel linker
> > script.
> > Patch 2 modifies Kconfig for DEBUG_INFO_DWARF4 to be used as a fallback.
> > Patch 3 adds an explicit Kconfig for DWARF v5 for clang and older GCC
> > where the implicit default DWARF version is not 5.
> >
> > Changes from v8:
> > * Separate out the linker script changes (from v7 0002). Put those
> >   first. Carry Reviewed by and tested by tags.  Least contentious part
> >   of the series. Tagged for stable; otherwise users upgrading to GCC 11
> >   may find orphan section warnings from the implicit default DWARF
> >   version changing and generating the new debug info sections.
> > * Add CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT in 0002, make it the
> >   default rather than CONFIG_DEBUG_INFO_DWARF4, as per Mark, Jakub,
> >   Arvind.
> > * Drop reviewed by and tested by tags for 0002 and 0003; sorry
> >   reviewers/testers, but I view that as a big change. I will buy you
> >   beers if you're fatigued, AND for the help so far. I appreciate you.
>
> All 3 patches NACKed - I drink no beer.

LoL.
Other than beer, I am fine with v9.

Personally, I thought v8 (no CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT)
was good too, but I do not have a strong opinion about
leaving the compiler's freedom to choose the dwarf version.

Unless somebody has an objection, I will pick up v9 for the next MW.


Meanwhile, if you want to give reviewed-by / tested-by
please do so.



-- 
Best Regards
Masahiro Yamada
