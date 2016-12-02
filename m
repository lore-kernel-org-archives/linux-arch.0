From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Fri, 2 Dec 2016 09:04:28 -0800
Message-ID: <CA+55aFxYYKRsimcZsj7fz4paPag6Uqf1M5_v=W2Yv9sSPeLdig@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <2899250.iZaPagXLk8@wuerfel>
 <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com> <14455987.OWjnZpEEup@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Sender: linus971@gmail.com
In-Reply-To: <14455987.OWjnZpEEup@wuerfel>
Resent-Message-ID: <CgKK_gEINTJ.A.m0B.F2aQYB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/CA+55aFxYYKRsimcZsj7fz4paPag6Uqf1M5_v=W2Yv9sSPeLdig@mail.gmail.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 2, 2016 at 2:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Yes, it's always been just the assembly symbols that broke, these were
> the ones that Al's original patch changed and that ended up with
> no version information.

Ok, and the reason is because even if we have a weak symbol from C, it
would always have a value.

Good to know what the heck the problem was.

> I have managed to bisect the link failure to a specific binutils
> commit by Alan Modra now:

Thanks. And I committed your "set to zero" patch, so we can hopefully
leave this all behind us.

I marked it for stable (not because older kernels need it, but because
it's the right thing to do and if we ever backport anything that
causes this we don't want to forget this).

And I'll keep the workaround in kernel/module.c just because it's
really late in the rc series, and I'd rather have both belt and
suspenders for this all right now.

               Linus
