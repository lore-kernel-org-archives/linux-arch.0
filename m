Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 31 Jan 2005 19:29:55 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: pci: Arch hook to determine config space size
Message-ID: <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk>
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050128185234.GB21760@infradead.org> <20050129040647.GA6261@kroah.com> <41FE82B6.9060407@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FE82B6.9060407@us.ibm.com>
Sender: <willy@www.linux.org.uk>
To: Brian King <brking@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jan 31, 2005 at 01:10:46PM -0600, Brian King wrote:
> Greg KH wrote:
> >On Fri, Jan 28, 2005 at 06:52:34PM +0000, Christoph Hellwig wrote:
> >
> >>>+int __attribute__ ((weak)) pcibios_exp_cfg_space(struct pci_dev *dev) { 
> >>>return 1; }
> >>
> >>- prototypes belong to headers
> >>- weak linkage is the perfect way for total obsfucation
> >>
> >>please make this a regular arch hook
> >
> >
> >I agree.  Also, when sending PCI related patches, please cc the
> >linux-pci mailing list.
> 
> How about this?

Thanks for copying linux-pci.  I hate this patch.

Basically, ppc64's config ops are broken and need to check the offset
being read.  Here's i386:

static int pci_conf1_write (int seg, int bus, int devfn, int reg, int len, u32 v
alue)
{
        unsigned long flags;

        if ((bus > 255) || (devfn > 255) || (reg > 255)) 
                return -EINVAL;

I think all the config ops in ppc64 are broken and need to check for these
limits.  Also, it does some checks that are already performed by upper layers:

        if (where & (size - 1))
                return PCIBIOS_BAD_REGISTER_NUMBER;

is checked for in drivers/pci/access.c

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
