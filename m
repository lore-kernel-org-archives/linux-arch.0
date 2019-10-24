Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-il1-f195.google.com ([209.85.166.195]:45842 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503021AbfJXPSJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 11:18:09 -0400
Received: by mail-il1-f195.google.com with SMTP id u1so22732425ilq.12
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 08:18:09 -0700 (PDT)
Date: Thu, 24 Oct 2019 08:17:59 -0700 (PDT)
From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/2] asm-generic: Make msi.h a mandatory include/asm
 header
In-Reply-To: <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
Message-ID: <alpine.DEB.2.21.9999.1910240810420.20010@viisi.sifive.com>
References: <cover.1571911976.git.michal.simek@xilinx.com> <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-165076562-1571930279=:20010"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, palmer@sifive.com, hch@infradead.org, longman@redhat.com, helgaas@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jackie Liu <liuyun01@kylinos.cn>, Wesley Terpstra <wesley@sifive.com>, Firoz Khan <firoz.khan@linaro.org>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, James Hogan <jhogan@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Burton <paul.burton@mips.com>, Cornelia Huck <cohuck@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, linux-snps-arc@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@google.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20191024151759.xde5LOjY2-J68r-iMScf8xC7rMLViblyFBBorQfZA48@z>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-165076562-1571930279=:20010
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Oct 2019, Michal Simek wrote:

> msi.h is generic for all architectures expect of x86 which has own versio=
n.
> Enabling MSI by including msi.h to architecture Kbuild is just additional
> step which doesn't need to be done.
> The patch was created based on request to enable MSI for Microblaze.
>=20
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
> https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/

[ ... ]

> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuil=
d
> index 16970f246860..1efaeddf1e4b 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -22,7 +22,6 @@ generic-y +=3D kvm_para.h
>  generic-y +=3D local.h
>  generic-y +=3D local64.h
>  generic-y +=3D mm-arch-hooks.h
> -generic-y +=3D msi.h
>  generic-y +=3D percpu.h
>  generic-y +=3D preempt.h
>  generic-y +=3D sections.h

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # arch/riscv
Tested-by: Paul Walmsley <paul.walmsley@sifive.com> # build only, rv32/rv64

Thanks Micha=B3,


- Paul
--8323329-165076562-1571930279=:20010--
