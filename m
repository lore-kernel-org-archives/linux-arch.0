Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr740091.outbound.protection.outlook.com ([40.107.74.91]:51795
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727664AbfFXSmM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 14:42:12 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Date: Mon, 24 Jun 2019 18:41:59 +0000
Message-ID: <20190624184157.mu6n74a7qqa4z5z5@pburton-laptop>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64025CA1F21A8D4AB537FC251ED3392D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>, Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20190624184159.Tklkyqfz1V_SRZRrvSSh630RJbjcM8rv1HskGwD9Ozo@z>

Hello,

On Mon, Jun 24, 2019 at 02:34:24AM +0200, Thomas Gleixner wrote:
> I did not merge the ARM and MIPS parts as they lack any form of
> acknowlegment from their maintainers. Please talk to those folks. If they
> ack/review the changes then I can pick them up and they go into 5.3 or th=
ey
> have to go in a later cycle. Nevertheless it was well worth the trouble t=
o
> have those conversions done to confirm that the new common library fits a
> bunch of different architectures.

Apologies for not being more proactive on the MIPS front here; life &
work are extra busy at the moment... But thanks Vincenzo for including
MIPS in the work here.

Unfortunately after applying the 3 MIPS patches (19-21) atop the current
tip.git timers/vdso branch at ecf9db3d1f1a ("x86/vdso: Give the
[ph]vclock_page declarations real types") I see build failures for the
o32 compat VDSO, shown below. This is using the gcc 8.1.0 mips-linux
toolchain from here:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.=
0/x86_64-gcc-8.1.0-nolibc-mips-linux.tar.xz

Configuration is 64r6el_defconfig. The following helps remove the
implicit declaration warnings (and eww to including C files via CFLAGS),
but it still doesn't build:

  diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
  index 95df49402a53..aa38049bdb24 100644
  --- a/arch/mips/vdso/Makefile
  +++ b/arch/mips/vdso/Makefile
  @@ -36,6 +36,8 @@ aflags-vdso :=3D $(ccflags-vdso) \
 =20
   ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o =3D -include $(c-gettimeofday-y)
  +CFLAGS_vgettimeofday-o32.o =3D -include $(c-gettimeofday-y)
  +CFLAGS_vgettimeofday-n32.o =3D -include $(c-gettimeofday-y)
   endif

 CFLAGS_REMOVE_vgettimeofday.o =3D -pg

So the MIPS bits here need more work.

Thanks,
    Paul

  CC      arch/mips/vdso/vgettimeofday-o32.o
In file included from ./include/linux/bitops.h:19,
                 from ./include/linux/kernel.h:12,
                 from ./include/linux/list.h:9,
                 from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from arch/mips/vdso/vgettimeofday.c:10:
./arch/mips/include/asm/bitops.h: In function '__fls':
./arch/mips/include/asm/bitops.h:518:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << 32))) {
                     ^~
./arch/mips/include/asm/bitops.h:520:8: warning: left shift count >=3D widt=
h of type [-Wshift-count-overflow]
   word <<=3D 32;
        ^~~
./arch/mips/include/asm/bitops.h:523:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
                     ^~
./arch/mips/include/asm/bitops.h:527:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
                     ^~
./arch/mips/include/asm/bitops.h:531:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
                     ^~
./arch/mips/include/asm/bitops.h:535:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
                     ^~
./arch/mips/include/asm/bitops.h:539:21: warning: left shift count >=3D wid=
th of type [-Wshift-count-overflow]
  if (!(word & (~0ul << (BITS_PER_LONG-1))))
                     ^~
In file included from ./arch/mips/include/asm/mmiowb.h:5,
                 from ./include/linux/spinlock.h:60,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from arch/mips/vdso/vgettimeofday.c:10:
./arch/mips/include/asm/io.h: In function 'phys_to_virt':
./arch/mips/include/asm/io.h:136:9: warning: cast to pointer from integer o=
f different size [-Wint-to-pointer-cast]
  return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
         ^
In file included from ./include/linux/bitops.h:5,
                 from ./include/linux/kernel.h:12,
                 from ./include/linux/list.h:9,
                 from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from arch/mips/vdso/vgettimeofday.c:10:
./arch/mips/include/asm/mips-cm.h: In function 'mips_cm_max_vp_width':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_G=
CR_REV_MAJOR'
   (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:161:23: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3    CM_ENCODE_REV(8, 0)
                       ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:367:28: note: in expansion of macro 'CM_R=
EV_CM3'
  if (mips_cm_revision() >=3D CM_REV_CM3)
                            ^~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MINOR   GENMASK(7, 0)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_G=
CR_REV_MINOR'
    ((minor) << __ffs(CM_GCR_REV_MINOR)))
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:161:23: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3    CM_ENCODE_REV(8, 0)
                       ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:367:28: note: in expansion of macro 'CM_R=
EV_CM3'
  if (mips_cm_revision() >=3D CM_REV_CM3)
                            ^~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:239:36: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_SYS_CONFIG2_MAXVPW  GENMASK(3, 0)
                                    ^~~~~~~
./arch/mips/include/asm/mips-cm.h:368:35: note: in expansion of macro 'CM_G=
CR_SYS_CONFIG2_MAXVPW'
   return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW;
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cm.h:376:32: note: in expansion of macro 'CM_G=
CR_Cx_CONFIG_PVPE'
   cfg =3D read_gcr_cl_config() & CM_GCR_Cx_CONFIG_PVPE;
                                ^~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cm.h:377:24: note: in expansion of macro 'CM_G=
CR_Cx_CONFIG_PVPE'
   return (cfg >> __ffs(CM_GCR_Cx_CONFIG_PVPE)) + 1;
                        ^~~~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numclusters':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_G=
CR_REV_MAJOR'
   (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:117:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5)
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MINOR   GENMASK(7, 0)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_G=
CR_REV_MINOR'
    ((minor) << __ffs(CM_GCR_REV_MINOR)))
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:117:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5)
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:133:37: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_NUM_CLUSTERS  GENMASK(29, 23)
                                     ^~~~~~~
./arch/mips/include/asm/mips-cps.h:120:37: note: in expansion of macro 'CM_=
GCR_CONFIG_NUM_CLUSTERS'
  num_clusters =3D read_gcr_config() & CM_GCR_CONFIG_NUM_CLUSTERS;
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:133:37: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_NUM_CLUSTERS  GENMASK(29, 23)
                                     ^~~~~~~
./arch/mips/include/asm/mips-cps.h:121:25: note: in expansion of macro 'CM_=
GCR_CONFIG_NUM_CLUSTERS'
  num_clusters >>=3D __ffs(CM_GCR_CONFIG_NUM_CLUSTERS);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_cluster_config':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_G=
CR_REV_MAJOR'
   (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:137:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5) {
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MINOR   GENMASK(7, 0)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_G=
CR_REV_MINOR'
    ((minor) << __ffs(CM_GCR_REV_MINOR)))
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:137:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5) {
                           ^~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numcores':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:135:32: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_PCORES   GENMASK(7, 0)
                                ^~~~~~~
./arch/mips/include/asm/mips-cps.h:172:50: note: in expansion of macro 'CM_=
GCR_CONFIG_PCORES'
  return (mips_cps_cluster_config(cluster) + 1) & CM_GCR_CONFIG_PCORES;
                                                  ^~~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numiocu':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:134:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_NUMIOCU   GENMASK(15, 8)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cps.h:189:48: note: in expansion of macro 'CM_=
GCR_CONFIG_NUMIOCU'
  num_iocu =3D mips_cps_cluster_config(cluster) & CM_GCR_CONFIG_NUMIOCU;
                                                ^~~~~~~~~~~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:134:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_CONFIG_NUMIOCU   GENMASK(15, 8)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cps.h:190:21: note: in expansion of macro 'CM_=
GCR_CONFIG_NUMIOCU'
  num_iocu >>=3D __ffs(CM_GCR_CONFIG_NUMIOCU);
                     ^~~~~~~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h: In function 'mips_cps_numvps':
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:152:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MAJOR   GENMASK(15, 8)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:156:22: note: in expansion of macro 'CM_G=
CR_REV_MAJOR'
   (((major) << __ffs(CM_GCR_REV_MAJOR)) | \
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:216:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5) {
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:153:28: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_REV_MINOR   GENMASK(7, 0)
                            ^~~~~~~
./arch/mips/include/asm/mips-cm.h:157:22: note: in expansion of macro 'CM_G=
CR_REV_MINOR'
    ((minor) << __ffs(CM_GCR_REV_MINOR)))
                      ^~~~~~~~~~~~~~~~
./arch/mips/include/asm/mips-cm.h:162:25: note: in expansion of macro 'CM_E=
NCODE_REV'
 #define CM_REV_CM3_5    CM_ENCODE_REV(9, 0)
                         ^~~~~~~~~~~~~
./arch/mips/include/asm/mips-cps.h:216:27: note: in expansion of macro 'CM_=
REV_CM3_5'
  if (mips_cm_revision() < CM_REV_CM3_5) {
                           ^~~~~~~~~~~~
./include/linux/bits.h:20:39: warning: right shift count >=3D width of type=
 [-Wshift-count-overflow]
  (((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
                                       ^~
./arch/mips/include/asm/mips-cm.h:293:33: note: in expansion of macro 'GENM=
ASK'
 #define CM_GCR_Cx_CONFIG_PVPE   GENMASK(9, 0)
                                 ^~~~~~~
./arch/mips/include/asm/mips-cps.h:233:21: note: in expansion of macro 'CM_=
GCR_Cx_CONFIG_PVPE'
  return (cfg + 1) & CM_GCR_Cx_CONFIG_PVPE;
                     ^~~~~~~~~~~~~~~~~~~~~
arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_gettime':
arch/mips/vdso/vgettimeofday.c:17:9: error: implicit declaration of functio=
n '__cvdso_clock_gettime32'; did you mean '__vdso_clock_gettime'? [-Werror=
=3Dimplicit-function-declaration]
  return __cvdso_clock_gettime32(clock, ts);
         ^~~~~~~~~~~~~~~~~~~~~~~
         __vdso_clock_gettime
arch/mips/vdso/vgettimeofday.c: In function '__vdso_gettimeofday':
arch/mips/vdso/vgettimeofday.c:23:9: error: implicit declaration of functio=
n '__cvdso_gettimeofday'; did you mean '__vdso_gettimeofday'? [-Werror=3Dim=
plicit-function-declaration]
  return __cvdso_gettimeofday(tv, tz);
         ^~~~~~~~~~~~~~~~~~~~
         __vdso_gettimeofday
arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_getres':
arch/mips/vdso/vgettimeofday.c:29:9: error: implicit declaration of functio=
n '__cvdso_clock_getres_time32'; did you mean '__vdso_clock_gettime'? [-Wer=
ror=3Dimplicit-function-declaration]
  return __cvdso_clock_getres_time32(clock_id, res);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         __vdso_clock_gettime
arch/mips/vdso/vgettimeofday.c: In function '__vdso_clock_gettime64':
arch/mips/vdso/vgettimeofday.c:35:9: error: implicit declaration of functio=
n '__cvdso_clock_gettime'; did you mean '__vdso_clock_gettime'? [-Werror=3D=
implicit-function-declaration]
  return __cvdso_clock_gettime(clock, ts);
         ^~~~~~~~~~~~~~~~~~~~~
         __vdso_clock_gettime
cc1: some warnings being treated as errors
make[1]: *** [arch/mips/vdso/Makefile:148: arch/mips/vdso/vgettimeofday-o32=
.o] Error 1
make: *** [Makefile:1746: arch/mips/vdso/vgettimeofday-o32.o] Error 2
