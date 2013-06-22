From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: xtensa: include: asm: define '_PAGE_CHG_MASK' when
 'NOMMU'
Date: Sat, 22 Jun 2013 17:40:42 +0800
Message-ID: <51C5711A.6060107@asianux.com>
References: <51C554F4.8060704@asianux.com> <51C5564D.70106@asianux.com> <51C56E73.2020802@zankel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:62551 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab3FVJlj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jun 2013 05:41:39 -0400
In-Reply-To: <51C56E73.2020802@zankel.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/22/2013 05:29 PM, Chris Zankel wrote:
> Hi Chen,
>=20
> On 06/22/2013 12:46 AM, Chen Gang wrote:
>> After define it, with the same .config file, also report another err=
ors
>> below, Did I use the incorrect cross-compiler tools ?
>=20
> It almost seems that you are not using the cross compiler. There are =
two
> ways to specify the cross compiler.
> 1. As part of the config: make ARCH=3Dxtensa menuconfig and set Gener=
al
> setup ---> (xtensa-linux-gnu-) Cross-compiler tool prefix
> 2. Provide with make: make ARCH=3Dxtensa CROSS_COMPILE=3Dxtensa-linux=
-gnu-
>=20
> Since you are not specifying CROSS_COMPILE, did you configure it in .=
config?
>=20

What I have done is:

The related make:

  make ARCH=3Dxtensa allmodconfig
  make ARCH=3Dxtensa menuconfig
    set "xtensa-linux-gnu-" for "Cross compilier tool prefix"
    select "s6000" for "Processor type and features" -> "Xtensa Process=
or"
  make ARCH=3Dxtensa EXTRA_CFLAGS=3D-W


Thanks.

> -Chris
>=20
>>
>> (the attachment is the related .config file)
>>
>> Thanks.
>>
>>
>> The related environments:
>>
>> [root@dhcp122 ~]# rpm -qf /usr/bin/xtensa-linux-gnu-gcc
>> gcc-xtensa-linux-gnu-4.7.1-0.1.20120606.fc17.x86_64
>> [root@dhcp122 ~]# /usr/bin/xtensa-linux-gnu-gcc -v
>> Using built-in specs.
>> COLLECT_GCC=3D/usr/bin/xtensa-linux-gnu-gcc
>> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/xtensa-linux-gnu/4.7.1/lto-wr=
apper
>> Target: xtensa-linux-gnu
>> Configured with: ../gcc-4.7.1-RC-20120606/configure --disable-depend=
ency-tracking --disable-silent-rules --prefix=3D/usr --exec-prefix=3D/u=
sr --bindir=3D/usr/bin --sbindir=3D/usr/sbin --sysconfdir=3D/etc --data=
dir=3D/usr/share --includedir=3D/usr/include --libexecdir=3D/usr/libexe=
c --localstatedir=3D/var --sharedstatedir=3D/var/lib --mandir=3D/usr/sh=
are/man --infodir=3D/usr/share/info --build=3Dx86_64-redhat-linux-gnu -=
-host=3Dx86_64-redhat-linux-gnu --target=3Dxtensa-linux-gnu --enable-ta=
rgets=3Dall --program-prefix=3Dxtensa-linux-gnu- --enable-languages=3Dc=
 --without-headers --enable-sjlj-exceptions --with-system-libunwind --d=
isable-nls --disable-threads --disable-shared --disable-libmudflap --di=
sable-libssp --disable-libgomp --disable-libquadmath --disable-gold --d=
isable-decimal-float --enable-checking=3D --enable-gnu-unique-object --=
enable-linker-build-id --disable-plugin --enable-nls --with-system-zlib=
 --with-bugurl=3Dhttp://bugzilla.redhat.com/bugzilla/ --enable-obsolete
>> Thread model: single
>> gcc version 4.7.1 20120606 (Red Hat 4.7.1-0.1.20120606) (GCC)
>>
>> When type the command "make ARCH=3Dxtensa allmodconfig", it always r=
eports:
>>   "gcc: error: unrecognized command line option =E2=80=98-mlongcalls=
=E2=80=99"
>>
>> The related error:
>>
>>   AS      arch/xtensa/kernel/coprocessor.o
>> arch/xtensa/kernel/coprocessor.S: Assembler messages:
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(0) for 'rur0'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(1) for 'rur1'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(2) for 'rur2'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(3) for 'rur3'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(8) for 'rur8'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(9) for 'rur9'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(10) for 'rur10'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(11) for 'rur11'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(12) for 'rur12'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(13) for 'rur13'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(24) for 'rur24'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(25) for 'rur25'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(26) for 'rur26'
>> arch/xtensa/kernel/coprocessor.S:98: Error: invalid register number =
(27) for 'rur27'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wras128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:98: Error: unknown opcode or format=
 name 'wrbs128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (0) for 'wur0'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (1) for 'wur1'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (2) for 'wur2'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (3) for 'wur3'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (8) for 'wur8'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (9) for 'wur9'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (10) for 'wur10'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (11) for 'wur11'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (12) for 'wur12'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (13) for 'wur13'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (24) for 'wur24'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (25) for 'wur25'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (26) for 'wur26'
>> arch/xtensa/kernel/coprocessor.S:107: Error: invalid register number=
 (27) for 'wur27'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wrbl128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> arch/xtensa/kernel/coprocessor.S:107: Error: unknown opcode or forma=
t name 'wral128i'
>> make[1]: *** [arch/xtensa/kernel/coprocessor.o] Error 1
>> make: *** [arch/xtensa/kernel] Error 2
>>
>>
>> On 06/22/2013 03:40 PM, Chen Gang wrote:
>>> Define '_PAGE_CHG_MASK' when 'NOMMU' to pass compiling.
>>>
>>> The related make:
>>>
>>>   make ARCH=3Dxtensa allmodconfig
>>>   make ARCH=3Dxtensa menuconfig
>>>     set "xtensa-linux-gnu-" for "Cross compilier tool prefix"
>>>     select "s6000" for "Processor type and features" -> "Xtensa Pro=
cessor"
>>>   make ARCH=3Dxtensa EXTRA_CFLAGS=3D-W
>>>
>>> The related error:
>>>
>>>   arch/xtensa/include/asm/pgtable.h: In function =E2=80=98pte_modif=
y=E2=80=99:
>>>   arch/xtensa/include/asm/pgtable.h:289:9: error: =E2=80=98_PAGE_CH=
G_MASK=E2=80=99 undeclared (first use in this function)
>>>
>>>
>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> ---
>>>  arch/xtensa/include/asm/pgtable.h |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/includ=
e/asm/pgtable.h
>>> index 7e09f70..a28c49b 100644
>>> --- a/arch/xtensa/include/asm/pgtable.h
>>> +++ b/arch/xtensa/include/asm/pgtable.h
>>> @@ -149,9 +149,10 @@
>>>  #define _PAGE_DIRTY		(1<<7)	/* software: page dirty */
>>>  #define _PAGE_ACCESSED		(1<<8)	/* software: page accessed (read) *=
/
>>> =20
>>> +#define _PAGE_CHG_MASK	   (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRT=
Y)
>>> +
>>>  #ifdef CONFIG_MMU
>>> =20
>>> -#define _PAGE_CHG_MASK	   (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRT=
Y)
>>>  #define _PAGE_PRESENT	   (_PAGE_HW_VALID | _PAGE_CA_WB | _PAGE_ACC=
ESSED)
>>> =20
>>>  #define PAGE_NONE	   __pgprot(_PAGE_NONE | _PAGE_USER)
>>>
>>
>=20
>=20
>=20
>=20


--=20
Chen Gang

Asianux Corporation
