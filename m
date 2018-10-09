From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v3 3/6] parisc: add system call table generation support
Date: Tue, 9 Oct 2018 19:40:46 +0530
Message-ID: <CALxhOnip15ztzMed59M3eKOdqdLJ2y8Yi5OGF3v__zApHzJkBQ@mail.gmail.com>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-4-git-send-email-firoz.khan@linaro.org> <CALxhOnj4r_MUuAa2zvkvxvhQttEvCZ98n2dA9d6CYyvVf2rB3g@mail.gmail.com>
 <20181008130301.GM32759@asgard.redhat.com> <CAK8P3a0eoCVBVOZs0VwybAnUw0OUoW4Z=NJYi8686EHKj076_Q@mail.gmail.com>
 <CALxhOniJZGNCP+Xw_9EF8hnUEG_AWwrnQ86Gbh7vAW6SrE8ykQ@mail.gmail.com>
 <CAK8P3a0D+GUzza--ETrT1NHGduTfFGVoCcSEn5LxvKTtMYisbA@mail.gmail.com>
 <CALxhOnhCRWsuz-2G-SovjfqkXpsRdTrG5Atz2X8s+T8u=GbUcA@mail.gmail.com> <CAK8P3a343PoH9WNH5ZYkNDTy=-ybGGsmvH9PbaSMmNo0Yob5eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a343PoH9WNH5ZYkNDTy=-ybGGsmvH9PbaSMmNo0Yob5eA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: esyr@redhat.com, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Tue, 9 Oct 2018 at 16:58, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 9, 2018 at 11:36 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Tue, 9 Oct 2018 at 13:18, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Oct 9, 2018 at 7:35 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > > On Mon, 8 Oct 2018 at 19:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > Let me bring another example from powerpc:
> >
> > syscall_32.tbl,
> > 136     common  personality                     sys_personality
> >          ppc64_personality   ---> 32-bit, compat (this is the current
> > model which I implemented)
> > syscall_64.tbl
> > 136     common  personality                     ppc64_personality
> >                                        ---> 64-bit
> >
> > I was wondering if the above table is right, how to arrange like parisc model?
>
> I think this should simply be
>
> 136    32 personality sys_personality      ppc64_personality
> 136    64 personality ppc64_personality
>
> Keeping the contents exactly the same as you have them
> in the separate .tbl files, just merging the two files, and
> splitting out the differences as 32/64 ABI.
>
> > FYI, there are some implement missing for SPU in powerpc
> >
> > For your reference:
> > SYSX_SPU(sys_newfstatat,sys_fstatat64,sys_fstatat64)
> > SYSX_SPU(ppc64_personality,ppc64_personality,sys_personality)
>
> This is a good question. The only difference between SPU and
> native 64-bit is that some syscalls are not part of the SPU table
> because those syscalls are impossible to implement on SPU.
>
> Maybe we can solve this by allowing multiple comma-separated
> ABIs in the table. On powerpc, 'common' would then mean
> '32-bit, 64-bit and spu', while you could have various other
> combinations:
>
> /* always:32, 64 and SPU */
> 1 common exit sys_exit
>
> /* 32-bit only call */
> 76  32    getrlimit      sys_old_getrlimit     compat_sys_old_getrlimit
>
> /* 64-bit only, no SPU */
> 363 64 switch_endian  sys_switch_endian
>
> /* 32-bit and 64-bit, no SPU */
> 198 32,64 pciconfig_read  sys_pciconfig_read
>
> /* different pointers */
> 136    32 personality sys_personality      ppc64_personality
> 136    64,spu personality ppc64_personality
>
> Would that work for you?

At this point, yes. V2 patches for powerpc on my pipeline. I can bring
the above points when I start creating those patches.

Thanks
Firoz
>
>        Arnd
