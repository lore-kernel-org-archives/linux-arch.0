Return-Path: <SRS0=rKsc=43=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40452 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgCJCOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 22:14:11 -0400
MIME-Version: 1.0
References: <CAMe9rOpJjaro_qK6kghGNuSHDaP_MjVaZMbok2kbuBD48VmvXg@mail.gmail.com>
 <E7E7A2AE-500A-4817-B00A-BE419E89C6F9@amacapital.net>
In-Reply-To: <E7E7A2AE-500A-4817-B00A-BE419E89C6F9@amacapital.net>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Mon, 9 Mar 2020 19:13:34 -0700
Message-ID: <CAMe9rOoZazTpWcK1hr4d25z8Gv3yGbpn_48R1RHGfq-aDOJ0Eg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200310021334.7Sg1S9EHgTTddjTgj3xkw7Z1OBmWWxHWZl-ftpApyhA@z>

On Mon, Mar 9, 2020 at 6:21 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> I am baffled by this discussion.
>
> >> On Mar 9, 2020, at 5:09 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
> >>
> >> =EF=BB=BFOn Mon, Mar 9, 2020 at 4:59 PM Andy Lutomirski <luto@amacapit=
al.net> wrote:
> >
> >>>> .
> >> This could presumably have been fixed by having libpcre or sljit
> >> disable IBT before calling into JIT code or by running the JIT code in
> >> another thread.  In the other direction, a non-CET libpcre build could
> >> build IBT-capable JITted code and enable JIT (by syscall if we allow
> >> that or by creating a thread?) when calling it.  And IBT has this
> >
> > This is not how thread in user space works.
>
> void create_cet_thread(void (*func)(), unsigned int cet_flags);
>
> I could implement this using clone() if the kernel provides the requisite=
 support. Sure, creating threads behind libc=E2=80=99s back like this is pe=
rilous, but it can be done.

Sure, this can live outside of libc with kernel support.

> >
> >> fancy legacy bitmap to allow non-instrumented code to run with IBT on,
> >> although SHSTK doesn't have hardware support for a similar feature.
> >
> > All these changes are called CET enabing.
>
> What does that mean?  If program A loads library B, and library B very ca=
refully loads CET-mismatched code, program A may be blissfully unaware.

Any source changes to make codes CET compatible is to enable CET.

Shadow stack can't be turned on or off arbitrarily.  ld.so checks it and
makes sure that everything is consistent.  But this is entirely done in
user space.  In the first phase, we want to make CET simple, not too
complicated.


H.J.
