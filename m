From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] lib: add NO_GENERIC_PCI_IOPORT_MAP
Date: Tue, 31 Jan 2012 23:18:54 +0200
Message-ID: <20120131211853.GC6843@redhat.com>
References: <cover.1327877053.git.mst@redhat.com>
 <201201301551.46907.arnd@arndb.de>
 <20120130161818.GA9345@redhat.com>
 <201201302004.33083.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <201201302004.33083.arnd@arndb.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Myron Stowe <myron.stowe@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, James Morris <jmorris@namei.org>, "John W. Linville" <linville@tuxdriver.com>, Michael Witten <mfwitten@gmail.com>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 30, 2012 at 08:04:32PM +0000, Arnd Bergmann wrote:
> On Monday 30 January 2012, Michael S. Tsirkin wrote:
> > > 
> > > +/*
> > > + * Create a virtual mapping cookie for a port on a given PCI device.
> > > + * Do not call this directly, it exists to make it easier for architectures
> > > + * to override.
> > > + */
> > > +#ifdef CONFIG_NO_GENERIC_PCI_IOPORT_MAP
> > > +extern void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
> > > +                                     unsigned int nr);
> > > +#else
> > > +static inline void __iomem *__pci_ioport_map(struct pci_dev *dev,
> > > +                              unsigned long port, unsigned int nr)
> > > +{
> > > +       return ioport_map(port, nr);
> > > +}
> > > +#endif
> > > 
> > >       Arnd
> > 
> > It would be nicer in that it would
> > make the kernel a bit smaller for generic architectures
> > but this would need to go into a separate header:
> > it depends on io.h and io.h depends on pci_iomap.h.
> 
> Adding extra dependencies is not good here, I agree.
> Maybe  a better solution is to use a macro instead of an inline
> function then:
> 
> #define  __pci_ioport_map(dev, port, nr) ioport_map(port, nr)
> 
> In general, macros should be avoided, but I think it's the
> best tradeoff in this case.
> 
> 	Arnd

OK, I did exactly that. Thanks!
