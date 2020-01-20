Return-Path: <SRS0=nYHR=3J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36861 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgATOZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:25:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so29799095wru.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
In-Reply-To: <20200120141927.114373-1-elver@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 20 Jan 2020 15:25:23 +0100
Message-ID: <CAG_fn=VyL3t0L-ZhRtc41+fcipmSWrhwb+QFkRZ+ZeZQ=X_dLg@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>, Dmitriy Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, will@kernel.org, Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, christophe.leroy@c-s.fr, Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, christian.brauner@ubuntu.com, daniel@iogearbox.net, cyphar@cyphar.com, Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org
Message-ID: <20200120142523.sbULA-zftfV7yfB13lF2EQqb2x9hcaca7rgNsbSvJUs@z>

On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
>
> This adds instrumented.h, which provides generic wrappers for memory
> access instrumentation that the compiler cannot emit for various
> sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> future this will also include KMSAN instrumentation.
>
> Note that, copy_{to,from}_user require special instrumentation,
> providing hooks before and after the access, since we may need to know
> the actual bytes accessed (currently this is relevant for KCSAN, and is
> also relevant in future for KMSAN).
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
