From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Tue, 1 Mar 2016 18:54:53 +0100
Message-ID: <20160301175453.GE25240@wotan.suse.de>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-4-git-send-email-mcgrof@kernel.org>
 <1456740770.4666.366.camel@infradead.org>
 <1456848624.2369.9.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33455 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbcCARzA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Mar 2016 12:55:00 -0500
Content-Disposition: inline
In-Reply-To: <1456848624.2369.9.camel@HansenPartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Woodhouse <dwmw2@infradead.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, gregkh@linuxfoundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, xen-devel@lists.xensource.com

On Tue, Mar 01, 2016 at 08:10:24AM -0800, James Bottomley wrote:
> On Mon, 2016-02-29 at 10:12 +0000, David Woodhouse wrote:
> > On Fri, 2016-02-19 at 05:45 -0800, Luis R. Rodriguez wrote:
> > > This ports built-in firmware to use linker tables,
> > > this replaces the custom section solution with a
> > > generic solution.
> > > 
> > > This also demos the use of the .rodata (SECTION_RO)
> > > linker tables.
> > > 
> > > Tested with 0 built-in firmware, 1 and 2 built-in
> > > firmwares successfully.
> > 
> > I think we'd do better to rip this support out entirely. It just 
> > isn't needed; firmware can live in an initramfs and don't even need 
> > *any* actual running userspace support to load it from there these 
> > days, do we?
> 
> We have lots of SCSI drivers with built in firmware.  The obvious
> examples are 53c700, aic7xxx and aic79xx.  For them, we actually have
> the firmware compilers in tree.  The firmware model they use just isn't
> amenable to the firmware loader: they're not monolithic blobs, it's a
> set of firmware scripts we use to handle particular operations before
> giving control back to the host, so the firmware and the driver are
> very much symbiotic.

I'm in the process of doing some other cleanups with the firmware_class
stuff so that odd requirements get supported but clean interfaces are
also not hampered by these odd requirements, so I'll take a look at
this later. If you have other oddball firmware requirements please
let me know so I can also keep in mind.

> On the other hand, I don't think any of them uses firmware sections, so
> it's not an argument for not ripping out this type.

Thanks for confirming. I'll rip this out.

  Luis
