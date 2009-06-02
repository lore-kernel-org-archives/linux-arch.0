From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 02 Jun 2009 17:48:37 +0000
Message-ID: <1243964917.4229.54.camel@mulgrave.int.hansenpartnership.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	 <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
Sender: linux-embedded-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 2009-06-02 at 11:29 -0600, Grant Likely wrote:
> One topic that seems to garner debate is the issue of decoupling the
> kernel image from the target platform.  ie. On x86, PowerPC and Sparc
> a kernel image will boot on any machine (assuming the needed drivers
> are enabled), but this is rarely the case in embedded.  Most embedded
> kernels require explicit board support selected at compile time with
> no way to produce a generic kernel which will boot on a whole family
> of devices, let alone the whole architecture.  Part of this is a
> firmware issue, where existing firmware passes very little in the way
> of hardware description to the kernel, but part is also not making
> available any form of common language for describing the machine.

OK, so my minimal understanding in this area lead me to believe this was
because most embedded systems didn't have properly discoverable busses
and therefore you had to tailor the kernel configuration exactly to the
devices the system had.

> Embedded PowerPC and Microblaze has tackled this problem with the
> "Flattened Device Tree" data format which is derived from the
> OpenFirmware specifications, and there is some interest and debate (as
> discussed recently on the ARM mailing list) about making flattened
> device tree usable by ARM also (which I'm currently
> proof-of-concepting).  Josh Boyer has already touched on discussing
> flattened device tree support at kernel summit in an email to the
> ksummit list last week (quoted below), and I'm wondering if a broader
> discussing would be warranted.
> 
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

It sounds interesting ... however, it also sounds like an area which
might not impact the core kernel much ... or am I wrong about that?  The
topics we're really looking for the Kernel Summit are ones that require
cross system input and which can't simply be sorted out by organising an
Embedded mini-summit.

Now if flattened device tree could help us out with BIOS, ACPI, EFI and
the other myriad boot and identification standards that seem designed to
hide system information rather than reveal it, then we might be all
ears ...

James
