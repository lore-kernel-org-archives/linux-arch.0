From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-RFC 06/10] mips: switch to GENERIC_PCI_IOMAP
Date: Mon, 30 Jan 2012 00:45:07 +0200
Message-ID: <20120129223339.GA22666@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
	<66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
	<CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-bounces@lists.openrisc.net>
Content-Disposition: inline
In-Reply-To: <CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux@openrisc.net, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Kumar Gala <galak@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, Arend van Spriel <arend@broadcom.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 28, 2012 at 02:38:10PM -0800, Kevin Cernekee wrote:
> On Thu, Nov 24, 2011 at 12:18 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > mips copied pci_iomap from generic code, probably to avoid
> > pulling the rest of iomap.c in. =A0Since that's in
> > a separate file now, we can reuse the common implementation.
> =

> [snip]
> =

> > - =A0 =A0 =A0 if (flags & IORESOURCE_IO)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioport_map_pci(dev, start, len);
> =

> While investigating a new warning on the 3.3-rc1 MIPS build (unused
> static function ioport_map_pci()), I noticed that this patch has shown
> up in Linus' tree as commit eab90291d35438bcebf7c3dc85be66d0f24e3002.
> =

> I am not completely clear on the implications it has on mapping PCI I/O r=
egions:

Yes, my bad, I missed the difference between ioport_map_pci
and ioport_map for both MIPS and SH.
I'll post a patch to fix this, which is probably preferable
to reintroducing the code duplication where it might
trip us up again.

-- =

MST
