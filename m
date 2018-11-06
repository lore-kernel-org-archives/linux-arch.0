From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v2 0/5] alpha: system call table generation support
Date: Tue, 6 Nov 2018 09:42:21 +0530
Message-ID: <CALxhOnjYVVC7-_h8975OLKZg4x8ApgfG4EaxmGy3HLFiLCcdGw@mail.gmail.com>
References: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org> <CAEdQ38FckCWguy5MUYkjwhmc3eA30WXB5QNGaU2Yv8gjHvGc=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEdQ38FckCWguy5MUYkjwhmc3eA30WXB5QNGaU2Yv8gjHvGc=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Matt,

On Tue, 6 Nov 2018 at 03:01, Matt Turner <mattst88@gmail.com> wrote:
>
> On Thu, Nov 1, 2018 at 6:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
> >
> > The system call tables are in different format in
> > all architecture. It will be difficult to manually
> > add, modify or delete the system calls in the resp-
> > ective files manually. To make it easy by keeping a
> > script and which'll generate uapi header file and
> > syscall table file.
> >
> > syscall.tbl contains the list of available system
> > calls along with system call number and correspond-
> > ing entry point. Add a new system call in this arch-
> > itecture will be possible by adding new entry in the
> > syscall.tbl file.
>
> Sounds like a worthy goal.

Thanks! This is Arnd's idea to come up with a common script
for all the architecture. This implementation is a groundwork to
solve Y2038 issue.

>
> I tried applying the patches and it seems they haven't been rebased
> since v4.18. My rebases are in
> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git/log/?h=for-linus

I was rebased with 4.19-rc8 before sending v2 (what I remember).

>
> They seem to work for me, FWIW.
>
> Is your plan to have the patches go through the separate architecture
> trees, or go in together? I think I'd at least prefer for another
> architecture to take the plunge before alpha.

I would like Arnd's to comment on this as it is my first patch series. As I
mentioned in the cover letter this implementation done for 8 architecture-
alpha, ia64, m68k, microblaze, parisc, sh, sparc, and xtensa. Most of the
review are also done. mips and powerpc are *almost* completed. FYI,
The system call table generation script for IA64 merged in linux-next.

Firoz
