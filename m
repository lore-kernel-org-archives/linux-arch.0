From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
Date: Wed, 17 Jul 2019 09:57:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de> <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Mike Lothian <mike@fireburn.co.uk>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 17 Jul 2019, Masahiro Yamada wrote:
> On Wed, Jul 17, 2019 at 4:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > So instead of dealing with attempts to duct tape gold support without
> > understanding the root cause and without support from the gold folks, fail
> > the build when gold is detected.
> >
> 
> The code looks OK in the build system point of view.
> 
> Please let me confirm this, just in case:
> For now, we give up all architectures, not only x86, right?

Well, that's the logical consequence of a statement which says: don't use
gold for the kernel.

> I have not not heard much from other arch maintainers.

Cc'ed linux-arch for that matter.

Thanks,

	tglx
