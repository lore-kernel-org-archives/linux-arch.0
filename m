From: Marc Titinger <mtittinge@hotmail.com>
Subject: RE: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
Date: Mon, 13 Sep 2010 09:13:32 +0200
Message-ID: <SNT125-W35B89F6AA83C8DD22E7946BA770@phx.gbl>
References: <cover.1284357372.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1242537260=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: matt@console-pimps.org, robert.richter@amd.com
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, will.deacon@arm.com, acme@redhat.com, lethal@linux-sh.org, mingo@elte.hu, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

--===============1242537260==
Content-Type: multipart/alternative;
	boundary="_50cc5661-0dfc-454c-9b2c-dd281dd73e84_"

--_50cc5661-0dfc-454c-9b2c-dd281dd73e84_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi=2C=20

I'm just being curious : do these patches change the way those chips should=
 be supported=2C that do not have a PMU-like IP=2C but implement PC-samplin=
g thanks to a general purpose timer (not the system timer) ?

Thanks and Regards=2C
Marc.=20


> From: matt@console-pimps.org
> To: robert.richter@amd.com
> Subject: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
> Date: Mon=2C 13 Sep 2010 07:07:31 +0100
> CC: linux-arch@vger.kernel.org=3B linux@arm.linux.org.uk=3B linux-sh@vger=
.kernel.org=3B peterz@infradead.org=3B fweisbec@gmail.com=3B will.deacon@ar=
m.com=3B acme@redhat.com=3B lethal@linux-sh.org=3B mingo@elte.hu=3B linux-a=
rm-kernel@lists.infradead.org
>=20
> The perf-events backend for OProfile that Will Deacon wrote in
> 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
> perf-events framework as backend") is of use to more architectures
> than just ARM. Move the code into drivers/oprofile/ so that SH can use
> it instead of the nearly identical copy of its OProfile code.
>=20
> The benefit of the backend is that it becomes necessary to only
> maintain one copy of the PMU accessor functions for each architecture=2C
> with bug fixes and new features benefiting both OProfile and perf.
>=20
> Note that I haven't been able to test these patches on an ARM board to
> see if I've caused any regressions. If anyone else could do that I'd
> appreciate it. Though=2C I have been able to compile this version of the
> series.
>=20
> This patch series is based on=2C
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git core
>=20
> These patches can also be found at=2C
>=20
>     git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/sh-2.6.git per=
f-oprofile
>=20
> Changes from v2:
>  - Rebased against Robert's oprofile core branch
>  - Moved even more of the ARM code into the generic oprofile code
>  - Broke the patches up into more logical steps
>=20
> Changes from v1:
>  - Prefix the new functons with "oprofile_" instead of "op_".
>  - Fix ARM compilation errors
>  - Move all the oprofile-perf logic into oprofile_perf.c
>  - Include cleanup patch from Will
>=20
> Matt Fleming (6):
>   perf: Add helper function to return number of counters
>   ARM: oprofile: Rename op_arm to oprofile_perf
>   ARM: oprofile: Move non-ARM code into separate init/exit functions
>   oprofile: Abstract the perf-events backend
>   ARM: Make oprofile depend on CONFIG_HW_PERF_EVENTS
>   sh: oprofile: Use perf-events oprofile backend
>=20
>  arch/arm/Kconfig                 |    2 +-
>  arch/arm/kernel/perf_event.c     |    6 +
>  arch/arm/oprofile/Makefile       |    2 +-
>  arch/arm/oprofile/common.c       |  315 +-------------------------------=
-----
>  arch/sh/Kconfig                  |    2 +-
>  arch/sh/kernel/perf_event.c      |   17 ++
>  arch/sh/oprofile/Makefile        |    2 +-
>  arch/sh/oprofile/common.c        |  104 ++-----------
>  arch/sh/oprofile/op_impl.h       |   33 ----
>  drivers/oprofile/oprofile_perf.c |  322 ++++++++++++++++++++++++++++++++=
++++++
>  include/linux/oprofile.h         |    6 +
>  include/linux/perf_event.h       |    1 +
>  12 files changed=2C 368 insertions(+)=2C 444 deletions(-)
>  delete mode 100644 arch/sh/oprofile/op_impl.h
>  create mode 100644 drivers/oprofile/oprofile_perf.c
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
 		 	   		  =

--_50cc5661-0dfc-454c-9b2c-dd281dd73e84_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'>
Hi=2C <br><br>I'm just being curious : do these patches change the way thos=
e chips should be supported=2C that do not have a PMU-like IP=2C but implem=
ent PC-sampling thanks to a general purpose timer (not the system timer) ?<=
br><br>Thanks and Regards=2C<br>Marc. <br><br><br>&gt=3B From: matt@console=
-pimps.org<br>&gt=3B To: robert.richter@amd.com<br>&gt=3B Subject: [PATCH V=
3 0/6] Generalise ARM perf-events backend for oprofile<br>&gt=3B Date: Mon=
=2C 13 Sep 2010 07:07:31 +0100<br>&gt=3B CC: linux-arch@vger.kernel.org=3B =
linux@arm.linux.org.uk=3B linux-sh@vger.kernel.org=3B peterz@infradead.org=
=3B fweisbec@gmail.com=3B will.deacon@arm.com=3B acme@redhat.com=3B lethal@=
linux-sh.org=3B mingo@elte.hu=3B linux-arm-kernel@lists.infradead.org<br>&g=
t=3B <br>&gt=3B The perf-events backend for OProfile that Will Deacon wrote=
 in<br>&gt=3B 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprof=
ile: use<br>&gt=3B perf-events framework as backend") is of use to more arc=
hitectures<br>&gt=3B than just ARM. Move the code into drivers/oprofile/ so=
 that SH can use<br>&gt=3B it instead of the nearly identical copy of its O=
Profile code.<br>&gt=3B <br>&gt=3B The benefit of the backend is that it be=
comes necessary to only<br>&gt=3B maintain one copy of the PMU accessor fun=
ctions for each architecture=2C<br>&gt=3B with bug fixes and new features b=
enefiting both OProfile and perf.<br>&gt=3B <br>&gt=3B Note that I haven't =
been able to test these patches on an ARM board to<br>&gt=3B see if I've ca=
used any regressions. If anyone else could do that I'd<br>&gt=3B appreciate=
 it. Though=2C I have been able to compile this version of the<br>&gt=3B se=
ries.<br>&gt=3B <br>&gt=3B This patch series is based on=2C<br>&gt=3B <br>&=
gt=3B     git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git c=
ore<br>&gt=3B <br>&gt=3B These patches can also be found at=2C<br>&gt=3B <b=
r>&gt=3B     git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/sh-2.6.=
git perf-oprofile<br>&gt=3B <br>&gt=3B Changes from v2:<br>&gt=3B  - Rebase=
d against Robert's oprofile core branch<br>&gt=3B  - Moved even more of the=
 ARM code into the generic oprofile code<br>&gt=3B  - Broke the patches up =
into more logical steps<br>&gt=3B <br>&gt=3B Changes from v1:<br>&gt=3B  - =
Prefix the new functons with "oprofile_" instead of "op_".<br>&gt=3B  - Fix=
 ARM compilation errors<br>&gt=3B  - Move all the oprofile-perf logic into =
oprofile_perf.c<br>&gt=3B  - Include cleanup patch from Will<br>&gt=3B <br>=
&gt=3B Matt Fleming (6):<br>&gt=3B   perf: Add helper function to return nu=
mber of counters<br>&gt=3B   ARM: oprofile: Rename op_arm to oprofile_perf<=
br>&gt=3B   ARM: oprofile: Move non-ARM code into separate init/exit functi=
ons<br>&gt=3B   oprofile: Abstract the perf-events backend<br>&gt=3B   ARM:=
 Make oprofile depend on CONFIG_HW_PERF_EVENTS<br>&gt=3B   sh: oprofile: Us=
e perf-events oprofile backend<br>&gt=3B <br>&gt=3B  arch/arm/Kconfig      =
           |    2 +-<br>&gt=3B  arch/arm/kernel/perf_event.c     |    6 +<b=
r>&gt=3B  arch/arm/oprofile/Makefile       |    2 +-<br>&gt=3B  arch/arm/op=
rofile/common.c       |  315 +------------------------------------<br>&gt=
=3B  arch/sh/Kconfig                  |    2 +-<br>&gt=3B  arch/sh/kernel/p=
erf_event.c      |   17 ++<br>&gt=3B  arch/sh/oprofile/Makefile        |   =
 2 +-<br>&gt=3B  arch/sh/oprofile/common.c        |  104 ++-----------<br>&=
gt=3B  arch/sh/oprofile/op_impl.h       |   33 ----<br>&gt=3B  drivers/opro=
file/oprofile_perf.c |  322 ++++++++++++++++++++++++++++++++++++++<br>&gt=
=3B  include/linux/oprofile.h         |    6 +<br>&gt=3B  include/linux/per=
f_event.h       |    1 +<br>&gt=3B  12 files changed=2C 368 insertions(+)=
=2C 444 deletions(-)<br>&gt=3B  delete mode 100644 arch/sh/oprofile/op_impl=
.h<br>&gt=3B  create mode 100644 drivers/oprofile/oprofile_perf.c<br>&gt=3B=
 <br>&gt=3B <br>&gt=3B _______________________________________________<br>&=
gt=3B linux-arm-kernel mailing list<br>&gt=3B linux-arm-kernel@lists.infrad=
ead.org<br>&gt=3B http://lists.infradead.org/mailman/listinfo/linux-arm-ker=
nel<br> 		 	   		  </body>
</html>=

--_50cc5661-0dfc-454c-9b2c-dd281dd73e84_--


--===============1242537260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1242537260==--
