From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mm: move phys_mem_access_prot_allowed() declaration to pgtable.h
Date: Mon, 12 Sep 2016 17:20:12 +0200
Message-ID: <2215618.aZj7FWYi6Z@wuerfel>
References: <201609122309.XmaxEnpl%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201609122309.XmaxEnpl%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Baoyou Xie <baoyou.xie@linaro.org>, kbuild-all@01.org, ralf@linux-mips.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org, paul.burton@imgtec.com, chenhc@lemote.com, david.daney@cavium.com, kumba@gentoo.org, yamada.masahiro@socionext.com, kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com, toshi.kani@hpe.com, JBeulich@suse.com, dan.j.williams@intel.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, xie.baoyou@zte.com.cn
List-Id: linux-arch.vger.kernel.org

On Monday, September 12, 2016 11:13:45 PM CEST kbuild test robot wrote:
>    816  
>  > 817  struct file;
>  > 818  int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
>  > 819                          unsigned long size, pgprot_t *vma_prot);
>    820  #endif /* _ASM_GENERIC_PGTABLE_H */

This should be inside of the #ifdef __ASSEMBLY__

	Arnd
