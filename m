Return-Path: <SRS0=2lSW=4T=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH] mm/special: Create generic fallbacks for pte_special()
 and pte_mkspecial()
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
 <CAMuHMdXnUeYib2dMALyzrW8LKhTjsnGFsqALoTxVHzPGc+OUTg@mail.gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <02997860-9374-28b9-8703-dc9b62b3f8ff@arm.com>
Date: Mon, 2 Mar 2020 16:07:27 +0530
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXnUeYib2dMALyzrW8LKhTjsnGFsqALoTxVHzPGc+OUTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux MM <linux-mm@kvack.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Sam Creasey <sammy@sammy.net>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, Openrisc <openrisc@lists.librecores.org>, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200302103727.gq2WOZFr81EVAP8D-6Ps52gM2-ChHmaWXekFq7Mj9oo@z>


On 03/02/2020 01:49 PM, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> Thanks for your patch!
> 
> On Mon, Mar 2, 2020 at 2:56 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> Currently there are many platforms that dont enable HAVE_ARCH_PTE_SPECIAL
> ARCH_HAS_PTE_SPECIAL
> 
>> but required to define quite similar fallback stubs for special page table
>> entry helpers such as pte_special() and pte_mkspecial(), as they get build
>> in generic MM without a config check. This creates two generic fallback
>> stub definitions for these helpers, eliminating much code duplication.
>>
>> mips platform has a special case where pte_special() and pte_mkspecial()
>> visibility is wider than what HAVE_ARCH_PTE_SPECIAL enablement requires.
> ARCH_HAS_PTE_SPECIAL
> 

Oops, will fix it. I have been juggling between too many HAVE_ARCH_* and
ARCH_HAS_* lately :)
