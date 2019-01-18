Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr770115.outbound.protection.outlook.com ([40.107.77.115]:47456
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728644AbfARSjv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Jan 2019 13:39:51 -0500
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v5 07/17] fanotify: encode file identifier for
 FAN_REPORT_FID
Date: Fri, 18 Jan 2019 18:39:40 +0000
Message-ID: <20190118183939.tasdhobwtqxkjukm@pburton-laptop>
References: <20190110170444.30616-8-amir73il@gmail.com>
 <201901111612.XzUbwDyo%fengguang.wu@intel.com>
 <CAOQ4uxg+Zk74XqPMNmrEpR13Wr9r=8osOrHVAhH1De9UMFmRoQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+Zk74XqPMNmrEpR13Wr9r=8osOrHVAhH1De9UMFmRoQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35826B42C5E440459811D11F6AC6B7FC@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, "kbuild-all@01.org" <kbuild-all@01.org>, Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Hi Amir,

On Fri, Jan 11, 2019 at 10:37:39AM +0200, Amir Goldstein wrote:
> On Fri, Jan 11, 2019 at 10:11 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Amir,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v5.0-rc1]
> > [if your patch is applied to the wrong git tree, please drop us a note =
to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Amir-Goldstein/fanotif=
y-add-support-for-more-event-types/20190111-090241
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=3D7.2.0 make.cross ARCH=3Dmips
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/kernel.h:14:0,
> >                     from include/linux/list.h:9,
> >                     from include/linux/preempt.h:11,
> >                     from include/linux/spinlock.h:51,
> >                     from include/linux/fdtable.h:11,
> >                     from fs/notify/fanotify/fanotify.c:3:
> >    fs/notify/fanotify/fanotify.c: In function 'fanotify_encode_fid':
> >    include/linux/kern_levels.h:5:18: warning: format '%x' expects argum=
ent of type 'unsigned int', but argument 2 has type 'long int' [-Wformat=3D=
]
>=20
> I'm confused.
> __kernel_fsid_t val member is long[] on mips arch and int[] on other arch=
s.
> Which format specifier am I supposed to use to print it?

That's a good question.

Here's another: why on Earth do we have this custom __kernel_fsid_t
definition for MIPS at all..?

We only provide the MIPS definition when _MIPS_SZLONG =3D=3D 32, ie. when
long is the same size as int & the generic definition of the struct
would have an identical memory layout anyway.

So I'm tempted to just delete this weird code - the only thing that
might break is if someone is doing something that really expects a long
& cares about getting an int of the same size. For example if anyone
prints the value with %lx or the like - essentially the opposite case to
yours.

I consider it pretty unlikely that anyone will be doing this in a
MIPS32-specific codepath such that they've been seeing the custom
__kernel_fsid_t up until now, but does anyone see a problem with this?

Thanks,
    Paul

---
diff --git a/arch/mips/include/uapi/asm/posix_types.h b/arch/mips/include/u=
api/asm/posix_types.h
index 6aa49c10f88f..f0ccb5b90ce9 100644
--- a/arch/mips/include/uapi/asm/posix_types.h
+++ b/arch/mips/include/uapi/asm/posix_types.h
@@ -21,13 +21,6 @@
 typedef long		__kernel_daddr_t;
 #define __kernel_daddr_t __kernel_daddr_t

-#if (_MIPS_SZLONG =3D=3D 32)
-typedef struct {
-	long	val[2];
-} __kernel_fsid_t;
-#define __kernel_fsid_t __kernel_fsid_t
-#endif
-
 #include <asm-generic/posix_types.h>

 #endif /* _ASM_POSIX_TYPES_H */
