From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Wed, 3 Jun 2009 07:53:55 +0100
Message-ID: <20090603065355.GC23561@linux-mips.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41503 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbZFCGyc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Jun 2009 02:54:32 -0400
Content-Disposition: inline
In-Reply-To: <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org

On Tue, Jun 02, 2009 at 11:29:46AM -0600, Grant Likely wrote:

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

Hardware is simple to incompatible to allow the generation of a single
"one size fits all" image.  To list a few reasons from the MIPS world:

  o little vs. big endian
  o 32-bit vs. 64-bit
  o different system firmwares
  o processors and peripherals requiring creative workarounds which for
    code size or performance reasons want to limit to those systems
    suffering from the issue.
  o often claustrophobically small memory sizes.
  o exactly no communality across all systems except the processor
    architecture.
  o vendors coming up with their own instruction set enhancements not
    supported by any competitor and insisting on their use for the extra
    bit of performance and product differenciation.
  o many users have a long standing "roll your own" attitude.
  o peripherals that are even less probeable than ISA cards

"Flattened Device Tree" can tackle only a small part of this but its a
step.

> Embedded PowerPC and Microblaze has tackled this problem with the
> "Flattened Device Tree" data format which is derived from the
> OpenFirmware specifications, and there is some interest and debate (as
> discussed recently on the ARM mailing list) about making flattened
> device tree usable by ARM also (which I'm currently
> proof-of-concepting).  Josh Boyer has already touched on discussing
> flattened device tree support at kernel summit in an email to the
> ksummit list last week (quoted below), and I'm wondering if a broader
> discussing would be warranted.

Agreed.

  Ralf
