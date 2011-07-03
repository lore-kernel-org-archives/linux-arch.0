From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 02/19] OpenRISC: Device tree
Date: Mon, 04 Jul 2011 07:39:38 +1000
Message-ID: <1309729178.14501.264.camel@pasglop>
References: <1309641352-18714-1-git-send-email-jonas@southpole.se>
	<1309641352-18714-3-git-send-email-jonas@southpole.se>
	<CACxGe6tFX=EQjaL-4EjSXquY5eh+bca29=d=cE5-YAVCUVRCvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACxGe6tFX=EQjaL-4EjSXquY5eh+bca29=d=cE5-YAVCUVRCvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Sun, 2011-07-03 at 14:51 -0600, Grant Likely wrote:
> > +
> > +#ifdef CONFIG_PCI
> > +/*
> > + * PCI <-> OF matching functions
> > + * (XXX should these be here?)
> > + */
> > +struct pci_bus;
> > +struct pci_dev;
> > +extern int pci_device_from_OF_node(struct device_node *node,
> > +                                       u8 *bus, u8 *devfn);
> > +extern struct device_node *pci_busdev_to_OF_node(struct pci_bus
> *bus,
> > +                                                       int devfn);
> > +extern struct device_node *pci_device_to_OF_node(struct pci_dev
> *dev);
> > +extern void pci_create_OF_bus_map(void);
> > +#endif

Don't copy these from powermac or microblaze. the OF_bus_map is
something that should not spread :-)

You get all you need of the above from generic code with my patches to
PCI <-> OF matching, which should be in linux-next and are going to be
merged in the next merge window.

Cheers,
Ben.
