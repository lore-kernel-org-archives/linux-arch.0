Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934581AbdD0H0H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Apr 2017 03:26:07 -0400
Date: Thu, 27 Apr 2017 15:25:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 31/32] x86: Add sysfs support for Secure Memory
 Encryption
Message-ID: <20170427072547.GB15297@dhcp-128-65.nay.redhat.com>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212212.10190.73484.stgit@tlendack-t1.amdoffice.net>
 <1498ec98-b19d-c47d-902b-a68870a3f860@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498ec98-b19d-c47d-902b-a68870a3f860@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170427072547.Oe09MfjMzQHocWJgEh3BfEABezPxJB7xqesk805Mokk@z>

On 04/21/17 at 02:55pm, Dave Hansen wrote:
> On 04/18/2017 02:22 PM, Tom Lendacky wrote:
> > Add sysfs support for SME so that user-space utilities (kdump, etc.) can
> > determine if SME is active.
> > 
> > A new directory will be created:
> >   /sys/kernel/mm/sme/
> > 
> > And two entries within the new directory:
> >   /sys/kernel/mm/sme/active
> >   /sys/kernel/mm/sme/encryption_mask
> 
> Why do they care, and what will they be doing with this information?

Since kdump will copy old memory but need this to know if the old memory
was encrypted or not. With this sysfs file we can know the previous SME
status and pass to kdump kernel as like a kernel param.

Tom, have you got chance to try if it works or not?

Thanks
Dave
