Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37763 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdGRMEC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2017 08:04:02 -0400
Date: Tue, 18 Jul 2017 14:03:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v10 00/38] x86: Secure Memory Encryption (AMD)
In-Reply-To: <cover.1500319216.git.thomas.lendacky@amd.com>
Message-ID: <alpine.DEB.2.20.1707181402340.1945@nanos>
References: <cover.1500319216.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, kasan-dev@googlegroups.com, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Rik van Riel <riel@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Dave Young <dyoung@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, "Michael S. Tsirkin" <mst@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, xen-devel@lists.xen.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>
Message-ID: <20170718120353.EEpv8O3QNC6Aq5zz_UwqGZ0IqxxeZX4vuqxUwOi9Lvc@z>

On Mon, 17 Jul 2017, Tom Lendacky wrote:
> This patch series provides support for AMD's new Secure Memory Encryption (SME)
> feature.
> 
> SME can be used to mark individual pages of memory as encrypted through the
> page tables. A page of memory that is marked encrypted will be automatically
> decrypted when read from DRAM and will be automatically encrypted when
> written to DRAM. Details on SME can found in the links below.
> 
> The SME feature is identified through a CPUID function and enabled through
> the SYSCFG MSR. Once enabled, page table entries will determine how the
> memory is accessed. If a page table entry has the memory encryption mask set,
> then that memory will be accessed as encrypted memory. The memory encryption
> mask (as well as other related information) is determined from settings
> returned through the same CPUID function that identifies the presence of the
> feature.
> 
> The approach that this patch series takes is to encrypt everything possible
> starting early in the boot where the kernel is encrypted. Using the page
> table macros the encryption mask can be incorporated into all page table
> entries and page allocations. By updating the protection map, userspace
> allocations are also marked encrypted. Certain data must be accounted for
> as having been placed in memory before SME was enabled (EFI, initrd, etc.)
> and accessed accordingly.
> 
> This patch series is a pre-cursor to another AMD processor feature called
> Secure Encrypted Virtualization (SEV). The support for SEV will build upon
> the SME support and will be submitted later. Details on SEV can be found
> in the links below.

Well done series. Thanks to all people involved, especially Tom and Boris!
It was a pleasure to review that.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
