From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v5 02/39] openrisc: add ioremap_nocache declaration before
 include asm-generic/io.h and sync ioremap prototype with it.
Date: Wed, 3 Jan 2018 23:23:37 +0800
Message-ID: <CAEbi=3cNH-BeYYwfsK+QeYBrwLXHBc_vszOmmc7FmWNLPvP2FA@mail.gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com> <3e5ba33674a883b56e20b35ea9ae34990ea838c8.1514874857.git.green.hu@gmail.com>
 <20180103143803.GI32243@lianli.shorne-pla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103143803.GI32243@lianli.shorne-pla.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stafford Horne <shorne@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>
List-Id: linux-arch.vger.kernel.org

Hi, Stafford:

2018-01-03 22:38 GMT+08:00 Stafford Horne <shorne@gmail.com>:
> Hello,
>
> On Tue, Jan 02, 2018 at 04:24:34PM +0800, Greentime Hu wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> It will be built failed if commit id: d25ea659 is selected. This patch c=
an fix this
>> build error.
>
> Ideally you would mention the commit description since the id is not yet
> usptream.  I found it here (its 1 in this series):
>
>   https://github.com/andestech/linux/commit/d25ea659
>   asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_..=
.
>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  arch/openrisc/include/asm/io.h |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/=
io.h
>> index 7c69139..6709b28 100644
>> --- a/arch/openrisc/include/asm/io.h
>> +++ b/arch/openrisc/include/asm/io.h
>> @@ -29,13 +29,14 @@
>>  #define PIO_OFFSET           0
>>  #define PIO_MASK             0
>>
>> +#define ioremap_nocache ioremap_nocache
>>  #include <asm-generic/io.h>
>
> Ideally we could move <asm-generic/io.h> include down to the bottom of th=
e file
> and not have to do the defines like like this, it seems clumsy to me.  In
> 'cris', 'nios2' and other architectures I can see they have the generic i=
nclude
> at the bottom of the file and not need for #define's.
>
> I tried that but I get a lot of errors.  Does your patch to asm-generic/i=
o.h
> cause build issues for those architectures as well?
>

I got this email from kbuild test robot. I personally tried arm64/x86
before I sent the generic asm io.h patch.
I tried openrisc/sparc before I sent these v5 patches.

BUILD REGRESSION

tree/branch: https://github.com/0day-ci/linux
Greentime-Hu/Andes-nds32-Linux-Kernel/20171220-155937
branch HEAD: 9353e22157b9b69be3a3beea3553b5a105a45516  dt-bindings:
timer: Add andestech atcpit100 timer binding doc

Regressions in current branch:

arch/cris/mm/ioremap.c:79:15: note: in expansion of macro 'ioremap_nocache'
arch/openrisc/include/asm/io.h:38:29: error: conflicting types for 'ioremap=
'
arch/openrisc/include/asm/io.h:44:29: note: in expansion of macro
'ioremap_nocache'
arch/sparc/include/asm/io_32.h:129:15: error: conflicting types for 'iorema=
p'
arch/sparc/include/asm/io_32.h:130:0: warning: "ioremap_nocache" redefined
arch/sparc/include/asm/io_32.h:131:0: warning: "ioremap_wc" redefined
arch/sparc/include/asm/io_32.h:132:0: warning: "ioremap_wt" redefined
arch/sparc/kernel/ioport.c:124:15: error: conflicting types for 'ioremap'
arch/sparc/kernel/ioport.c:131:1: note: in expansion of macro 'EXPORT_SYMBO=
L'
drivers/net/ethernet/faraday/ftmac100.c:205:32: sparse: restricted
__le32 degrades to integer
drivers/net/ethernet/faraday/ftmac100.c:221:23: sparse: incorrect type
in assignment (different base types)
drivers/net/ethernet/faraday/ftmac100.c:251:16: sparse: cast to
restricted __le32
drivers/net/ethernet/faraday/ftmac100.c:262:23: sparse: invalid assignment:=
 &=3D
drivers/net/ethernet/faraday/ftmac100.c:274:23: sparse: incorrect type
in assignment (different base types)
drivers/net/ethernet/faraday/ftmac100.c:288:18: warning: cast from
pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/faraday/ftmac100.c:293:9: warning: cast to
pointer from integer of different size [-Wint-to-pointer-cast]
drivers/net/ethernet/faraday/ftmac100.c:534:23: sparse: incorrect type
in assignment (different base types)
include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_noca=
che'
include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocac=
he'

Error ids grouped by kconfigs:

recent_errors
=E2=94=9C=E2=94=80=E2=94=80 cris-etrax-100lx_v2_defconfig
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 arch-cris-mm-ioremap.c:note:in-expa=
nsion-of-macro-ioremap_nocache
=E2=94=9C=E2=94=80=E2=94=80 openrisc-or1ksim_defconfig
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 arch-openrisc-include-asm-io.h:erro=
r:conflicting-types-for-ioremap
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 arch-openrisc-include-asm-io.h:note=
:in-expansion-of-macro-ioremap_nocache
=E2=94=9C=E2=94=80=E2=94=80 sparc64-allyesconfig
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:warning:cast-from-pointer-to-integer-of-different-size
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:warning:cast-to-pointer-from-integer-of-different-size
=E2=94=9C=E2=94=80=E2=94=80 sparc-defconfig
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 arch-sparc-include-asm-io_32.h:erro=
r:conflicting-types-for-ioremap
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 arch-sparc-include-asm-io_32.h:warn=
ing:ioremap_nocache-redefined
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 arch-sparc-include-asm-io_32.h:warn=
ing:ioremap_wc-redefined
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 arch-sparc-include-asm-io_32.h:warn=
ing:ioremap_wt-redefined
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 arch-sparc-kernel-ioport.c:error:co=
nflicting-types-for-ioremap
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 arch-sparc-kernel-ioport.c:note:in-=
expansion-of-macro-EXPORT_SYMBOL
=E2=94=9C=E2=94=80=E2=94=80 x86_64-allmodconfig
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:sparse:cast-to-restricted-__le32
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:sparse:incorrect-type-in-assignment-(different-base-types)-expected-un=
signed-int-unsigned-rxdes0-got-restrunsigned-int-unsigned-rxdes0
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:sparse:incorrect-type-in-assignment-(different-base-types)-expected-un=
signed-int-unsigned-rxdes2-got-restrunsigned-int-unsigned-rxdes2
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:sparse:incorrect-type-in-assignment-(different-base-types)-expected-un=
signed-int-unsigned-txdes2-got-restrunsigned-int-unsigned-txdes2
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:sparse:invalid-assignment:
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:sparse:restricted-__le32-degrades-to-integer
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:warning:cast-from-pointer-to-integer-of-different-size
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 drivers-net-ethernet-faraday-ftmac1=
00.c:warning:cast-to-pointer-from-integer-of-different-size
=E2=94=94=E2=94=80=E2=94=80 xtensa-allmodconfig
    =E2=94=9C=E2=94=80=E2=94=80 include-asm-generic-io.h:error:conflicting-=
types-for-ioremap
    =E2=94=9C=E2=94=80=E2=94=80 include-asm-generic-io.h:error:conflicting-=
types-for-ioremap_nocache
    =E2=94=94=E2=94=80=E2=94=80 include-asm-generic-io.h:note:in-expansion-=
of-macro-ioremap_nocache

elapsed time: 359m

configs tested: 128

i386                               tinyconfig
i386                   randconfig-x016-201751
i386                   randconfig-x011-201751
i386                   randconfig-x014-201751
i386                   randconfig-x017-201751
i386                   randconfig-x019-201751
i386                   randconfig-x018-201751
i386                   randconfig-x010-201751
i386                   randconfig-x013-201751
i386                   randconfig-x015-201751
i386                   randconfig-x012-201751
i386                     randconfig-n0-201751
x86_64                 randconfig-x003-201751
x86_64                 randconfig-x002-201751
x86_64                 randconfig-x006-201751
x86_64                 randconfig-x007-201751
x86_64                 randconfig-x000-201751
x86_64                 randconfig-x005-201751
x86_64                 randconfig-x004-201751
x86_64                 randconfig-x009-201751
x86_64                 randconfig-x008-201751
x86_64                 randconfig-x001-201751
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                   randconfig-i0-12180843
i386                   randconfig-i1-12180843
x86_64                 randconfig-x012-201751
x86_64                 randconfig-x010-201751
x86_64                 randconfig-x011-201751
x86_64                 randconfig-x015-201751
x86_64                 randconfig-x019-201751
x86_64                 randconfig-x014-201751
x86_64                 randconfig-x013-201751
x86_64                 randconfig-x016-201751
x86_64                 randconfig-x017-201751
x86_64                 randconfig-x018-201751
i386                     randconfig-a0-201751
i386                     randconfig-a1-201751
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s1-201751
i386                     randconfig-s0-201751
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
i386                             allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-x007-201751
i386                   randconfig-x008-201751
i386                   randconfig-x009-201751
i386                   randconfig-x004-201751
i386                   randconfig-x002-201751
i386                   randconfig-x005-201751
i386                   randconfig-x001-201751
i386                   randconfig-x006-201751
i386                   randconfig-x003-201751
i386                   randconfig-x000-201751
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
s390                        default_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
i386                   randconfig-x072-201751
i386                   randconfig-x078-201751
i386                   randconfig-x071-201751
i386                   randconfig-x077-201751
i386                   randconfig-x070-201751
i386                   randconfig-x074-201751
i386                   randconfig-x073-201751
i386                   randconfig-x079-201751
i386                   randconfig-x076-201751
i386                   randconfig-x075-201751
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
