Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 1 Feb 2005 12:32:49 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: pci: Arch hook to determine config space size
Message-ID: <20050201123249.GA10088@parcelfarce.linux.theplanet.co.uk>
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050131192955.GJ31145@parcelfarce.linux.theplanet.co.uk> <41FEA4AA.1080407@us.ibm.com> <200501312256.44692.arnd@arndb.de> <41FEB492.2020002@us.ibm.com> <1107227727.5963.46.camel@gaston> <41FF0B0D.8020003@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FF0B0D.8020003@us.ibm.com>
Sender: <willy@www.linux.org.uk>
To: Brian King <brking@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Linux Arch list <linux-arch@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>, linux-pci@atrey.karlin.mff.cuni.cz
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jan 31, 2005 at 10:52:29PM -0600, Brian King wrote:
> @@ -62,8 +72,11 @@ static int rtas_read_config(struct devic
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	if (where & (size - 1))
>  		return PCIBIOS_BAD_REGISTER_NUMBER;

You should probably delete this redundant test at the same time ...

> +	if (!config_access_valid(dn, where))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
> -	addr = (dn->busno << 16) | (dn->devfn << 8) | where;
> +	addr = ((where & 0xf00) << 20) | (dn->busno << 16) |
> +		(dn->devfn << 8) | (where & 0xff);
>  	buid = dn->phb->buid;
>  	if (buid) {
>  		ret = rtas_call(ibm_read_pci_config, 4, 2, &returnval,

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
