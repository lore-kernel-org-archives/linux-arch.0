From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Date: Fri, 20 Mar 2020 17:28:22 +0100
Message-ID: <CAK8P3a1MfYDTiQ9j0o3tnd=ymZukPoSmuExLhEMRR+GRwVD7xA@mail.gmail.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org> <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
 <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a2AO4k3vJ7WuJQz7ick+XPgGY3Jfk8-ROqtwyNs0nWkDA@mail.gmail.com> <MW2PR2101MB10520CEF065A41EEBC17FFC2D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MW2PR2101MB10520CEF065A41EEBC17FFC2D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Kelley <mikelley@microsoft.com>
Cc: Marc Zyngier <maz@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 19, 2020 at 10:43 PM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Wednesday, March 18, 2020 2:58 AM
> > On Wed, Mar 18, 2020 at 1:15 AM Michael Kelley <mikelley@microsoft.com> wrote:
> > My point was to keep the functions but use alloc_pages() internally,
> > so you can deal with the hypervisor having a larger page size than
> > the guest, which seems to be a more important scenario if I correctly
> > understand the differences between the way Windows and Linux
> > deal with page cache.
>
> OK, I see now what you are getting at.  I should spell out my
> assumption, which is the opposite.  Hyper-V won't have a page
> size other than 4K anytime in the foreseeable future.  The
> code is too wedded to the x86 4K page size, and the host-guest
> interfaces have a lot of implicit assumptions that the page size is
> 4K (unfortunately).  But the last time I looked, RHEL for ARM64 is
> delivered with a 64K page size.  So my assumption is that the only
> combination that really matters is the guest page size being larger
> than the Hyper-V page size.  The other way around just won't
> happen without a major overhaul to Hyper-V, including a rework
> of the guest-host interface.

Ok, got it. We should really ask Red Hat to change the page size,
but as long as you care existing systems, and you expect this to
result in gigabytes of allocation on future systems, having the
wrapper seems reasonable.

Maybe you could fall back to alloc_page when PAGE_SIZE equals
HV_HYP_PAGE_SIZE though? I'm not sure what the tradeoff
between kmalloc and alloc_page is these days, other than the
feeling that alloc_page is the more obvious choice when you know
you always want exactly a page here.

      Arnd
