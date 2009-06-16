From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Tue, 16 Jun 2009 13:19:09 +0100
Message-ID: <20090616121909.GA1547@linux-mips.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <4A373EE6.6070201@compulab.co.il> <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43567 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbZFPMUL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Jun 2009 08:20:11 -0400
Content-Disposition: inline
In-Reply-To: <8bd0f97a0906160106g333eb222idd0d694f452650ff@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org

On Tue, Jun 16, 2009 at 04:06:48AM -0400, Mike Frysinger wrote:

> On Tue, Jun 16, 2009 at 02:42, Mike Rapoport wrote:
> > James Bottomley wrote:
> >> We've got to the point where there are simply too many embedded
> >> architectures to invite all the arch maintainers to the kernel sum=
mit.
> >> So, this year, we thought we'd do embedded via topic driven invita=
tions
> >> instead. =A0So what we're looking for is a proposal to discuss the=
 issues
> >> most affecting embedded architectures, or preview any features aff=
ecting
> >> the main kernel which embedded architectures might need ... or any=
 other
> >> topics from embedded architectures which might need discussion or
> >> debate.
> >
> > Another issue that affects embedded architectures is drivers initia=
lization
> > order. There are a lot of cases when you need the drivers to be ini=
tialized in
> > particular order, and current initcalls scheme does not allow fine =
grained
> > control for it.
>=20
> example: device configuration information stored in i2c eeprom (i.e.
> dimensions of attached framebuffer), but i2c is not available when
> framebuffer layer is setup.  framebuffer driver has to be built as a
> module and loaded by userspace, or i2c information is read by
> bootloader and passed down to the kernel.

I2C or similar busses can be a particularly annoying if they contain
essential configuration information such as memory size which is needed
long before anything else.  So for far a common solution is that platfo=
rms
are carrying a private (aka redundant, ugly) early-i2c system that's ju=
st
about sufficient for this purpose.

  Ralf
