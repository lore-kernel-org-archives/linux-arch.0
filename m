From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Date: Tue, 30 Oct 2018 00:22:45 +0800
Message-ID: <20181029162243.GA988@guoren-Inspiron-7460>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
 <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Marc Zyngier <marc.zyngier@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
List-Id: linux-arch.vger.kernel.org

Thx Arnd,

On Mon, Oct 29, 2018 at 10:44:59AM +0100, Arnd Bergmann wrote:
[...]
> Guo, in the future I recommend to add all patches on top of the latest
> -rc1 (or maybe a later -rc) but not rebase them or pull in the mainline
> kernel into your own tree
Ok, I'll follow the rules.   

> 
> One more general comment: I think this may well be the last new CPU
> architecture we ever add to the kernel. Both nds32 and c-sky are made
> by companies that also work on risc-v, and generally speaking risc-v
> seems to be killing off any of the minor licensable instruction set projects,
> just like ARM has mostly killed off the custom vendor-specific instruction
> sets already. If we add another architecture in the future, it may instead
> be something like the LLVM bitcode or WebAssembly, who knows?
 ISA is like a language, we will learn foreign languages, but we will
 not give up our mother tongue. RISC-V is a great ISA, and it will
 promote other ISAs to be more open.

 From ecology, diversity will make Linux more robust.

 We will continue to improve csky subsystem, and now is only the
 beginning.

 Best Regards
  Guo Ren
