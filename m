Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46123 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbdFTUzq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2017 16:55:46 -0400
Date: Tue, 20 Jun 2017 22:55:35 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 07/36] x86/mm: Don't use phys_to_virt in ioremap() if
 SME is active
In-Reply-To: <20170616185104.18967.7867.stgit@tlendack-t1.amdoffice.net>
Message-ID: <alpine.DEB.2.20.1706202251110.2157@nanos>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net> <20170616185104.18967.7867.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170620205535.S0z1HaNAoF4_fV4lY_Q14YZ-sh_sf7O2yevcgJOcmDY@z>

On Fri, 16 Jun 2017, Tom Lendacky wrote:

> Currently there is a check if the address being mapped is in the ISA
> range (is_ISA_range()), and if it is then phys_to_virt() is used to
> perform the mapping.  When SME is active, however, this will result
> in the mapping having the encryption bit set when it is expected that
> an ioremap() should not have the encryption bit set. So only use the
> phys_to_virt() function if SME is not active

This does not make sense to me. What the heck has phys_to_virt() to do with
the encryption bit. Especially why would the encryption bit be set on that
mapping in the first place?

I'm probably missing something, but this want's some coherent explanation
understandable by mere mortals both in the changelog and the code comment.

Thanks,

	tglx
