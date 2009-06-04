From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Thu, 4 Jun 2009 14:24:32 -0600
Message-ID: <fa686aa40906041324s4634ae85gdeeaf4ae05c9fad@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
	<20090602211057.GA10800@flint.arm.linux.org.uk> <3340601010994331832@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <3340601010994331832@unknownmsgid>
Sender: linux-embedded-owner@vger.kernel.org
To: steve.langstaff@pebblebay.com
Cc: Russell King <rmk@arm.linux.org.uk>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 3, 2009 at 3:08 AM, Steve Langstaff
<steve.langstaff@pebblebay.com> wrote:
>> From: linux-embedded-owner@vger.kernel.org [mailto:linux-embedded-
>> owner@vger.kernel.org] On Behalf Of Russell King
>
>> The big problem we have is that the only commonality between differe=
nt
>> SoCs is that the CPU executes ARM instructions. =A0Everything else i=
s
>> entirely up to the SoC designer - eg location of memory, spacing of
>> memory banks, type of interrupt controller, etc is all highly SoC
>> specific. =A0Nothing outside of the ARM CPU itself is standardized.
>
> To my naive ears it sounds like this problem is crying out for ARM an=
d the
> SoC designers to add a standardized "autoprobe" interface to the core=
 to
> allow discovery of machine type and/or "location of memory, spacing o=
f
> memory banks, type of interrupt controller, etc".
>
> The benefits of such mechanisms are well known, but what are the draw=
backs?

Local bus probing probably imposes a lot of assumptions on a bus
designed to be as open as possible.  How are chip selects wired up?
What base addresses do devices respond to?  How do you know what the
device is?  What IRQ lines are used?  PCI solves this by exporting
configuration space which defines all of this, but PCI is considerably
more complex and not as fast as a CPU's local bus.  Similarly busses
like spi and i2c either have no probing protocol defined (spi), or
cannot always be reliably probed (i2c).

In short, the drawbacks are complexity on devices which cannot afford
the complexity.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
