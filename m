Return-Path: <SRS0=mIjk=5D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRJ6J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2020 05:58:09 -0400
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org> <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
 <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Mar 2020 10:57:49 +0100
Message-ID: <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: Marc Zyngier <maz@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <20200318095749.XsCxSMPqXpHUyV6uETtIpPo96YmtaOmV58-ELfNlTMI@z>

On Wed, Mar 18, 2020 at 1:15 AM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 16, 2020 1:33 AM
> >
> > On Mon, Mar 16, 2020 at 9:30 AM Marc Zyngier <maz@kernel.org> wrote:
> > > On 2020-03-16 08:22, Arnd Bergmann wrote:
> > > > On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com>
> > > > wrote:
> > > >>  /*
> > > >> + * Functions for allocating and freeing memory with size and
> > > >> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> > > >> + * the guest page size may not be the same as the Hyper-V page
> > > >> + * size. We depend upon kmalloc() aligning power-of-two size
> > > >> + * allocations to the allocation size boundary, so that the
> > > >> + * allocated memory appears to Hyper-V as a page of the size
> > > >> + * it expects.
> > > >> + *
> > > >> + * These functions are used by arm64 specific code as well as
> > > >> + * arch independent Hyper-V drivers.
> > > >> + */
> > > >> +
> > > >> +void *hv_alloc_hyperv_page(void)
> > > >> +{
> > > >> +       BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> > > >> +       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > > >> +}
> > > >> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> > > >
> > > > I don't think there is any guarantee that kmalloc() returns
> > > > page-aligned
> > > > allocations in general.
> > >
> > > I believe that guarantee came with 59bb47985c1db ("mm, sl[aou]b:
> > > guarantee
> > > natural alignment for kmalloc(power-of-two)").
> > >
> > > > How about using get_free_pages() to implement this?
> > >
> > > This would certainly work, at the expense of a lot of wasted memory when
> > > PAGE_SIZE isn't 4k.
> >
> > I'm sure this is the least of your problems when the guest runs with
> > a large base page size, you've already wasted most of your memory
> > otherwise then.
> >
>
> I think there's value in keeping these functions.  There are 8 uses in
> architecture independent code at the moment, which admittedly saves
> only ~1/2 Mbyte of memory with a 64K page size, but we will have
> additional uses with more memory savings as we get all of the
> Hyper-V synthetic drivers to work with 64K page size.  Furthermore,
> there's coming work that will require additional steps to share a page
> between a guest and the Hyper-V host.  These functions are the right
> place to put the code for the additional sharing steps.  Removing them
> now in favor of a bare kmalloc() and then adding them back doesn't
> seem worthwhile.

My point was to keep the functions but use alloc_pages() internally,
so you can deal with the hypervisor having a larger page size than
the guest, which seems to be a more important scenario if I correctly
understand the differences between the way Windows and Linux
deal with page cache.

As far as I understand, using 64kb pages on Windows is generally
a win as the VFS code already deals with units of that size, while
on Linux the 4kb page size is too deeply entrenched within the
file system code to mess with it: Whatever you gain in terms of
TLB pressure on workloads that cannot use huge pages is all lost
again through extra I/O and wasted physical memory.

        Arnd
