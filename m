From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: remove asm-generic/ptrace.h v3
Date: Mon, 1 Jul 2019 17:40:57 +0200
Message-ID: <CAK8P3a3YHstHAs9OsWNHTtXjHnWtQfqr=WUZTpK+bONLTWLj+w@mail.gmail.com>
References: <20190624054728.30966-1-hch@lst.de> <alpine.DEB.2.21.1906240922420.32342@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1906240922420.32342@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 24, 2019 at 9:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 24 Jun 2019, Christoph Hellwig wrote:
> >
> > asm-generic/ptrace.h is a little weird in that it doesn't actually
> > implement any functionality, but it provided multiple layers of macros
> > that just implement trivial inline functions.  We implement those
> > directly in the few architectures and be off with a much simpler
> > design.
> >
> > I'm not sure which tree is the right place, but may this can go through
> > the asm-generic tree since it removes an asm-generic header?
>
> Makes sense.

Applied and pushed to asm-generic.git/master now, sorry for the delay.

     Arnd
