From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 01/17] drivers: support PCIe in RISCV
Date: Wed, 7 Jun 2017 10:40:50 -0700
Message-ID: <CAOesGMgrXcWvrv-8Xos7qeXsYhsx5XJEXnU8NqQ1X7YvoYkDaA@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-2-palmer@dabbelt.com> <20170607142558.GA21155@infradead.org>
 <CAMgXwTjXZ5dsxmJ2FyWhCRWo-3nyvKUDfhfV0nNC+oakF=AEsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMgXwTjXZ5dsxmJ2FyWhCRWo-3nyvKUDfhfV0nNC+oakF=AEsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wesley Terpstra <wesley@sifive.com>
Cc: Christoph Hellwig <hch@infradead.org>, Palmer Dabbelt <palmer@dabbelt.com>, patches@groups.riscv.org, linux-arch <linux-arch@vger.kernel.org>, albert@sifive.com, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 7, 2017 at 10:09 AM, Wesley Terpstra <wesley@sifive.com> wrote:
>
>
> On Jun 7, 2017 7:26 AM, "Christoph Hellwig" <hch@infradead.org> wrote:
>
> On Tue, Jun 06, 2017 at 03:59:51PM -0700, Palmer Dabbelt wrote:
>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>
>> There are RISC-V systems that have been mapped to Xilinx FPGAs that have
>> their PCIe controllers on chip.  These build system changes allow RISC-V
>> systems to enable the Xilinx PCIe controller, and to setup PCIe IRQs.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
>>  drivers/pci/Makefile     | 1 +
>>  drivers/pci/host/Kconfig | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 462c1f5f5546..a29d9ec05d13 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -41,6 +41,7 @@ obj-$(CONFIG_MIPS) += setup-irq.o
>>  obj-$(CONFIG_TILE) += setup-irq.o
>>  obj-$(CONFIG_SPARC_LEON) += setup-irq.o
>>  obj-$(CONFIG_M68K) += setup-irq.o
>> +obj-$(CONFIG_RISCV) += setup-irq.o
>
> Can we do a cleanup here and add a ARCH_USE_GENERIC_PCI_SETUP Kconfig
> symbol that all these architectures can select?
>
>
> That would probably be better. I did not want to touch other arch/ folders
> in our changes.

I understand that approach when you're doing things in your tree
early, but in this case (and at this phase in submission/merging),
don't be afraid to touch other architectures and refactor/clean up.

Please do the refactor in a separate preceding patch and submit it
separate/soon instead of keeping it just in the series and bundled
with your addition. That way it can go in when ready even if the rest
of the series is spinning.


-Olof
