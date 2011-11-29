From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH-RFC 1/2] tile: don't panic on iomap
Date: Tue, 29 Nov 2011 13:04:12 -0800
Message-ID: <CAErSpo4N8drqe5bHVjzXy_h0HTC8Reye4+8viN4c6TtmwFheXA@mail.gmail.com>
References: <cover.1322592494.git.mst@redhat.com> <a3bc9cb56040258dabc7b466ea217f4515b68b7d.1322592495.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <a3bc9cb56040258dabc7b466ea217f4515b68b7d.1322592495.git.mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Chris Metcalf <cmetcalf@tilera.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Paul Mundt <lethal@linux-sh.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 29, 2011 at 10:54 AM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> I think panic on iomap is there just for debugging.
> If we return NULL instead, the generic pci_iomap will
> DTRT so we don't need to roll our own.

Just to be explicit about what "doing the right thing" means, here's
what I think is changing (I think the new behavior is OK, but it *is*
different):

Old behavior: Caller calls pci_iomap(), which panics in ioport_map().

New behavior: Caller calls pci_iomap(), ioport_map() returns NULL,
pci_iomap() returns NULL (failure), caller may check for failure.  If
caller does not check for failure and passes the NULL to
ioread()/iowrite(), we WARN in bad_io_access().

> =A0static inline void __iomem *ioport_map(unsigned long port, unsigne=
d int len)
> =A0{
> - =A0 =A0 =A0 return (void __iomem *) ioport_panic();
> + =A0 =A0 =A0 pr_info("Trying to map an IO resource - it does not exi=
t on tile.\n");
> + =A0 =A0 =A0 return NULL;

s/exit/exist/

Since we only expect to see this message during debugging, maybe it
could be more informative, e.g., use dump_stack() to identify the
offending driver?  I don't think either the "Trying to map" message or
the "Bad IO access" message is enough to actually make progress in
debugging.

Bjorn
