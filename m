Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52249 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730622AbfJXRDj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 13:03:39 -0400
Subject: Re: [PATCH 0/2] Enabling MSI for Microblaze
References: <cover.1571911976.git.michal.simek@xilinx.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <e9feafd1-8497-025b-e81d-f0e974038f3c@redhat.com>
Date: Thu, 24 Oct 2019 13:03:16 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1571911976.git.michal.simek@xilinx.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, palmer@sifive.com, hch@infradead.org, helgaas@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jackie Liu <liuyun01@kylinos.cn>, Wesley Terpstra <wesley@sifive.com>, Firoz Khan <firoz.khan@linaro.org>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, James Hogan <jhogan@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Burton <paul.burton@mips.com>, Cornelia Huck <cohuck@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, linux-snps-arc@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@google.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20191024170316.zErYk1z1ng0vcQ728hitsHKti355rP0lYQmd7qjQovI@z>

On 10/24/19 6:13 AM, Michal Simek wrote:
> Hi,
>
> these two patches come from discussion with Christoph, Bjorn, Palmer and
> Waiman. The first patch was suggestion by Christoph here
> https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/
> The second part was discussed
> https://lore.kernel.org/linux-pci/mhng-5d9bcb53-225e-441f-86cc-b335624b3e=
7c@palmer-si-x1e/
> and
> https://lore.kernel.org/linux-pci/20191017181937.7004-1-palmer@sifive.com=
/
>
> Thanks,
> Michal
>
>
> Michal Simek (1):
>   asm-generic: Make msi.h a mandatory include/asm header
>
> Palmer Dabbelt (1):
>   pci: Default to PCI_MSI_IRQ_DOMAIN
>
>  arch/arc/include/asm/Kbuild     | 1 -
>  arch/arm/include/asm/Kbuild     | 1 -
>  arch/arm64/include/asm/Kbuild   | 1 -
>  arch/mips/include/asm/Kbuild    | 1 -
>  arch/powerpc/include/asm/Kbuild | 1 -
>  arch/riscv/include/asm/Kbuild   | 1 -
>  arch/sparc/include/asm/Kbuild   | 1 -
>  drivers/pci/Kconfig             | 2 +-
>  include/asm-generic/Kbuild      | 1 +
>  9 files changed, 2 insertions(+), 8 deletions(-)
>
That looks OK.

Acked-by: Waiman Long <longman@redhat.com>
