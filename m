From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer infrastructure
Date: Tue, 19 Nov 2019 20:54:14 +0100
Message-ID: <CANpmjNPiKg++=QHUjD87dqiBU1pHHfZmGLAh1gOZ+4JKAQ4SAQ@mail.gmail.com>
References: <20191114180303.66955-1-elver@google.com> <20191114180303.66955-2-elver@google.com>
 <1574191653.9585.6.camel@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574191653.9585.6.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-arch.vger.kernel.org

On Tue, 19 Nov 2019 at 20:27, Qian Cai <cai@lca.pw> wrote:
>
> On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:
>
> > +menuconfig KCSAN
> > +     bool "KCSAN: watchpoint-based dynamic data race detector"
> > +     depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE
>
> "!KASAN" makes me sorrow. What's problem of those two?

Both of them instrument memory accesses, and gcc doesn't let us
combine '-fsanitize=3D{kernel-,}address' and '-fsanitize=3Dthread'.

> cc1: error: =E2=80=98-fsanitize=3Daddress=E2=80=99 and =E2=80=98-fsanitiz=
e=3Dkernel-address=E2=80=99 are incompatible with =E2=80=98-fsanitize=3Dthr=
ead=E2=80=99

In principle, it may be possible:
- either by updating the compiler, which we want to avoid because we'd
have to convince gcc and clang to do this; I can see this being
infeasible because the compiler needs to become aware (somehow
propagate in the IR) of what is ASAN inline-instrumentation and what
is TSAN instrumentation and not emit recursive instrumentation.
- or somehow merging the instrumentation, but, IMHO this is probably a
really bad idea for various other reasons (complexity, performance,
stability, etc.).

Regardless of approach, my guess is that the complexity outweighs any
benefits this may provide in the end. Not only would a hypothetical
kernel that combines these be extremely slow, it'd also diminish the
practical value because testing and finding bugs would also be
impaired due to performance.

Thanks,
-- Marco
