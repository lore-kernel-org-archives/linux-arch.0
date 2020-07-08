From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] vmlinux.lds: add PGO and AutoFDO input sections
Date: Wed, 8 Jul 2020 16:13:54 -0700
Message-ID: <CAKwvOd=NeOodb=ebbodd278=ErRSmPxFNVABQS3ZO=D00yFWGw@mail.gmail.com>
References: <20200622231536.7jcshis5mdn3vr54@google.com> <20200625184752.73095-1-ndesaulniers@google.com>
 <CAKwvOd=cum+BNHOk2djXx5JtAcCBwq2Bxy=j5ucRd2RcLWwDZQ@mail.gmail.com>
 <CAK8P3a1mBCC=hBMzxZVukHhrWhv=LiPOfV6Mgnw1QpNg=MpONg@mail.gmail.com> <202007020856.78DDE23F4A@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgGHXOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 19:14:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30DC08C5C1
        for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2020 16:14:08 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gc15so2595014pjb.0
        for <linux-arch@vger.kernel.org>; Wed, 08 Jul 2020 16:14:08 -0700 (PDT)
In-Reply-To: <202007020856.78DDE23F4A@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>, Jian Cai <jiancai@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Thu, Jul 2, 2020 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> This looks good to me. Do you want me to carry it as part of the orphan
> series? (It doesn't look like it'll collide, so that's not needed, but I
> can if that makes things easier.)
>
> Acked-by: Kees Cook <keescook@chromium.org>

If you would be so kind, I'd owe you yet another beer!
-- 
Thanks,
~Nick Desaulniers
