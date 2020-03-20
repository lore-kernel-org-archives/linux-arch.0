Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:34089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCTQi3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 12:38:29 -0400
MIME-Version: 1.0
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com>
 <MW2PR2101MB10524879CD685710A51AB740D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a02EULGxyuKFq8YnbG8BQ_m-RKciaNEc9ZbdP2yz9dt+Q@mail.gmail.com> <MW2PR2101MB1052686237C57955148F173ED7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1052686237C57955148F173ED7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Mar 2020 17:38:09 +0100
Message-ID: <CAK8P3a0y==1RsoMOnME9bgP5V_mts4rbaUW08Tt7mS9csXBqDw@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <20200320163809.b5V6QHNXoTDMI5Hje1cgy7BQpaQRy9dX_3k_yS1Wcpo@z>

On Thu, Mar 19, 2020 at 10:31 PM Michael Kelley <mikelley@microsoft.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de> Sent: Wednesday, March 18, 2020 3:10 AM
> > Just drop the __packed annotations then, they just confuse the compiler
> > in this case. In particular, when the compiler thinks that a structure is
> > misaligned, it tries to avoid using load/store instructions on it that are
> > inefficient or trap with misaligned code, so having default alignment
> > produces better object code.
>
> So I'm confused a bit.  Were the original concerns in the above LKML
> discussion bogus?  Is it legal for the compiler to reorder fields or add
> padding, even if the layout of fields in the structure doesn't require it?
> If the compiler *could* do such, then it seems like keeping the __packed
> would be appropriate per the LKML discussion.

The padding is defined in the ELF psABI document for a particular
architecture. In theory an architecture might require padding around
smaller members, but they generally don't when you look at the ones
that Linux runs on. The few odd ones are those that require less
padding, only aligning members to 16 or 32 bit rather than natural
alignment, or padding the size of the structure to 32 bit even if it
only contains 8-bit or 16-bit members. When you have structures
in which every member is naturally aligned and the size it a multiple
of 32 bit, better leave out the __packed.

Aside from generating sub-optimal code, the __packed annotation
can also lead to undefined behavior, if you pass a pointer to
an unaligned member into a function call that takes an aligned
pointer. Newer compilers warn about this.

> > > Unfortunately, changing to a bit mask ripples into
> > > architecture independent code and into the x86
> > > implementation.  I'd prefer not to drag that complexity
> > > into this patch set.
> >
> > How so? If this file is arm64 specific, there should be no need to make
> > x86 do the same change.
>
> This file, hyperv-tlfs.h, is duplicating some definitions on the x86 and
> ARM64 sides that are used by arch independent code, and this is one
> of those definitions.  I had held off on breaking the file into arch
> independent and arch specific portions because the Hyper-V team has
> left some gray areas for functionality that isn't yet used on the ARM64
> side.  So in some cases, it's hard to know what functionality to put
> into the arch independent portion.
>
> But I think I'll go ahead and make the separation with reasonably good
> accuracy, and update the x86 side accordingly.  That will reduce the size
> of this patch set to contain only the things that we know are ARM64
> specific and which are actually used by the ARM64 code.  Things like the
> hv_message_flags will go into the arch independent portion so that
> they can be used by the arch independent code without cluttering up
> the arch specific code.  Making the change will help reduce any
> confusion about what is ARM64-specific. The other core #include file,
> mshyperv.h, has already been done this way.

Ok, sounds good.

     Arnd
