Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:43061 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANU6A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 15:58:00 -0500
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
In-Reply-To: <20200114200846.29434-2-vgupta@synopsys.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Jan 2020 21:57:42 +0100
Message-ID: <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200114205742.IevXvlPe9J8FnX9qL8ykSj0nyFMLnjk-_OjV5M9S25w@z>

On Tue, Jan 14, 2020 at 9:08 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> There are 2 generic varaints of strncpy_from_user() / strnlen_user()
>  (1). inline version in asm-generic/uaccess.h
>  (2). optimized word-at-a-time version in lib/*
>
> This patch disables #1 if #2 selected. This allows arches to continue
> reusing asm-generic/uaccess.h for rest of code
>
> This came up when switching ARC to generic word-at-a-time interface
>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

This looks like a useful change, but I think we can do even better: It
seems that
there are no  callers of __strnlen_user or __strncpy_from_user  in the
kernel today, so these should not be defined either when the Kconfig symbols
are set. Also, I would suggest moving the 'extern' declaration for the two
functions into the #else branch of the conditional so it does not need to be
duplicated.

      Arnd
