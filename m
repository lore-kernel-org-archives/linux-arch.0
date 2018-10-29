From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Date: Mon, 29 Oct 2018 10:44:59 +0100
Message-ID: <CAK8P3a2-wyXxctVtJxniUoeShASMhF-6Z1vyvfBnr6wKJuioAQ@mail.gmail.com>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com> <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guo Ren <ren_guo@c-sky.com>, Marc Zyngier <marc.zyngier@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
List-Id: linux-arch.vger.kernel.org

On Sun, Oct 28, 2018 at 10:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Arnd,
>  I was kind of hoping/expecting to get an explicit ack for this from
> you, since it's a new architecture.
>
> Good to merge?

Yes.

For the pull request (in case you want to add it to the merge changelog):

I did a thorough review of the ABI, which as usual mainly consists of spotting
any files that don't use the asm-generic ABI itself, and having it changed to
it matches exactly what we do on other new architectures.

I also looked at every other patch and commented on maybe half of them
where I saw something that did not quite seem right. Others have reviewed
specific patches in greater depth. I'm sure that one could fine more of the
minor details, but as long as they are not ABI relevant, they can be fixed
later.

The only patch that is part of the ABI and that nobody reviewed is the
signal handling. This is one of the areas I never worked on in much detail.
I did not see anything wrong with it, but I also don't know what the problems
with the other architectures are here, and we seem to be hitting issues
occasionally, and we never managed to generalize this enough for new
architectures to have a trivial implementation.

I was originally hoping that we could have the 64-bit time_t interfaces
ready in time to completely drop the 32-bit ones, but that did not
happen. We might still remove them in the next merge window
depending on whether the libc upstream people prefer to keep them
or not.

Acked-by: Arnd Bergmann <arnd@arndb.de>
---
You may note that Guo rebased the series on top of v4.19. I tried
to explain a while ago that it's better not to do that, but I suppose he
was trying to add the last-minute Acks and it seemed like a good idea.

Guo, in the future I recommend to add all patches on top of the latest
-rc1 (or maybe a later -rc) but not rebase them or pull in the mainline
kernel into your own tree.

One more general comment: I think this may well be the last new CPU
architecture we ever add to the kernel. Both nds32 and c-sky are made
by companies that also work on risc-v, and generally speaking risc-v
seems to be killing off any of the minor licensable instruction set projects,
just like ARM has mostly killed off the custom vendor-specific instruction
sets already. If we add another architecture in the future, it may instead
be something like the LLVM bitcode or WebAssembly, who knows?

       Arnd
