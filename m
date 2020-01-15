From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
Date: Wed, 15 Jan 2020 20:27:39 +0100
Message-ID: <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
References: <20200115165749.145649-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200115165749.145649-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, christophe leroy <christophe.leroy@c-s.fr>, Daniel Axtens <dja@axtens.net>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 15, 2020 at 5:58 PM Marco Elver <elver@google.com> wrote:
>   * set_bit - Atomically set a bit in memory
> @@ -26,6 +27,7 @@
>  static inline void set_bit(long nr, volatile unsigned long *addr)
>  {
>         kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> +       kcsan_check_atomic_write(addr + BIT_WORD(nr), sizeof(long));
>         arch_set_bit(nr, addr);
>  }

It looks like you add a kcsan_check_atomic_write or kcsan_check_write directly
next to almost any instance of kasan_check_write().

Are there any cases where we actually just need one of the two but not the
other? If not, maybe it's better to rename the macro and have it do both things
as needed?

      Arnd
