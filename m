From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v2 1/3] asm-generic/atomic: Use __always_inline for pure wrappers
Date: Tue, 26 Nov 2019 15:06:21 +0100
Message-ID: <CANpmjNNcWujm-Q8WD2Lgf2ww5aG-kfmFca7YC96BdcFOkwgxXw@mail.gmail.com>
References: <20191126114121.85552-1-elver@google.com> <20191126122917.GA37833@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191126122917.GA37833@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, "Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 26 Nov 2019 at 13:29, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Nov 26, 2019 at 12:41:19PM +0100, Marco Elver wrote:
> > Prefer __always_inline for atomic wrappers. When building for size
> > (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> > inline even relatively small static inline functions that are assumed to
> > be inlinable such as atomic ops. This can cause problems, for example in
> > UACCESS regions.
> >
> > By using __always_inline, we let the real implementation and not the
> > wrapper determine the final inlining preference.
> >
> > For x86 tinyconfig we observe:
> > - vmlinux baseline: 1316204
> > - vmlinux with patch: 1315988 (-216 bytes)
> >
> > This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
> > in the KCSAN runtime:
> > http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Add missing '#include <linux/compiler.h>'
> > * Add size diff to commit message.
> >
> > v1: http://lkml.kernel.org/r/20191122154221.247680-1-elver@google.com
> > ---
> >  include/asm-generic/atomic-instrumented.h | 335 +++++++++++-----------
> >  include/asm-generic/atomic-long.h         | 331 ++++++++++-----------
> >  scripts/atomic/gen-atomic-instrumented.sh |   7 +-
> >  scripts/atomic/gen-atomic-long.sh         |   3 +-
> >  4 files changed, 340 insertions(+), 336 deletions(-)
>
> > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > index 8b8b2a6f8d68..86d27252b988 100755
> > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > @@ -84,7 +84,7 @@ gen_proto_order_variant()
> >       [ ! -z "${guard}" ] && printf "#if ${guard}\n"
> >
> >  cat <<EOF
> > -static inline ${ret}
> > +static __always_inline ${ret}
> >  ${atomicname}(${params})
> >  {
> >  ${checks}
> > @@ -146,17 +146,18 @@ cat << EOF
> >  #ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
> >  #define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
> >
> > +#include <linux/compiler.h>
> >  #include <linux/build_bug.h>
>
> Sorry for the (super) trivial nit, but could you please re-order these
> two alphabetically, i.e.
>
> #include <linux/build_bug.h>
> #include <linux/compiler.h>
>
> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Done, thanks for the acks!

v3: http://lkml.kernel.org/r/20191126140406.164870-1-elver@google.com

> [...]
>
> > @@ -64,6 +64,7 @@ cat << EOF
> >  #ifndef _ASM_GENERIC_ATOMIC_LONG_H
> >  #define _ASM_GENERIC_ATOMIC_LONG_H
> >
> > +#include <linux/compiler.h>
> >  #include <asm/types.h>
>
> Unlike the above, this doesn't need to be re-ordered; for whatever
> reason, linux/* includes typically come before asm/* includes.
>
> Thanks,
> Mark.
