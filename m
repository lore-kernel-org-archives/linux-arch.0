From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 11:29:46 -0600
Message-ID: <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Sender: linux-embedded-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 2, 2009 at 9:22 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Hi All,
>
> We've got to the point where there are simply too many embedded
> architectures to invite all the arch maintainers to the kernel summit=
=2E
> So, this year, we thought we'd do embedded via topic driven invitatio=
ns
> instead. =A0So what we're looking for is a proposal to discuss the is=
sues
> most affecting embedded architectures, or preview any features affect=
ing
> the main kernel which embedded architectures might need ... or any ot=
her
> topics from embedded architectures which might need discussion or
> debate. =A0If you'd like to do this, could you either reply to this e=
mail,
> or send proposals to:
>
> ksummit-2009-discuss@lists.linux-foundation.org

Hi James,

One topic that seems to garner debate is the issue of decoupling the
kernel image from the target platform.  ie. On x86, PowerPC and Sparc
a kernel image will boot on any machine (assuming the needed drivers
are enabled), but this is rarely the case in embedded.  Most embedded
kernels require explicit board support selected at compile time with
no way to produce a generic kernel which will boot on a whole family
of devices, let alone the whole architecture.  Part of this is a
firmware issue, where existing firmware passes very little in the way
of hardware description to the kernel, but part is also not making
available any form of common language for describing the machine.

Embedded PowerPC and Microblaze has tackled this problem with the
"Flattened Device Tree" data format which is derived from the
OpenFirmware specifications, and there is some interest and debate (as
discussed recently on the ARM mailing list) about making flattened
device tree usable by ARM also (which I'm currently
proof-of-concepting).  Josh Boyer has already touched on discussing
flattened device tree support at kernel summit in an email to the
ksummit list last week (quoted below), and I'm wondering if a broader
discussing would be warranted.

I think that in the absence of any established standard like the PC
BIOS/EFI or a real Open Firmware interface, then the kernel should at
least offer a recommended interface so that multiplatform kernels are
possible without explicitly having the machine layout described to it
at compile time.  I know that some of the embedded distros are
interested in such a thing since it gets them away from shipping
separate images for each supported board.  ie. It's really hard to do
a generic live-cd without some form of multiplatform.  FDT is a great
approach, but it probably isn't the only option.  It would be worth
debating.

Cheers,
g.

On Thu, May 28, 2009 at 5:41 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com=
> wrote:
> Not to hijack this entirely, but I'm wondering if we could tie in som=
e of the
> cross-arch device tree discussions that have been taking place among =
the ppc,
> sparc, and arm developers.
>
> I know the existing OF code for ppc, sparc, and microblaze could prob=
ably use
> some consolidation and getting some of the arch maintainers together =
in a room
> might prove fruitful.  Particularly if we are going to discuss how to=
 make
> drivers work for device tree and standard platforms alike.
>
> josh
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
