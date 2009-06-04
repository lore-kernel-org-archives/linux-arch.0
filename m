From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Thu, 4 Jun 2009 14:08:44 -0600
Message-ID: <fa686aa40906041308o265acd77n9bf6f4eb5a482162@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
	<20090602211057.GA10800@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:27996 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbZFDURL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2009 16:17:11 -0400
In-Reply-To: <20090602211057.GA10800@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-e

On Tue, Jun 2, 2009 at 3:10 PM, Russell King <rmk@arm.linux.org.uk> wro=
te:
> On Tue, Jun 02, 2009 at 11:29:46AM -0600, Grant Likely wrote:
>> Embedded PowerPC and Microblaze has tackled this problem with the
>> "Flattened Device Tree" data format which is derived from the
>> OpenFirmware specifications, and there is some interest and debate (=
as
>> discussed recently on the ARM mailing list) about making flattened
>> device tree usable by ARM also (which I'm currently
>> proof-of-concepting).
>
> Note that I have to point out that ARM will probably never be in a
> situation where you can have a one kernel image boots on everything.
> That _is_ practical today (and does happen with all PXA now) with wha=
t
> we have within a very big restriction - which is that the kernel must
> be built to support PXA and not Atmel SoCs.

Agreed, and isn't really my position either.  I do understand that
some things, like different CPU cores requiring different code
generation options, will probably never be feasible to support in a
single image.  Others may be doable, but not worthwhile because of
memory constraints or impact on hot paths.

> I really don't think combining SoC support is going to be realistic,
> device tree or not. =A0When we had just four machine types (RiscPC,
> EBSA110, EBSA285, Netwinder) I did look into this and came to the
> conclusion that it would be far too inefficient for there to be any
> win.
>
> The big problem we have is that the only commonality between differen=
t
> SoCs is that the CPU executes ARM instructions. =A0Everything else is
> entirely up to the SoC designer - eg location of memory, spacing of
> memory banks, type of interrupt controller, etc is all highly SoC
> specific. =A0Nothing outside of the ARM CPU itself is standardized.

I've been working on the Xilinx Virtex platform which is a CPU core
surrounded by a big FPGA fabric.  Doesn't get much non-standardized
that that.  :-)  It is trivial to build an image which boots on all of
the ppc440 platforms; the SoCs, and the Virtex5 FPGA.

Most of the 60x based SoCs have been merged too; all with very
different bus architectures, interrupt controllers and embedded
devices, but I do grant you that it isn't the same level of diversity
as in ARM land.

However, there has been no attempt to make a single powerpc image
which boots on everything; the cores are too different.  Instead, we
break it up by CPU type: 40x, 44x, 60x, 64 bit and the 8xx stuff that
everyone tries to forget.  IIUC, in ARM the MMU architecture is quite
varied, and that would have significant impact too.

Within each sub arch pretty much anything goes.  The kernel
initializes itself to the point of setting up the MMU and then probes
the machine definitions (arch/powerpc/platforms/*) until it finds one
which matches the device tree data.  At that point it is able to
branch off and set up the correct interrupt controller, register
devices and configure busses, etc.  As long as the correct machine
definition is compiled in, then everything goes.

As I'm sure you're about to point out :-), PowerPC machine probing
really isn't all that different from ARM machine probing except that
ARM uses the machine number and PowerPC uses the "model" property in
the device tree.  The real difference is the source of data describing
which devices are present; it just happens to be in an external data
structure instead of compiled in.  A lot of what was originally
thought to be machine specific code has just gone away because the
device tree infrastructure handles it elegantly.  Only the parts that
truly are machine specific continue to hang around.

I'm *not* suggesting that all ARM machines, or even most ARM machines
should be reworked to use something like the device tree.  What I am
suggesting is that there are many uses cases where it does make sense.
 For example, on the range of ARM netbooks rumored to come out near
the end of the year, the prospect of having a single kernel image boot
on multiple netbooks from multiple vendors is attractive to
distribution vendors like Canonical.  Device Tree certainly isn't the
only way to do this, but it is a viable one.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
