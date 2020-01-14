From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
Date: Tue, 14 Jan 2020 21:57:42 +0100
Message-ID: <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com>
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200114200846.29434-2-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Linus Torvalds <torvalds@linux-foundation.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
