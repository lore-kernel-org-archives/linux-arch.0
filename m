From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Wed, 3 Jun 2009 13:17:10 +0100
Message-ID: <20090603121710.GF11507@sirena.org.uk>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com> <1243964917.4229.54.camel@mulgrave.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1243964917.4229.54.camel@mulgrave.int.hansenpartnership.com>
Sender: linux-embedded-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 02, 2009 at 05:48:37PM +0000, James Bottomley wrote:
> On Tue, 2009-06-02 at 11:29 -0600, Grant Likely wrote:

> > firmware issue, where existing firmware passes very little in the way
> > of hardware description to the kernel, but part is also not making
> > available any form of common language for describing the machine.

> OK, so my minimal understanding in this area lead me to believe this was
> because most embedded systems didn't have properly discoverable busses
> and therefore you had to tailor the kernel configuration exactly to the
> devices the system had.

Ish; essentially it's pushing the description of the non-enumerable bits
of the hardware out of kernel code and into a separate bit of data that
can be passed in to the kernel.

> It sounds interesting ... however, it also sounds like an area which
> might not impact the core kernel much ... or am I wrong about that?  The
> topics we're really looking for the Kernel Summit are ones that require
> cross system input and which can't simply be sorted out by organising an
> Embedded mini-summit.

One issue that does have wider impact is that the OpenFirmware bindings
can affect any driver level code - it means that drivers may need to
parse configuration out of the device tree as well as the mechanisms
they normally use.  This is already happening due to the current use but
will become more visible if more platforms adopt the device tree.  As
someone primarily working on driver/subsystem side stuff this is my
primary concern with expanded use of device tree - it's another set of
platform data code that needs writing in addition to the other schemes
currently in use.

On the other hand, if all the embedded architectures got together and
agreeded to move in this direction it'd be pretty much equivalent to
some new BIOS standard being introduced for PCs so perhaps not worth
worrying about at a general kernel level.

> Now if flattened device tree could help us out with BIOS, ACPI, EFI and
> the other myriad boot and identification standards that seem designed to
> hide system information rather than reveal it, then we might be all
> ears ...

Well, you could potentially try to render other BIOS data tables into
device tree format.  I'm not sure that the translation would be less
effort than parsing the existing data, though.
