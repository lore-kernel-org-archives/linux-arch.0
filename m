From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 16:59:37 -0700
Message-ID: <CALCETrWF1NQeGXy0GXRwW71Bc3oSN=vsXMsBqnaqs7Us7RYebQ@mail.gmail.com>
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net> <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com> <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
 <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com> <CAMe9rOrzrXORQgcAwzGn+=PBvxCEgc5Km_TQq+P7uoqwiacJSA@mail.gmail.com>
 <c06073a2-6858-d5dc-d74b-ef2568bd9423@intel.com> <CAMe9rOrxM=RefftngNXhP906mrW1SMy7vp+O=yOj_WwcdQpGcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMe9rOrxM=RefftngNXhP906mrW1SMy7vp+O=yOj_WwcdQpGcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 9, 2020 at 4:52 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Mon, Mar 9, 2020 at 4:21 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 3/9/20 4:11 PM, H.J. Lu wrote:
> > > A threaded application is loaded from disk.  The object file on disk is
> > > either CET enabled or not CET enabled.
> >
> > Huh.  Are you saying that all instructions executed on userspace on
> > Linux come off of object files on the disk?  That's an interesting
> > assertion.  You might want to go take a look at the processes on your
> > systems.  Here's my browser for example:
> >
> > # for p in $(ps aux | grep chromium | awk '{print $2}' ); do cat
> > /proc/$p/maps; done | grep ' r-xp 00000000 00:00 0'
> > ...
> > 202f00082000-202f000bf000 r-xp 00000000 00:00 0
> > 202f000c2000-202f000c3000 r-xp 00000000 00:00 0
> > 202f00102000-202f00103000 r-xp 00000000 00:00 0
> > 202f00142000-202f00143000 r-xp 00000000 00:00 0
> > 202f00182000-202f001bf000 r-xp 00000000 00:00 0
> >
> > Lots of funny looking memory areas which are anonymous and executable!
> > Those didn't come off the disk.  Same thing in firefox.  Weird.  Any
> > idea what those are?
> >
> > One guess: https://en.wikipedia.org/wiki/Just-in-time_compilation
>
> jitted code belongs to a process loaded from disk.  Enable CET in
> an application which uses JIT engine means to also enable CET in
> JIT engine.  Take git as an example, "git grep" crashed for me on Tiger
> Lake.   It turned out that git itself was compiled with -fcf-protection and
> git was linked against libpcre2-8.so.0 also compiled with -fcf-protection,
> which has a JIT, sljit, which was not CET enabled.  git crashed in the
> jitted codes due to missing ENDBR.  I had to enable CET in sljit to make
> git working on CET enabled Tiger Lake.  So we need to enable CET in
> JIT engine before enabling CET in applications which use JIT engine.

This could presumably have been fixed by having libpcre or sljit
disable IBT before calling into JIT code or by running the JIT code in
another thread.  In the other direction, a non-CET libpcre build could
build IBT-capable JITted code and enable JIT (by syscall if we allow
that or by creating a thread?) when calling it.  And IBT has this
fancy legacy bitmap to allow non-instrumented code to run with IBT on,
although SHSTK doesn't have hardware support for a similar feature.

So, sure, the glibc-linked ELF ecosystem needs some degree of CET
coordination, but it is absolutely not the case that a process MUST
have all CET or no CET.  Let's please support the complicated cases in
the kernel and the ABI too.  If glibc wants to make it annoying to do
complicated things, so be it.  People work behind glibc's back all the
time.

--Andy
