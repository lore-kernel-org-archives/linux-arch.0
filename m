From: Arnaud Lacombe <lacombar@gmail.com>
Subject: Re: [RFC] move link of vmlinux to a script
Date: Sun, 22 Apr 2012 22:23:28 -0400
Message-ID: <CACqU3MU7MS7MjpyiSx-tUJ6c3rSexUB5=vTGy6gPv_OJevuOqw@mail.gmail.com>
References: <20120422212220.GA6537@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64352 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab2DWCXd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Apr 2012 22:23:33 -0400
In-Reply-To: <20120422212220.GA6537@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.cz>

Hi,

[some quick nits...]

On Sun, Apr 22, 2012 at 5:22 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> [...]
> index 0000000..c5a46ae
> --- /dev/null
> +++ b/scripts/link-vmlinux.sh
> @@ -0,0 +1,238 @@
> +#!/bin/sh
> +#
> +# link vmlinux
> +#
> +# vmlinux is linked from the objects selected by $(KBUILD_VMLINUX_IN=
IT) and
> +# $(KBUILD_VMLINUX_MAIN). Most are built-in.o files from top-level d=
irectories
> +# in the kernel tree, others are specified in arch/$(ARCH)/Makefile.
> +# Ordering when linking is important, and $(KBUILD_VMLINUX_INIT) mus=
t be first.
> +#
> +# vmlinux
> +# =A0 ^
> +# =A0 |
> +# =A0 +-< $(KBUILD_VMLINUX_INIT)
> +# =A0 | =A0 +--< init/version.o + more
> +# =A0 |
> +# =A0 +--< $(KBUILD_VMLINUX_MAIN)
> +# =A0 | =A0 =A0+--< driver/built-in.o mm/built-in.o + more
> +# =A0 |
> +# =A0 +-< ${kallsymso} (see description in KALLSYMS section)
> +#
> +# vmlinux version (uname -v) cannot be updated during normal
> +# descending-into-subdirs phase since we do not yet know if we need =
to
> +# update vmlinux.
> +# Therefore this step is delayed until just before final link of vml=
inux.
> +#
> +# System.map is generated to document addresses of all kernel symbol=
s
> +
> +# We need access to CONFIG_ symbols
> +source ./.config
> +
> +# Error out on error
> +set -e
> +
> +# Link of vmlinux
> +# $1 output file
> +modpost_link()
> +{
> + =A0 =A0 =A0 ${LD} ${LDFLAGS} -r -o $1 ${KBUILD_VMLINUX_INIT} =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --start-group ${KBUILD_VMLINUX_MAIN} --=
end-group
> +}
> +
> +# Link of vmlinux
> +# $1 - optional extra .o files
> +# $2 output file
> +vmlinux_link()
> +{
> + =A0 =A0 =A0 local lds=3D${srctree}/arch/${SRCARCH}/kernel/vmlinux.l=
ds
> +echo srcarch=3D${SRCARCH} CF=3D${CFLAGS_vmlinux}
debugging leftover ?

> + =A0 =A0 =A0 if [ "${SRCARCH}" !=3D "um" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${LD} ${LDFLAGS} ${LDFLAGS_vmlinux} -o =
$2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -T ${lds} ${KBUILD_VMLI=
NUX_INIT} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --start-group ${KBUILD_=
VMLINUX_MAIN} --end-group $1
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${CC} ${CFLAGS_vmlinux} -o $2 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -Wl,-T,${lds} ${KBUILD_=
VMLINUX_INIT} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -Wl,--start-group =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${KB=
UILD_VMLINUX_MAIN} =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -Wl,--end-group =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -lutil $1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm -f linux
> + =A0 =A0 =A0 fi
> +}
> +
> +
> +# Create $2 .o file with all symbols from $1 .o file
> +kallsyms()
> +{
> + =A0 =A0 =A0 info KSYM $2
> + =A0 =A0 =A0 local kallsymopt;
> +
> + =A0 =A0 =A0 if [ "${CONFIG_KALLSYMS_ALL}" !=3D "" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kallsymopt=3D--all-symbols
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 local aflags=3D"${KBUILD_AFLAGS} ${AFLAGS_KERNEL} ${NOS=
TDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} ${modkern_aflags}"
might be worse splitting that line.

> + =A0 =A0 =A0 ${NM} -n $1 | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scripts/kallsyms ${kallsymopt} | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${CC} ${aflags} -c -o $2 -x assembler-w=
ith-cpp -
> +}
> +
> +# Based on the vmlinux file create the System.map file
> +# System.map is used by module-init tools and some debugging
> +# tools to retrieve the actual addresses of symbols in the kernel.
> +# Generate System.map (actual filename passed as second argument)
> +
> +# $NM produces the following output:
> +# f0081e80 T alloc_vfsmnt
> +
> +# =A0 The second row specify the type of the symbol:
> +# =A0 A =3D Absolute
> +# =A0 B =3D Uninitialised data (.bss)
> +# =A0 C =3D Comon symbol
> +# =A0 D =3D Initialised data
> +# =A0 G =3D Initialised data for small objects
> +# =A0 I =3D Indirect reference to another symbol
> +# =A0 N =3D Debugging symbol
> +# =A0 R =3D Read only
> +# =A0 S =3D Uninitialised data for small objects
> +# =A0 T =3D Text code symbol
> +# =A0 U =3D Undefined symbol
> +# =A0 V =3D Weak symbol
> +# =A0 W =3D Weak symbol
> +# =A0 Corresponding small letters are local symbols
> +
> +# For System.map filter away:
> +# =A0 a - local absolute symbols
> +# =A0 U - undefined global symbols
> +# =A0 N - debugging symbols
> +# =A0 w - local weak symbols
> +
> +# readprofile starts reading symbols when _stext is found, and
> +# continue until it finds a symbol which is not either of 'T', 't',
> +# 'W' or 'w'. __crc_ are 'A' and placed in the middle
> +# so we just ignore them to let readprofile continue to work.
> +# (At least sparc64 has __crc_ in the middle).
> +mksysmap()
> +{
> + =A0 =A0 =A0 $NM -n $1 | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \=
$[adt]\)' > $2
> +}
> +
you don't seem to consistently use #{FOO} vs. $FOO.

> +
> +# Delete output files in case of error
> +trap cleanup SIGHUP SIGINT SIGQUIT SIGTERM ERR
> +cleanup()
> +{
> + =A0 =A0 =A0 rm -f vmlinux.o
> + =A0 =A0 =A0 rm -f .old_version
> + =A0 =A0 =A0 rm -f .tmp_vmlinux*
> + =A0 =A0 =A0 rm -f .tmp_kallsyms*
> + =A0 =A0 =A0 rm -f vmlinux
> + =A0 =A0 =A0 rm -f .tmp_System.map
> + =A0 =A0 =A0 rm -f System.map
> +}
> +
> +# non-verbose output
> +info()
> +{
> + =A0 =A0 =A0 printf " =A0%-7s %s\n" $1 $2
> +}
> +
> +# Use "make V=3DL" to debug this script
> +case "${KBUILD_VERBOSE}" in
> +*L*)
> + =A0 =A0 =A0 set -x
> + =A0 =A0 =A0 ;;
> +esac
> +
> +# Override MAKEFLAGS to avoid parrallel builds
> +MAKEFLAGS=3D'--no-print-directory -Rr'
> +
> +#link vmlinux.o
> +info LD vmlinux.o
> +modpost_link vmlinux.o
> +
> +# modpost vmlinux.o to check for section mismatches
> +${MAKE} -f ${srctree}/scripts/Makefile.modpost vmlinux.o
> +
> +# Update version
> +info GEN .version
> +if [ ! -r .version ]; then
why '-r' specifically ? '-e' might be just enough.

> + =A0 =A0 =A0 rm -f .version;
> + =A0 =A0 =A0 echo 1 >.version;
> +else
> + =A0 =A0 =A0 mv .version .old_version;
> + =A0 =A0 =A0 expr 0$(cat .old_version) + 1 >.version;
> +fi;
> +
> +# final build of init/
> +${MAKE} -f ${srctree}/scripts/Makefile.build obj=3Dinit
> +
are spaces allowed in `srctree' ? if so, this will break here.

> +
> +kallsymso=3D""
> +kallsyms_vmlinux=3D""
> +
> +if [ "${CONFIG_KALLSYMS}" !=3D "" ]; then
> +
[ -n "${CONFIG_KALLSYMS}" ] would work too, as well as the other
places where you use the [ "${FOO}" !=3D "" ] syntax.

 - Arnaud

> + =A0 =A0 =A0 # kallsyms support
> + =A0 =A0 =A0 # Generate section listing all symbols and add it into =
vmlinux
> + =A0 =A0 =A0 # It's a three step process:
> + =A0 =A0 =A0 # 1) =A0Link .tmp_vmlinux1 so it has all symbols and se=
ctions,
> + =A0 =A0 =A0 # =A0 =A0 but __kallsyms is empty.
> + =A0 =A0 =A0 # =A0 =A0 Running kallsyms on that gives us .tmp_kallsy=
ms1.o with
> + =A0 =A0 =A0 # =A0 =A0 the right size
> + =A0 =A0 =A0 # 2) =A0Link .tmp_vmlinux2 so it now has a __kallsyms s=
ection of
> + =A0 =A0 =A0 # =A0 =A0 the right size, but due to the added section,=
 some
> + =A0 =A0 =A0 # =A0 =A0 addresses have shifted.
> + =A0 =A0 =A0 # =A0 =A0 From here, we generate a correct .tmp_kallsym=
s2.o
> + =A0 =A0 =A0 # 2a) We may use an extra pass as this has been necessa=
ry to
> + =A0 =A0 =A0 # =A0 =A0 woraround some alignment related bugs.
> + =A0 =A0 =A0 # =A0 =A0 KALLSYMS_EXTRA_PASS=3D1 is used to trigger th=
is.
> + =A0 =A0 =A0 # 3) =A0The correct ${kallsymso} is linked into the fin=
al vmlinux.
> + =A0 =A0 =A0 #
> + =A0 =A0 =A0 # a) =A0Verify that the System.map from vmlinux matches=
 the map from
> + =A0 =A0 =A0 # =A0 =A0 ${kallsymso}.
> +
> + =A0 =A0 =A0 kallsymso=3D.tmp_kallsyms2.o
> + =A0 =A0 =A0 kallsyms_vmlinux=3D.tmp_vmlinux2
> +
> + =A0 =A0 =A0 # step 1
> + =A0 =A0 =A0 vmlinux_link "" .tmp_vmlinux1
> + =A0 =A0 =A0 kallsyms .tmp_vmlinux1 .tmp_kallsyms1.o
> +
> + =A0 =A0 =A0 # step 2
> + =A0 =A0 =A0 vmlinux_link .tmp_kallsyms1.o .tmp_vmlinux2
> + =A0 =A0 =A0 kallsyms .tmp_vmlinux2 .tmp_kallsyms2.o
> +
> + =A0 =A0 =A0 # step 2a
> + =A0 =A0 =A0 if [ "${KALLSYMS_EXTRA_PASS}" !=3D "" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kallsymso=3D.tmp_kallsyms3.o
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kallsyms_vmlinux=3D.tmp_vmlinux2
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vmlinux_link .tmp_kallsyms2.o .tmp_vmli=
nux3
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kallsyms .tmp_vmlinux3 .tmp_kallsyms3.o
> + =A0 =A0 =A0 fi
> +fi
> +
> +vmlinux_link "${kallsymso}" vmlinux
> +
> +info SYSMAP System.map
> +mksysmap vmlinux System.map
> +
> +# step a (see comment above)
> +if [ "${CONFIG_KALLSYMS}" !=3D "" ]; then
> + =A0 =A0 =A0 mksysmap ${kallsyms_vmlinux} .tmp_System.map
> +
> + =A0 =A0 =A0 if [ $(cmp -s System.map .tmp_System.map) ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo Inconsistent kallsyms data
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo This is a bug - please report abou=
t it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo echo Try "make KALLSYMS_EXTRA_PASS=
=3D1" as a workaround
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
> + =A0 =A0 =A0 fi
> +fi
> +
> +# We made a new kernel - delete old version file
> +rm -f .old_version
