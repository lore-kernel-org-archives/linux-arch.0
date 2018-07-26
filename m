From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Date: Thu, 26 Jul 2018 23:08:13 +0200
Message-ID: <91e66af2-9f59-624e-6839-eeadb47b9bee@gmx.de>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <87d0vehx16.fsf@concordia.ellerman.id.au>
 <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
 <20180726125940.GA15033@ls3530>
 <de188e2f-99ab-53fa-20df-4fec00a935e9@ghiti.fr>
 <6ec7c5dc-feb1-86ff-b7d9-7794c92eaf0f@ghiti.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ec7c5dc-feb1-86ff-b7d9-7794c92eaf0f@ghiti.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Ghiti <alex@ghiti.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jejb@parisc-linux.org, benh@kernel.crashing.org, paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mike
List-Id: linux-arch.vger.kernel.org

Hi Alex,

On 26.07.2018 21:13, Alex Ghiti wrote:
> $ make ARCH=parisc O=build_parisc generic-64bit_defconfig
> $ PATH=/home/alex/wip/toolchain/gcc-8.1.0-nolibc/hppa64-linux/bin:$PATH make ARCH=parisc CROSS_COMPILE=hppa64-linux-
> 
>> ...
>>  LD      vmlinux.o
>>  MODPOST vmlinux.o
>> hppa64-linux-ld: init/main.o(.text+0x98): cannot reach strreplace
>> init/main.o: In function `initcall_blacklisted':
>> init/.tmp_main.o:(.text+0x98): relocation truncated to fit: R_PARISC_PCREL22F against symbol `strreplace' defined in .text section in lib/string.o
>> hppa64-linux-ld: init/main.o(.text+0xbc): cannot reach strcmp

In order to be able to link vmlinux, we need to enable 
CONFIG_MLONGCALLS=y in the defconfig.

Nevertheless, I see some modversion issues too which I still need 
to analyze (but that's a completely off-topic issue here).

Helge
