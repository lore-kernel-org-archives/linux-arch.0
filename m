From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] kbuild: Fail if gold linker is detected
Date: Sat, 20 Jul 2019 11:34:27 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1907201133000.1782@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de> <20190716170606.GA38406@archlinux-threadripper> <alpine.DEB.2.21.1907162059200.1767@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907162135590.1767@nanos.tec.linutronix.de>
 <CAK7LNASBiaMX8ihnmhLGmYfHX=ZHZmVN91nxmFZe-OCaw6Px2w@mail.gmail.com> <alpine.DEB.2.21.1907170955250.1767@nanos.tec.linutronix.de> <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHbf0-GyQzWcRg_BP2B5pVzEJoxSE_hX5xFypS--7Q5LSHxzWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Nathan Chancellor <natechancellor@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, 20 Jul 2019, Mike Lothian wrote:
> On Wed, 17 Jul 2019 at 08:57, Thomas Gleixner <tglx@linutronix.de> wrote:
> I've done a bit more digging, I had a second machine that was building
> Linus's tree just fine with ld.gold
> 
> I tried forcing ld.bfd on the problem machine and got this:
> 
> ld.bfd: arch/x86/boot/compressed/head_64.o: warning: relocation in
> read-only section `.head.text'
> ld.bfd: warning: creating a DT_TEXTREL in object
> 
> I had a look at the differences in the kernel configs and noticed this:
> 
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x1000000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
> 
> Unsetting CONFIG_RANDOMIZE_BASE=y gets things working for me with ld.gold again

Can you please provide the full config? I have the above set here and it
builds just fine.

> In light of this - can we drop this patch?

No. I'm not going to deal with unsupported tools.

Thanks,

	tglx
