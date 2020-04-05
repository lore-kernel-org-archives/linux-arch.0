From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH 0/9] Enable orphan section warning
Date: Sun, 5 Apr 2020 13:15:01 +0200
Message-ID: <CA+icZUXi_iA7XkTEbrK7b6m673iG9qPKnDBE1V0JRywDLBc9jw@mail.gmail.com>
References: <20200228002244.15240-1-keescook@chromium.org> <CA+icZUWTnP8DYfbaMwKtJbG30v7bB4w6=ywo8gn8fvwr731mUQ@mail.gmail.com>
 <202004021023.D3D8AA3BE@keescook>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <202004021023.D3D8AA3BE@keescook>
Sender: linux-kbuild-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 2, 2020 at 7:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Apr 02, 2020 at 06:20:57PM +0200, Sedat Dilek wrote:
> > On Fri, Feb 28, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Hi!
> > >
> > > A recent bug was solved for builds linked with ld.lld, and tracking
> > > it down took way longer than it needed to (a year). Ultimately, it
> > > boiled down to differences between ld.bfd and ld.lld's handling of
> > > orphan sections. Similarly, the recent FGKASLR series brough up orphan
> > > section handling too[2]. In both cases, it would have been nice if the
> > > linker was running with --orphan-handling=warn so that surprise sections
> > > wouldn't silently get mapped into the kernel image at locations up to
> > > the whim of the linker's orphan handling logic. Instead, all desired
> > > sections should be explicitly identified in the linker script (to be
> > > either kept or discarded) with any orphans throwing a warning. The
> > > powerpc architecture actually already does this, so this series seeks
> > > to extend this coverage to x86, arm64, and arm.
> > >
> > > This series depends on tip/x86/boot (where recent .eh_frame fixes[3]
> > > landed), and has a minor conflict[4] with the ARM tree (related to
> > > the earlier mentioned bug). As it uses refactorings in the asm-generic
> > > linker script, and makes changes to kbuild, I think the cleanest place
> > > for this series to land would also be through -tip. Once again (like
> > > my READ_IMPLIES_EXEC series), I'm looking to get maintainer Acks so
> > > this can go all together with the least disruption. Splitting it up by
> > > architecture seems needlessly difficult.
> > >
> > > Thanks!
> > >
> >
> > Hi Kees,
> >
> > what is the status of this patchset?
> > Looks like it is not in tip or linux-next Git.
>
> Based on the feedback, I have 3 TODO items:
>
> - track down and eliminate (or explain) the source of the .got.plt on arm64
> - enable orphan warnings for _all_ architectures
> - refactor final link logic to perform the orphan warning in a clean way
>
> I'm working through these (and other work) still. I'm hoping to have
> another version up some time next week.
>

Please CC when possible with a pointer to a git-link.

Thanks.

- sed@ -
