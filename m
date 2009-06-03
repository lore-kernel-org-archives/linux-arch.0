From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Wed, 3 Jun 2009 08:07:39 +0100
Message-ID: <20090603070739.GD23561@linux-mips.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com> <20090602211057.GA10800@flint.arm.linux.org.uk> <10f740e80906021418i1d58f5eer940e7a8ec9fb8b9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35642 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbZFCHIu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Jun 2009 03:08:50 -0400
Content-Disposition: inline
In-Reply-To: <10f740e80906021418i1d58f5eer940e7a8ec9fb8b9e@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>

On Tue, Jun 02, 2009 at 11:18:04PM +0200, Geert Uytterhoeven wrote:

> > The big problem we have is that the only commonality between differ=
ent
> > SoCs is that the CPU executes ARM instructions. =A0Everything else =
is
> > entirely up to the SoC designer - eg location of memory, spacing of
> > memory banks, type of interrupt controller, etc is all highly SoC
> > specific. =A0Nothing outside of the ARM CPU itself is standardized.
>=20
> That sounds very similar to m68k, which does support generic kernels
> (except for Sun-3, which uses a completely different MMU)?

=46or MIPS we currently have a concept of system families.  The user se=
lects
one in the "System type" Kconfig menu.  With few exceptions that are no=
t
worth considering these system types are incompatible so there are
currently 37 families of incompatible platforms with more being added.

  Ralf
