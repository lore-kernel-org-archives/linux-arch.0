Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47487 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfBDI0O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Feb 2019 03:26:14 -0500
Date: Mon, 4 Feb 2019 09:26:09 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] KVM: export <linux/kvm_para.h> and <asm/kvm_para.h>
 for all architectures
Message-ID: <20190204082609.GB5953@lst.de>
References: <1549252517-23834-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549252517-23834-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3Lvv73vv73vv71t77+977+977+977+977+977+9?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Sam Ravnborg <sam@ravnborg.org>

On Mon, Feb 04, 2019 at 12:55:16PM +0900, Masahiro Yamada wrote:
> We have two ways to fix this inconsistency:
> 
>  [A] export both <linux/kvm_para.h> and <asm/kvm_para.h> for all
>      architectures, irrespective of the KVM support
> 
>  [B] Match the header export of <linux/kvm_para.h> and <asm/kvm_para.h>
>      to the KVM support
> 
> This commit adopts [A].
> 
> Remove 'no-export-headers' from include/uapi/linux/Kbuild to export
> <linux/kvm_para.h> for all architectures.
> 
> Add 'mandatory-y' to include/uapi/asm-generic/Kbuild.asm to export
> <asm/kvm_para.h> for all architectures. If arch does not have specific
> implementation, a wrapper file to <asm-generic/kvm_para.h> is
> automatically generated, and exported.
> 
> include/uapi/asm-generic/kvm_para.h is just a empty file. I cleaned
> up empty <asm/kvm_para.h> stubs.

Thanks, this look so much cleaner than what we had before!

Acked-by: Christoph Hellwig <hch@lst.de>
