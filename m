From: "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 16:51:33 -0700
Message-ID: <CAMe9rOrxM=RefftngNXhP906mrW1SMy7vp+O=yOj_WwcdQpGcg@mail.gmail.com>
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net> <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com> <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
 <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com> <CAMe9rOrzrXORQgcAwzGn+=PBvxCEgc5Km_TQq+P7uoqwiacJSA@mail.gmail.com>
 <c06073a2-6858-d5dc-d74b-ef2568bd9423@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c06073a2-6858-d5dc-d74b-ef2568bd9423-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet@lwn.>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 9, 2020 at 4:21 PM Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> On 3/9/20 4:11 PM, H.J. Lu wrote:
> > A threaded application is loaded from disk.  The object file on disk is
> > either CET enabled or not CET enabled.
>
> Huh.  Are you saying that all instructions executed on userspace on
> Linux come off of object files on the disk?  That's an interesting
> assertion.  You might want to go take a look at the processes on your
> systems.  Here's my browser for example:
>
> # for p in $(ps aux | grep chromium | awk '{print $2}' ); do cat
> /proc/$p/maps; done | grep ' r-xp 00000000 00:00 0'
> ...
> 202f00082000-202f000bf000 r-xp 00000000 00:00 0
> 202f000c2000-202f000c3000 r-xp 00000000 00:00 0
> 202f00102000-202f00103000 r-xp 00000000 00:00 0
> 202f00142000-202f00143000 r-xp 00000000 00:00 0
> 202f00182000-202f001bf000 r-xp 00000000 00:00 0
>
> Lots of funny looking memory areas which are anonymous and executable!
> Those didn't come off the disk.  Same thing in firefox.  Weird.  Any
> idea what those are?
>
> One guess: https://en.wikipedia.org/wiki/Just-in-time_compilation

jitted code belongs to a process loaded from disk.  Enable CET in
an application which uses JIT engine means to also enable CET in
JIT engine.  Take git as an example, "git grep" crashed for me on Tiger
Lake.   It turned out that git itself was compiled with -fcf-protection and
git was linked against libpcre2-8.so.0 also compiled with -fcf-protection,
which has a JIT, sljit, which was not CET enabled.  git crashed in the
jitted codes due to missing ENDBR.  I had to enable CET in sljit to make
git working on CET enabled Tiger Lake.  So we need to enable CET in
JIT engine before enabling CET in applications which use JIT engine.


-- 
H.J.
