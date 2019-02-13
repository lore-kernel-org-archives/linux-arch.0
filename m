From: Guo Ren <guoren@kernel.org>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
Date: Wed, 13 Feb 2019 09:45:04 +0800
Message-ID: <20190213014400.GA9895@guoren-Inspiron-7460>
References: <1549861699-11875-1-git-send-email-guoren@kernel.org>
 <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
 <CAK8P3a1=LdgyzbgMYfppZQZsKPJ1uCkKMAXQTYuMcXiyZpCCRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1=LdgyzbgMYfppZQZsKPJ1uCkKMAXQTYuMcXiyZpCCRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 12, 2019 at 03:36:04PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 11, 2019 at 7:28 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
> > >
> > > arch/csky patches for 5.0-rc6
> >
> > The bulk of this seems to be new hardware support code.
> >
> > Please send it during the 5.1 merge window, not as fixes at post-rc6 time.
> 
> Aside from this, I also noticed that the new code is for drivers/irqchip,
> which is a separate subsystems with its own maintainers, who were
> neither on Cc nor did they Ack the patches.
Yes, there are:
	dt-bindings: csky,apb-intc: Add vector irq mode
	irqchip/csky: Add support-vector-irq for apb-intc
	irqchip/csky: Optimize remove unnecessary loop irq handle
	irqchip/irq-csky-mpintc: Add triger type and priority
	dt-bindings: interrupt-controller: Update csky mpintc

I just send these patches to the mail-list before, but not get Ack. I'll add
Cc in these patches and resend them to the mail list.

> 
> Generally, those should get merged through the respective subsystem
> trees as listed in the linux/MAINTAINERS file.
Ok, I'll remove them in this pull request.

Best Regards
 Guo Ren
