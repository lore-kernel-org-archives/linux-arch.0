From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC] Enable ARCH_USE_BUILTIN_BSWAP by default
Date: Thu, 29 Oct 2015 10:32:36 +0900
Message-ID: <20151029013236.GA17164@wfg-t540p.sh.intel.com>
References: <1446044032.3405.241.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36567 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096AbbJ2Bcu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Oct 2015 21:32:50 -0400
Content-Disposition: inline
In-Reply-To: <1446044032.3405.241.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org

Hi David,

On Wed, Oct 28, 2015 at 11:53:52PM +0900, David Woodhouse wrote:
> Not sure we should actually *do* this, and if we did it'd be done
> differently. But... Fengguang, please could you add this (from
> git://git.infradead.org/users/dwmw2/byteswap.git ) and we can see wha=
t
> breaks? Thanks.

Sure.  Here are the errors found up to now:

=2E
=E2=94=9C=E2=94=80=E2=94=80 blackfin-BF526-EZBRD_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 blackfin-BF533-EZKIT_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 blackfin-BF561-EZKIT-SMP_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 blackfin-TCM-BF537_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 crypto-eseqiv.c:(.tex=
t):undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-mtd-chips-cfi=
_probe.c:(.text):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-binfmt_flat.c:(.te=
xt):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kernel-bpf-core.c:(.t=
ext):undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kernel-bpf-core.c:(.t=
ext):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lib-vsprintf.c:(.text=
):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-core-filter.c:(.t=
ext):undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-core-filter.c:(.t=
ext):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 frv-defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 m32r-m32104ut_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-md-dm-crypt.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-md-dm-snapshot.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-fs-u=
df-udf.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-des_generic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-md4.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-md5.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-serpent_generic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-twofish_generic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-md-dm-crypt.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-md-dm-snapshot.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-u=
df-udf.ko-undefined
=E2=94=9C=E2=94=80=E2=94=80 m32r-mappi3.smp_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-f=
at-fat.ko-undefined
=E2=94=9C=E2=94=80=E2=94=80 m32r-opsput_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-fs-u=
df-udf.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-f=
at-fat.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-u=
df-udf.ko-undefined
=E2=94=9C=E2=94=80=E2=94=80 m68k-m5475evb_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 pci.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 microblaze-allnoconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 arch-microblaze-kerne=
l-intc.o:(.text):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 arch-microblaze-kerne=
l-timer.o:(.text):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 microblaze-mmu_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-cifs-cifssmb.c:und=
efined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 microblaze-nommu_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 mips-bcm63xx_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 aes_generic.c:(.text)=
:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 generic-chip.c:(.text=
):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 mips-fuloong2e_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 commit.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 commit.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 eseqiv.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 recovery.c:(.text):un=
defined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 recovery.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 revoke.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 vsprintf.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 mips-rbtx49xx_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 mips-rm200_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 commit.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 commit.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 eseqiv.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 recovery.c:(.text):un=
defined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 recovery.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 revoke.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 vsprintf.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 mips-txx9
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 8250_early.c:(.init.t=
ext):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 des_generic.c:(.text)=
:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 dm-log.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 dm-log.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 extents.c:(.text):und=
efined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 extents.c:(.text):und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ibss.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 libata-scsi.c:(.text)=
:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 linear.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 md.c:(.text):undefine=
d-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 md.c:(.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 migrate.c:(.text):und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mlme.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mlme.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mmp.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mmp.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 quota_v2.c:(.text):un=
defined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 quota_v2.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 vht.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 xattr.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 xattr.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 mn10300-asb2364_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 crypto-compress.c:und=
efined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-video-fbdev-c=
ore-fb_notify.c:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-readdir.c:undefine=
d-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-readdir.c:undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lib-halfmd4.c:undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-core-netevent.c:u=
ndefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-core-netevent.c:u=
ndefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 vsprintf.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 parisc-c3000_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-block-umem.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-md-dm-crypt.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-md-dm-log.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-md-dm-snapshot.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-message-fusion-mptbase.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-net-ethernet-intel-e1000-e1000.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-des_generic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-md5.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-block-cryptoloop.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-block-umem.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-md-dm-crypt.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-md-dm-log.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-md-dm-snapshot.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-message-fusion-mptbase.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-message-fusion-mptctl.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-message-fusion-mptscsih.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-message-fusion-mptspi.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-alteon-acenic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-broadcom-tg3.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-dec-tulip-de2104x.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-intel-e1000-e1000.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-intel-e100.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-scsi-scsi_debug.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-usb-storage-usb-storage.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-f=
at-fat.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-x=
fs-xfs.ko-undefined
=E2=94=9C=E2=94=80=E2=94=80 parisc-defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-cryp=
to-tgr192.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-fs-c=
ifs-cifs.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-md4.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-michael_mic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-serpent_generic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-tea.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-tgr192.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-twofish_generic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-c=
ifs-cifs.ko-undefined
=E2=94=9C=E2=94=80=E2=94=80 parisc-generic-64bit_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-md-dm-raid.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-md-md-mod.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-net-ethernet-qlogic-qlcnic-qlcnic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-net-ethernet-qlogic-qlge-qlge.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-scsi-qla4xxx-qla4xxx.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-driv=
ers-usb-host-xhci-hcd.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapdi2-fs-b=
trfs-btrfs.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-des_generic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-cryp=
to-md4.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-ide-ide-gd_mod.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-md-dm-raid.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-md-md-mod.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-mfd-sm501.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-hp-hp100.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-qlogic-qla3xxx.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-qlogic-qlcnic-qlcnic.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-net-ethernet-qlogic-qlge-qlge.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-scsi-53c700.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-scsi-qla4xxx-qla4xxx.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-ssb-ssb.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-tty-nozomi.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-tty-serial-jsm-jsm.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-driv=
ers-usb-host-xhci-hcd.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-b=
trfs-btrfs.ko-undefined
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 ERROR:__bswapsi2-fs-f=
at-fat.ko-undefined
=E2=94=9C=E2=94=80=E2=94=80 sh-allnoconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 vsprintf.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sh-dreamcast_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cdrom.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 eseqiv.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 gdrom.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 vsprintf.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sh-ecovec24-romimage_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 decompress_unlzo.c:(.=
init.text):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 eseqiv.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 sd.c:(.text):undefine=
d-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 sd.c:(.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 sha256_generic.c:(.te=
xt):undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 sha256_generic.c:(.te=
xt):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 sh_eth.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 vsprintf.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sh-rsk7264_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sh-rsk7269_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 balloc.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 extents.c:(.text):und=
efined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 extents.c:(.text):und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 indirect.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 migrate.c:(.text):und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mmp.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mmp.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 xattr.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 xattr.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sh-se7206_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sh-se7751_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cfi_probe.c:(.text):u=
ndefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 eseqiv.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 vsprintf.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sh-sh7785lcr_32bit_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 arch-sh-include-asm-b=
itops-llsc.h:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 arch-sh-include-asm-u=
naligned-sh4a.h:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 arch-sh-include-uapi-=
asm-swab.h:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 arch-sh-kernel-iomap.=
c:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-mtd-chips-cfi=
_probe.c:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-scsi-scsi_sca=
n.c:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-scsi-sd.c:und=
efined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 drivers-scsi-sd.c:und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-ext4-ext4.h:undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-jbd2-journal.c:und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-jbd2-recovery.c:un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-jbd2-revoke.c:unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-jbd2-revoke.c:unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-lockd-clnt4xdr.c:u=
ndefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-lockd-xdr4.c:undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-lockd-xdr4.c:undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-nfs-callback_xdr.c=
:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-nfs-delegation.c:u=
ndefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-nfs-nfs3xdr.c:unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-nfs-nfs3xdr.c:unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-nfs-nfs4xdr.c:unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fs-nfs-nfs4xdr.c:unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-asm-generic-p=
reempt.h:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-crypto-scatte=
rwalk.h:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-linux-buffer_=
head.h:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-linux-jbd2.h:=
undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-linux-jbd2.h:=
undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-scsi-scsi_dev=
ice.h:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-scsi-scsi_dev=
ice.h:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-scsi-scsi.h:u=
ndefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 include-uapi-linux-sw=
ab.h:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 init-do_mounts_rd.c:u=
ndefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kernel-bpf-core.c:und=
efined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kernel-bpf-core.c:und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lib-crc32.c:undefined=
-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lib-sha1.c:undefined-=
reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lib-vsprintf.c:undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-core-filter.c:und=
efined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-core-filter.c:und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-core-tso.c:undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-ipv4-ipconfig.c:u=
ndefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-ipv4-ip_forward.c=
:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-ipv4-ip_options.c=
:undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net-sunrpc-auth_gss-g=
ss_rpc_xdr.c:undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 net-sunrpc-auth_gss-g=
ss_rpc_xdr.c:undefined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sh-titan_defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 commit.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 commit.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 eseqiv.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 esp4.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 esp4.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 esp6.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 esp6.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 filter.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefine=
d-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ipcomp6.c:(.text):und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ipcomp.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 journal.c:(.text):und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 recovery.c:(.text):un=
defined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 recovery.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 revoke.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 sha1_generic.c:(.text=
):undefined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 vsprintf.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 xfrm4_policy.c:(.text=
):undefined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 xfrm4_state.c:(.text)=
:undefined-reference-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sparc64-allnoconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=9C=E2=94=80=E2=94=80 sparc64-defconfig
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 balloc.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 extents.c:(.text):und=
efined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 extents.c:(.text):und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):un=
defined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ide-disk.c:(.text):un=
defined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 migrate.c:(.text):und=
efined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mmp.c:(.text):undefin=
ed-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mmp.c:(.text):undefin=
ed-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 proc.c:(.text):undefi=
ned-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 resize.c:(.text):unde=
fined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 (.text):undefined-ref=
erence-to-__bswapsi2
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 xattr.c:(.text):undef=
ined-reference-to-__bswapdi2
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 xattr.c:(.text):undef=
ined-reference-to-__bswapsi2
=E2=94=94=E2=94=80=E2=94=80 sparc-defconfig
    =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefined-reference-to-_=
_bswapdi2
    =E2=94=9C=E2=94=80=E2=94=80 core.c:(.text):undefined-reference-to-_=
_bswapsi2
    =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefined-reference-to-__=
bswapdi2
    =E2=94=9C=E2=94=80=E2=94=80 efi.c:(.text):undefined-reference-to-__=
bswapsi2
    =E2=94=9C=E2=94=80=E2=94=80 find_bit.c:(.text):undefined-reference-=
to-__bswapsi2
    =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefined-reference-to-__b=
swapdi2
    =E2=94=9C=E2=94=80=E2=94=80 (.init.text):undefined-reference-to-__b=
swapsi2
    =E2=94=9C=E2=94=80=E2=94=80 pcic.c:(.text):undefined-reference-to-_=
_bswapsi2
    =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undefined-reference-to-=
__bswapdi2
    =E2=94=9C=E2=94=80=E2=94=80 super.c:(.text):undefined-reference-to-=
__bswapsi2
    =E2=94=94=E2=94=80=E2=94=80 (.text):undefined-reference-to-__bswaps=
i2

Thanks,
=46engguang
