Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:58756 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472AbaFXQn7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jun 2014 12:43:59 -0400
Received: by mail-oa0-f41.google.com with SMTP id l6so648646oag.28
        for <linux-arch@vger.kernel.org>; Tue, 24 Jun 2014 09:43:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53A95187.4010805@gmail.com>
References: <20140623220150.GM5412@outflux.net>
	<53A95187.4010805@gmail.com>
Date: Tue, 24 Jun 2014 09:43:58 -0700
Message-ID: <CAGXu5j+A1WCA13rRnREh_m0kwsYfBrZSwB25NXEdpQNpgjJfyw@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] man-pages: seccomp.2: document syscall
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Alexei Starovoitov <ast@plumgrid.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Borkmann <dborkman@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@chromium.org>, David Drysdale <drysdale@google.com>, Linux API <linux-api@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>
Message-ID: <20140624164358.DZxGTsPDoWO9MFc4843plX5KmIjH2pEInSOg67T26AA@z>

On Tue, Jun 24, 2014 at 3:23 AM, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> On 06/24/2014 12:01 AM, Kees Cook wrote:
>> Combines documentation from prctl, and in-kernel seccomp_filter.txt,
>> along with new details specific to the new syscall.
>
> Great work on the man page, Kees! (BTW, just looking at the complexity detailed
> there further supports the decision to grant this functionality as a separate
> syscall, rather than multiplexed into prctl(2).

Great, thanks!

> Would there be some suitable, not too long program that we
> could put in the man page as an example for using filters?

Sure thing. I can modify the "dropper" sample in samples/seccomp. I
will resend the man-page with that added.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
