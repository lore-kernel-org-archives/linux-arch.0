From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
Date: Tue, 12 Feb 2019 15:36:04 +0100
Message-ID: <CAK8P3a1=LdgyzbgMYfppZQZsKPJ1uCkKMAXQTYuMcXiyZpCCRg@mail.gmail.com>
References: <1549861699-11875-1-git-send-email-guoren@kernel.org> <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guo Ren <guoren@kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 11, 2019 at 7:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
> >
> > arch/csky patches for 5.0-rc6
>
> The bulk of this seems to be new hardware support code.
>
> Please send it during the 5.1 merge window, not as fixes at post-rc6 time.

Aside from this, I also noticed that the new code is for drivers/irqchip,
which is a separate subsystems with its own maintainers, who were
neither on Cc nor did they Ack the patches.

Generally, those should get merged through the respective subsystem
trees as listed in the linux/MAINTAINERS file.


      Arnd
