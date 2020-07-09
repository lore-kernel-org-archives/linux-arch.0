From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] vmlinux.lds: add PGO and AutoFDO input sections
Date: Wed, 8 Jul 2020 22:43:19 -0700
Message-ID: <202007082240.815932C2@keescook>
References: <20200622231536.7jcshis5mdn3vr54@google.com>
 <20200625184752.73095-1-ndesaulniers@google.com>
 <CAKwvOd=cum+BNHOk2djXx5JtAcCBwq2Bxy=j5ucRd2RcLWwDZQ@mail.gmail.com>
 <CAK8P3a1mBCC=hBMzxZVukHhrWhv=LiPOfV6Mgnw1QpNg=MpONg@mail.gmail.com>
 <202007020856.78DDE23F4A@keescook>
 <CAKwvOd=NeOodb=ebbodd278=ErRSmPxFNVABQS3ZO=D00yFWGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGIFnV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 01:43:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF81C061A0B
        for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2020 22:43:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so602527pjb.1
        for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2020 22:43:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKwvOd=NeOodb=ebbodd278=ErRSmPxFNVABQS3ZO=D00yFWGw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>, Jian Cai <jiancai@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Wed, Jul 08, 2020 at 04:13:54PM -0700, Nick Desaulniers wrote:
> On Thu, Jul 2, 2020 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > This looks good to me. Do you want me to carry it as part of the orphan
> > series? (It doesn't look like it'll collide, so that's not needed, but I
> > can if that makes things easier.)
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> If you would be so kind, I'd owe you yet another beer!

Yup! It's on my list; I've been clearing other stuff so I can do another
revision. (I want to move some things out of discard and into 0-size
asserts, and possibly collect Arvind's runtime relocations series too
(since it seems basically done but no x86 maintainers have snagged it).

-- 
Kees Cook
