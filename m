From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Date: Thu, 19 Mar 2020 21:43:53 +0000
Message-ID: <MW2PR2101MB10520CEF065A41EEBC17FFC2D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
 <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
 <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, gregkh <gregkh@linuxfoundation.org>, Marc Zyngier <maz@kernel.org>, Jason Wang <jasowang@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, "olaf@aepfle.de" <olaf@aepfle.de>, Catalin Marinas <catalin.marinas@arm.com>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, KY Srinivasan <kys@microsoft.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de> Sent: Wednesday, March 18, 2020 2:58 AM
> 
> On Wed, Mar 18, 2020 at 1:15 AM Michael Kelley <mikelley@microsoft.com> wrote:
> > From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 16, 2020 1:33 AM
> > >
> > > On Mon, Mar 16, 2020 at 9:30 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > On 2020-03-16 08:22, Arnd Bergmann wrote:
> > > > > On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com>
> > > > > wrote:
> > > > >>  /*
> > > > >> + * Functions for allocating and freeing memory with size and
> > > > >> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> > > > >> + * the guest page size may not be the same as the Hyper-V page
> > > > >> + * size. We depend upon kmalloc() aligning power-of-two size
> > > > >> + * allocations to the allocation size boundary, so that the
> > > > >> + * allocated memory appears to Hyper-V as a page of the size
> > > > >> + * it expects.
> > > > >> + *
> > > > >> + * These functions are used by arm64 specific code as well as
> > > > >> + * arch independent Hyper-V drivers.
> > > > >> + */
> > > > >> +
> > > > >> +void *hv_alloc_hyperv_page(void)
> > > > >> +{
> > > > >> +       BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> > > > >> +       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > > > >> +}
> > > > >> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> > > > >
> > > > > I don't think there is any guarantee that kmalloc() returns
> > > > > page-aligned
> > > > > allocations in general.
> > > >
> > > > I believe that guarantee came with 59bb47985c1db ("mm, sl[aou]b:
> > > > guarantee
> > > > natural alignment for kmalloc(power-of-two)").
> > > >
> > > > > How about using get_free_pages() to implement this?
> > > >
> > > > This would certainly work, at the expense of a lot of wasted memory when
> > > > PAGE_SIZE isn't 4k.
> > >
> > > I'm sure this is the least of your problems when the guest runs with
> > > a large base page size, you've already wasted most of your memory
> > > otherwise then.
> > >
> >
> > I think there's value in keeping these functions.  There are 8 uses in
> > architecture independent code at the moment, which admittedly saves
> > only ~1/2 Mbyte of memory with a 64K page size, but we will have
> > additional uses with more memory savings as we get all of the
> > Hyper-V synthetic drivers to work with 64K page size.  Furthermore,
> > there's coming work that will require additional steps to share a page
> > between a guest and the Hyper-V host.  These functions are the right
> > place to put the code for the additional sharing steps.  Removing them
> > now in favor of a bare kmalloc() and then adding them back doesn't
> > seem worthwhile.
> 
> My point was to keep the functions but use alloc_pages() internally,
> so you can deal with the hypervisor having a larger page size than
> the guest, which seems to be a more important scenario if I correctly
> understand the differences between the way Windows and Linux
> deal with page cache.

OK, I see now what you are getting at.  I should spell out my
assumption, which is the opposite.  Hyper-V won't have a page
size other than 4K anytime in the foreseeable future.  The
code is too wedded to the x86 4K page size, and the host-guest
interfaces have a lot of implicit assumptions that the page size is
4K (unfortunately).  But the last time I looked, RHEL for ARM64 is
delivered with a 64K page size.  So my assumption is that the only
combination that really matters is the guest page size being larger
than the Hyper-V page size.  The other way around just won't
happen without a major overhaul to Hyper-V, including a rework
of the guest-host interface.

Michael

> 
> As far as I understand, using 64kb pages on Windows is generally
> a win as the VFS code already deals with units of that size, while
> on Linux the 4kb page size is too deeply entrenched within the
> file system code to mess with it: Whatever you gain in terms of
> TLB pressure on workloads that cannot use huge pages is all lost
> again through extra I/O and wasted physical memory.
> 
>         Arnd
