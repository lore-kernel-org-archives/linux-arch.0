Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr730074.outbound.protection.outlook.com ([40.107.73.74]:64441
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404448AbfJYGMt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Oct 2019 02:12:49 -0400
Subject: Re: [PATCH 1/2] asm-generic: Make msi.h a mandatory include/asm
 header
References: <cover.1571911976.git.michal.simek@xilinx.com>
 <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
 <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <33e46e4b-cfe4-db2f-02e1-0164327bcecc@xilinx.com>
Date: Fri, 25 Oct 2019 08:12:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Simek <michal.simek@xilinx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, git@xilinx.com, Palmer Dabbelt <palmer@sifive.com>, Christoph Hellwig <hch@infradead.org>, longman@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jackie Liu <liuyun01@kylinos.cn>, Wesley Terpstra <wesley@sifive.com>, Firoz Khan <firoz.khan@linaro.org>, sparclinux <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Burton <paul.burton@mips.com>, Cornelia Huck <cohuck@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Albert Ou <aou@eecs.berkeley.edu>, arcml <linux-snps-arc@lists.infradead.org>, "David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@google.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20191025061214.IQzCd2KKSC9uf454GNZoxzyNsk-ijpsfIeFMoVHO7BE@z>

On 24. 10. 19 16:44, Masahiro Yamada wrote:
> On Thu, Oct 24, 2019 at 7:13 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> msi.h is generic for all architectures expect of x86 which has own version.
> 
> Maybe a typo?  "except"

unfortunately yes.

> 
> 
> Anyway, the code looks good to me.
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I have sent v2.
Who should be taking these patches?

Thanks,
Michal
