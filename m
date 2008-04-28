From: "Stephen Neuendorffer" <stephen.neuendorffer-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: Re: microblaze syscall list
Date: Sun, 27 Apr 2008 20:58:21 -0700
Message-ID: <20080428035856.DA04310C806F@mail39-sin.bigfish.com>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200804221515.28075.arnd@arndb.de> <480FA729.3000406@seznam.cz> <200804241311.09881.arnd@arndb.de> <4810D4A4.7050900@seznam.cz> <4811A623.80104@itee.uq.edu.au> <20080425100614.GB14990@parisc-linux.org> <4813DF3E.6080800@itee.uq.edu.au>
Reply-To: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8A8E4.2C91AC0A"
Return-path: <owner-microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>
Content-class: urn:content-classes:message
Sender: owner-microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
To: John Williams <jwilliams-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git <git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8A8E4.2C91AC0A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Mainline or bust! :)

-----Original Message-----
From: John Williams [mailto:jwilliams-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org]
Sent: Sat 4/26/2008 7:04 PM
To: Matthew Wilcox
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org; Arnd Bergmann; Will Newton; Linux =
Kernel list; linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; git
Subject: Re: [microblaze-uclinux] Re: microblaze syscall list
=20
Matthew Wilcox wrote:
> On Fri, Apr 25, 2008 at 07:36:35PM +1000, John Williams wrote:
>> Please remember that MicroBlaze has been around as an arch for > 4=20
>> years, just not in the kernel.org tree.  These older style syscall=20
>> interfaces are all part of the uClibc and glibc ports for MicroBlaze.
>=20
> So is it fair to say that you now understand this was the Wrong Way To
> Do Things, and if anyone asks, you'd recommend getting an arch merged
> into kernel.org sooner rather than later?
>=20

Without question!  If some abject humility will smooth the path for=20
MicroBlaze, I'm happy to show it.

By way of history, as a no-MMU arch starting on the 2.4 kernel series,=20
there was no home for us in kernel.org originally, however we were=20
always in the uClinux "mainline" at uclinux.org from the first release I =

did back in 2002.

We jumped in at 2.6.20 basing from some vendor patches that were never=20
going to fly in kernel.org.  Since then we have been improving and=20
cleaning them up to where they might actually stand a chance.

I am lobbying Xilinx (the effective "silicon vendor") as hard as I can=20
to support both the push to and maintenance within kernel.org.  They had =

someone at ELC in Mountain View week before last, which is a good sign I =

think.

Cheers,

John




------_=_NextPart_001_01C8A8E4.2C91AC0A
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: [microblaze-uclinux] Re: microblaze syscall list</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Mainline or bust! :)<BR>
<BR>
-----Original Message-----<BR>
From: John Williams [<A =
HREF=3D"mailto:jwilliams-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org">mailto:jwilliams-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org<=
/A>]<BR>
Sent: Sat 4/26/2008 7:04 PM<BR>
To: Matthew Wilcox<BR>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org; Arnd Bergmann; Will Newton; Linux =
Kernel list; linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; git<BR>
Subject: Re: [microblaze-uclinux] Re: microblaze syscall list<BR>
<BR>
Matthew Wilcox wrote:<BR>
&gt; On Fri, Apr 25, 2008 at 07:36:35PM +1000, John Williams wrote:<BR>
&gt;&gt; Please remember that MicroBlaze has been around as an arch for =
&gt; 4<BR>
&gt;&gt; years, just not in the kernel.org tree.&nbsp; These older style =
syscall<BR>
&gt;&gt; interfaces are all part of the uClibc and glibc ports for =
MicroBlaze.<BR>
&gt;<BR>
&gt; So is it fair to say that you now understand this was the Wrong Way =
To<BR>
&gt; Do Things, and if anyone asks, you'd recommend getting an arch =
merged<BR>
&gt; into kernel.org sooner rather than later?<BR>
&gt;<BR>
<BR>
Without question!&nbsp; If some abject humility will smooth the path =
for<BR>
MicroBlaze, I'm happy to show it.<BR>
<BR>
By way of history, as a no-MMU arch starting on the 2.4 kernel =
series,<BR>
there was no home for us in kernel.org originally, however we were<BR>
always in the uClinux &quot;mainline&quot; at uclinux.org from the first =
release I<BR>
did back in 2002.<BR>
<BR>
We jumped in at 2.6.20 basing from some vendor patches that were =
never<BR>
going to fly in kernel.org.&nbsp; Since then we have been improving =
and<BR>
cleaning them up to where they might actually stand a chance.<BR>
<BR>
I am lobbying Xilinx (the effective &quot;silicon vendor&quot;) as hard =
as I can<BR>
to support both the push to and maintenance within kernel.org.&nbsp; =
They had<BR>
someone at ELC in Mountain View week before last, which is a good sign =
I<BR>
think.<BR>
<BR>
Cheers,<BR>
<BR>
John<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8A8E4.2C91AC0A--
