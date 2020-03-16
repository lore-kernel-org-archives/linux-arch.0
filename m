From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Date: Mon, 16 Mar 2020 09:22:43 +0100
Message-ID: <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com> <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:58117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgCPIXD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2020 04:23:03 -0400
In-Reply-To: <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de, Andy Whitcroft <apw@canonical.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com, "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com, Boqun Feng <boqun.feng@gmail.com>

On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
>  /*
> + * Functions for allocating and freeing memory with size and
> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> + * the guest page size may not be the same as the Hyper-V page
> + * size. We depend upon kmalloc() aligning power-of-two size
> + * allocations to the allocation size boundary, so that the
> + * allocated memory appears to Hyper-V as a page of the size
> + * it expects.
> + *
> + * These functions are used by arm64 specific code as well as
> + * arch independent Hyper-V drivers.
> + */
> +
> +void *hv_alloc_hyperv_page(void)
> +{
> +       BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> +       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);

I don't think there is any guarantee that kmalloc() returns page-aligned
allocations in general. How about using get_free_pages()
to implement this?

       Arnd
