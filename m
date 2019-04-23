From: Andy Lutomirski <luto@kernel.org>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
Date: Tue, 23 Apr 2019 11:47:34 -0700
Message-ID: <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 18, 2019 at 1:08 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi.
>
> I have a question about 'vdso_install'.
>
>
> In my understanding, vdso is embedded in the kernel.
> In addition, you can run 'make vdso_install'
> to install an unstripped version of vdso.
> (Mainly, debugging purpose?)
>
> By default, 'make vdso_install' will install it to
> /lib/modules/$(uname -r)/vdso/.
>
>
> Since that directly is owned by root,
> 'make vdso_install' could potentially be
> executed by root, isn't it?
>
>
> Currently, 'vdso_install' depends on vdso,
> so it may cause recompilation of objects
> in the source tree.

Hmm.  I suppose an alternative would be for vdso_install to fail if
the vdso isn't built?

What's the ideal outcome here?
