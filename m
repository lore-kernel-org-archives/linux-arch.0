From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Fri, 26 Aug 2016 21:17:29 +1000
Message-ID: <20160826211729.592ff5cd@roar.ozlabs.ibm.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160824190530.5b67b356@roar.ozlabs.ibm.com>
 <20160824205646.4d6170e1@roar.ozlabs.ibm.com>
 <2147968.tzghefjZMo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2147968.tzghefjZMo@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>, linux-kbuild@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Julian Brown <julian@codesourcery.com>, Michal Marek <mmarek@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, 24 Aug 2016 17:01:30 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday, August 24, 2016 8:56:46 PM CEST Nicholas Piggin wrote:
> > On Wed, 24 Aug 2016 19:05:30 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > Thanks, I'll take a look.  
> > 
> > Okay, I can't reproduce your bad linking times even with gc-sections. It's
> > possible I'm doing something wrong, but with my patches + your patch and
> > standard arm allyesconfig:
> > 
> >   20:33:56  AR      built-in.o
> >   20:33:57  LD      vmlinux.o
> >   MODPOST vmlinux.o
> >   20:34:12  GEN     .version
> >   CHK     include/generated/compile.h
> >   UPD     include/generated/compile.h
> >   CC      init/version.o
> >   AR      init/built-in.o
> >   20:34:24  KSYM    .tmp_kallsyms1.o
> >   20:34:45  KSYM    .tmp_kallsyms2.o
> >   20:34:54  LD      vmlinux
> >   20:35:07  SORTEX  vmlinux
> >   20:35:07  SYSMAP  System.map
> > 
> > I have about 71 seconds for the final link phase.  
> 
> 
> I've tracked down my remaining build time regression to
> a bad binutils snapshot (2.26.51) I had been using, and upgraded
> to the 2.27 release now, which is roughly the same as what
> you have:
> 
> 14:45:41   LINK    vmlinux
> 14:45:41  AR      built-in.o
> 14:45:42  LD      vmlinux.o
> 14:51:49   MODPOST vmlinux.o
> 14:51:51  GEN     .version
> 14:51:51   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
> 14:51:51   CC      init/version.o
> 14:51:52   AR      init/built-in.o
> 14:52:04  KSYM    .tmp_kallsyms1.o
> 14:52:31  KSYM    .tmp_kallsyms2.o
> 14:52:43  LD      vmlinux
> 14:52:55  SORTEX  vmlinux
> 14:52:55  SYSMAP  System.map
> 14:52:56   OBJCOPY arch/arm/boot/Image
> 
> The long minutes that were spent in "arm-linux-gnueabi-ld 
> -r -o vmlinux.o --whole-archive built-in.o" are all gone now.

Thanks for tracking it down, that's good to hear.


> I still see a problem with big-endian builds failing with
> thinarc/gc-sections, I'll investigate that some other day,
> or you could have a look at that if you want to make sure
> it's an ARM specific problem, not something with your
> patches in general.
> 
> The patch that I sent for enabling the two on ARM blocks
> out CONFIG_CPU_BIG_ENDIAN, so just revert that hunk to see
> the problem. It's possible that it only breaks when doing
> a big-endian build after a little-endian build without
> a "make clean" inbetween.

I'm able to build big endian ARM allyesconfig with thin
archives and gc-sections, worked fine.

There have been a few bugs in powerpc when failing to notice
the change when endian of builds was swapped, so maybe you
got bitten by something similar.

Thanks,
Nick
