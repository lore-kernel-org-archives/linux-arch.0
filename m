From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Can this be a invalid memory access? (was: Re: [PATCH] spi/xilinx:
 Cast ioread32/iowrite32 function pointers)
Date: Mon, 2 Feb 2015 13:49:20 +0100
Message-ID: <CAPybu_16LBPDjuhL-Vw-rqFK-13+gLHrRc-3KuYwUTi0XyDX7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello

Regarding ioread8 et al.

On include/asm-generic/io.h is defined as:
extern unsigned int ioread8(void __iomem *);

On include/asm-generic/io.h:
static inline u8 ioread8(const volatile void __iomem *addr)

Please ignore the qualifiers right now. The first function returns an
unsigned integer, the second a u8.

Through #ifdefs, different arches uses the first or the second definitions.

If we consider this code:

u8 varA;
u8 varB;
u8 varC;
void * pvar=varB;
*pvar = ioread8(valid_memory);

Depending if ioread8 returns a u8 or a unsigned int, aren't we also
accessing varC?

Could not this be a problem?

If I decide to send a patch and fix it, is there a clever script that
I can run on my x86 computer to test if the patch works on all arches?


Thanks

-- 
Ricardo Ribalda
