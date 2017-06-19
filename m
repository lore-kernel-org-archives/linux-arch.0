From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Mon, 19 Jun 2017 18:27:14 +1000
Message-ID: <20170619182714.2cb60e17@roar.ozlabs.ibm.com>
References: <20170609052417.561-1-npiggin@gmail.com>
        <20170609052417.561-2-npiggin@gmail.com>
        <CAK7LNASxuE-6eMk+Y-vyrMfibtYoD2JkjNS2z8QF85x9NdiiaA@mail.gmail.com>
        <20170619165100.3ce26d00@roar.ozlabs.ibm.com>
        <CAK7LNARuuQzGkYBdzoy3bVpBuNPZEMGerHSEdmrH+PqK0Gbyzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CAK7LNARuuQzGkYBdzoy3bVpBuNPZEMGerHSEdmrH+PqK0Gbyzg@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Mon, 19 Jun 2017 17:14:22 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Nicholas,
> 
> 
> 2017-06-19 15:51 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > On Mon, 19 Jun 2017 15:16:17 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >  
> >> Hi Nicholas,
> >>
> >>
> >> 2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:  
> >> > Close the --whole-archives option with --no-whole-archive. Some
> >> > architectures end up including additional .o and files multiple
> >> > times after this, and they get duplicate symbols when they are
> >> > brought under the --whole-archives option.  
> >>
> >> Which architectures have additional files after --no-whole-archive ?
> >>
> >> I see this case only for ARCH = "um" in vmlinux_link()
> >> where it adds some -l* options after --no-whole-archive.
> >>
> >> I think it is good to close the --whole-archives everywhere.
> >> So, the code looks OK to me, but I just wondered about the log.  
> >
> > Actually a number of archs seemed to get build errors without this,
> > and they seem to come from libgcc perhaps.
> >
> > binfmt_elf.c:(.text+0x4851): undefined reference to `__kernel_syscall_via_epc'
> > /c/gcc/libgcc/libgcc2.c:1318: multiple definition of `__ucmpdi2'
> > /c/gcc/libgcc/libgcc2.c:405: multiple definition of `__lshrdi3'
> > /c/gcc/libgcc/libgcc2.c:433: multiple definition of `__ashldi3'
> > /c/gcc/libgcc/libgcc2.c:461: multiple definition of `__ashrdi3'
> >
> > /home/tony/buildall/src/gcc/libgcc/config/xtensa/lib2funcs.S:36: multiple definition of `__xtensa_libgcc_window_spill'
> >
> > etc  
> 
> 
> Oops, I did not test such architectures.
> 
> 
> > m32r, parisc, xtensa seemed to be getting such errors. I wonder if
> > the linker implicitly adds some runtime libs at the end that get
> > caught up here. Either way I didn't look too far into it because this
> > fix seems obviously correct and solved the problem.
> >
> > Thanks,  
> 
> 
> Which toolchains do you use?

I just had them run through the kbuild 0day tests. Not sure exactly
what they use.

> I downloaded xtensa-linux- from this site:
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/
> 
> 
> I see a different error for xtensa.
> 
> 
> I applied all of you 5 patches, but xtensa build still fails.
> 
>   LD      vmlinux.o
> xtensa-linux-ld: internal error
> /home/tony/buildall/src/binutils/ld/ldlang.c 6178
> 
> 
> Could you check it?

Ahh, the old ld: internal error... what ld version is that?

Thanks,
Nick
