From: David VomLehn <dvomlehn@cisco.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 10:45:38 -0700
Message-ID: <20090602174538.GA10973@cuplxvomd02.corp.sa.net>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
Sender: linux-embedded-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 02, 2009 at 11:29:46AM -0600, Grant Likely wrote:
> On Tue, Jun 2, 2009 at 9:22 AM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > Hi All,
> >
> > We've got to the point where there are simply too many embedded
> > architectures to invite all the arch maintainers to the kernel summ=
it.
> > So, this year, we thought we'd do embedded via topic driven invitat=
ions
> > instead. =A0So what we're looking for is a proposal to discuss the =
issues
> > most affecting embedded architectures, or preview any features affe=
cting
> > the main kernel which embedded architectures might need ... or any =
other
> > topics from embedded architectures which might need discussion or
> > debate. =A0If you'd like to do this, could you either reply to this=
 email,
> > or send proposals to:
> >
> > ksummit-2009-discuss@lists.linux-foundation.org
>=20
> Hi James,
>=20
> One topic that seems to garner debate is the issue of decoupling the
> kernel image from the target platform.
=2E..
> Embedded PowerPC and Microblaze has tackled this problem with the
> "Flattened Device Tree" data format which is derived from the
> OpenFirmware specifications, and there is some interest and debate (a=
s
> discussed recently on the ARM mailing list) about making flattened
> device tree usable by ARM also (which I'm currently
> proof-of-concepting).  Josh Boyer has already touched on discussing
> flattened device tree support at kernel summit in an email to the
> ksummit list last week (quoted below), and I'm wondering if a broader
> discussing would be warranted.

I absolutely agree with this. We have been using the flattened device t=
ree
on our MIPS platform to support multiple systems, and are close to post=
ing
a patch to the MIPS Linux mailing list. At least one other MIPS platfor=
m
has indicated that they want to use the device tree.

> I think that in the absence of any established standard like the PC
> BIOS/EFI or a real Open Firmware interface, then the kernel should at
> least offer a recommended interface so that multiplatform kernels are
> possible without explicitly having the machine layout described to it
> at compile time.  I know that some of the embedded distros are
> interested in such a thing since it gets them away from shipping
> separate images for each supported board.  ie. It's really hard to do
> a generic live-cd without some form of multiplatform.  FDT is a great
> approach, but it probably isn't the only option.  It would be worth
> debating.

Is there another possibility besides the device tree that people are us=
ing
on 4 different architectures? We can't mandate support of the device tr=
ee
for any particular architecture or platform, but we can make sure the d=
evice
tree infrastructure is supported well enough that any architecture can =
pick
it up easily. Doing so will also encourage support in bootloaders which=
 may
not currently do so.

Should we decide to go this way, there probably a next step wherein we
standardize the device tree entries for those devices that are shared a=
cross
multiple architectures and platorms. This will likely be a never-ending
and mostly thankless task, but will again make things easier in the lon=
g run.

> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
