Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43259 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEaPMQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 11:12:16 -0400
Received: by mail-oi1-f195.google.com with SMTP id t187so7927435oie.10
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 08:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190529141500.193390-1-elver@google.com>
In-Reply-To: <20190529141500.193390-1-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 31 May 2019 17:12:03 +0200
Message-ID: <CANpmjNNH2e5YpxKymXE0sTgcrrW0z0EP+dEsPJOfTQJ19yS_Yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bitops instrumentation for KASAN
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190531151203.JAL1hrB6CGFRh0dPz4hPz3hRJH-i4JOokVcn39cCGCA@z>

Addressed comments, and sent v3:
http://lkml.kernel.org/r/20190531150828.157832-1-elver@google.com

Many thanks!

-- Marco

On Wed, 29 May 2019 at 16:23, Marco Elver <elver@google.com> wrote:
>
> The previous version of this patch series and discussion can be found
> here:  https://lkml.org/lkml/2019/5/28/769
>
> The most significant change is the change of the instrumented access
> size to cover the entire word of a bit.
>
> Marco Elver (3):
>   lib/test_kasan: Add bitops tests
>   x86: Move CPU feature test out of uaccess region
>   asm-generic, x86: Add bitops instrumentation for KASAN
>
>  Documentation/core-api/kernel-api.rst     |   2 +-
>  arch/x86/ia32/ia32_signal.c               |   9 +-
>  arch/x86/include/asm/bitops.h             | 210 ++++----------
>  include/asm-generic/bitops-instrumented.h | 317 ++++++++++++++++++++++
>  lib/test_kasan.c                          |  75 ++++-
>  5 files changed, 450 insertions(+), 163 deletions(-)
>  create mode 100644 include/asm-generic/bitops-instrumented.h
>
> --
> 2.22.0.rc1.257.g3120a18244-goog
>
