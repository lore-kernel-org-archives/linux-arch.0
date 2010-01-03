From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/2] resource: align functions now return start of
 resource
Date: Sun, 3 Jan 2010 17:30:52 +0100
Message-ID: <20100103163052.GA5282@comet.dominikbrodowski.net>
References: <20100101163811.GA8124@comet.dominikbrodowski.net>
 <1262364050-8540-1-git-send-email-linux@dominikbrodowski.net>
 <86802c441001011412u1543c1afk6337cd6d3ea0f257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86802c441001011412u1543c1afk6337cd6d3ea0f257@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-arch.vger.kernel.org

Hey,

On Fri, Jan 01, 2010 at 02:12:09PM -0800, Yinghai Lu wrote:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D start;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > - =A0 =A0 =A0 }
> > + =A0 =A0 =A0 if ((res->flags & IORESOURCE_IO) && (start & 0x300))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D (start + 0x3ff) & ~0x3ff;
> > +
> > + =A0 =A0 =A0 return start
>=20
> missed ; here?

Indeed -- thanks for the hint.

Best,
	Dominik
