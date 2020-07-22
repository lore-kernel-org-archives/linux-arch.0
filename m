From: Marco Elver <elver@google.com>
Subject: Re: [PATCH 8/8] locking/atomics: Use read-write instrumentation for
 atomic RMWs
Date: Wed, 22 Jul 2020 12:11:18 +0200
Message-ID: <CANpmjNM6C6QtrtLhRkbmfc3jLqYaQOvvM_vKA6UyrkWadkdzNQ@mail.gmail.com>
References: <20200721103016.3287832-1-elver@google.com> <20200721103016.3287832-9-elver@google.com>
 <20200721141859.GC10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgGVKLa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 06:11:30 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBDEC0619DE
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 03:11:30 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j11so1358213oiw.12
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 03:11:30 -0700 (PDT)
In-Reply-To: <20200721141859.GC10769@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, 21 Jul 2020 at 16:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 21, 2020 at 12:30:16PM +0200, Marco Elver wrote:
>
> > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > index 6afadf73da17..5cdcce703660 100755
> > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > @@ -5,9 +5,10 @@ ATOMICDIR=$(dirname $0)
> >
> >  . ${ATOMICDIR}/atomic-tbl.sh
> >
> > -#gen_param_check(arg)
> > +#gen_param_check(meta, arg)
> >  gen_param_check()
> >  {
> > +     local meta="$1"; shift
> >       local arg="$1"; shift
> >       local type="${arg%%:*}"
> >       local name="$(gen_param_name "${arg}")"
> > @@ -17,17 +18,24 @@ gen_param_check()
> >       i) return;;
> >       esac
> >
> > -     # We don't write to constant parameters
> > -     [ ${type#c} != ${type} ] && rw="read"
> > +     if [ ${type#c} != ${type} ]; then
> > +             # We don't write to constant parameters
> > +             rw="read"
> > +     elif [ "${meta}" != "s" ]; then
> > +             # Atomic RMW
> > +             rw="read_write"
> > +     fi
>
> If we have meta, should we then not be consistent and use it for read
> too? Mark?

gen_param_check seems to want to generate an 'instrument_' check per
pointer argument. So if we have 1 argument that is a constant pointer,
and one that isn't, it should generate different instrumentation for
each. By checking the argument type, we get that behaviour. Although
we are making the assumption that if meta indicates it's not a 's'tore
(with void return), it's always a read-write access on all non-const
pointers.

Switching over to checking only meta would always generate the same
'instrument_' call for each argument. Although right now that would
seem to work because we don't yet have an atomic that accepts a
constant pointer and a non-const one.

Preferences?

> >       printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
> >  }
> >
> > -#gen_param_check(arg...)
> > +#gen_params_checks(meta, arg...)
> >  gen_params_checks()
> >  {
> > +     local meta="$1"; shift
> > +
> >       while [ "$#" -gt 0 ]; do
> > -             gen_param_check "$1"
> > +             gen_param_check "$meta" "$1"
> >               shift;
> >       done
> >  }
> > @@ -77,7 +85,7 @@ gen_proto_order_variant()
> >
> >       local ret="$(gen_ret_type "${meta}" "${int}")"
> >       local params="$(gen_params "${int}" "${atomic}" "$@")"
> > -     local checks="$(gen_params_checks "$@")"
> > +     local checks="$(gen_params_checks "${meta}" "$@")"
> >       local args="$(gen_args "$@")"
> >       local retstmt="$(gen_ret_stmt "${meta}")"
> >
> > --
> > 2.28.0.rc0.105.gf9edc3c819-goog
> >
