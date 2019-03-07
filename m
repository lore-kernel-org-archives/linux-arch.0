From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] signal: fix building with clang
Date: Thu, 7 Mar 2019 22:45:27 +0100
Message-ID: <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com> <20190307164647.GC25101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307164647.GC25101@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 7, 2019 at 5:46 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 03/07, Arnd Bergmann wrote:
> >
> > We could use % everywhere,
>
> Yes.
>
> But again, why not simply use the "for (;;)" loops? Why we can't kill the
> supid switch(_NSIG_WORDS) tricks altogether?

I'd have to try, but I think you are right. It was probably an
overoptimization back in 1997 when the code got added to
linux-2.1.68pre1, and compilers have become smarter in the
meantime ;-)

Also, the common case these days is _NSIG_WORDS==1, which
is true on all 64-bit architectures other than MIPS64.

      Arnd
