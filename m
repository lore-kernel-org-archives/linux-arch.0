From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] mm: move phys_mem_access_prot_allowed() declaration
 to pgtable.h
Date: Fri, 16 Sep 2016 15:55:37 +0200
Message-ID: <20160916135537.GA22042@linux-mips.org>
References: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:51100 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756478AbcIPN4K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Sep 2016 09:56:10 -0400
Received: from localhost.localdomain ([127.0.0.1]:55874 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992155AbcIPN4HvwEln (ORCPT <rfc822;linux-arch@vger.kernel.org>
        + 1 other); Fri, 16 Sep 2016 15:56:07 +0200
Content-Disposition: inline
In-Reply-To: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, akpm@linux-foundation.org, paul.burton@imgtec.com, chenhc@lemote.com, david.daney@cavium.com, kumba@gentoo.org, yamada.masahiro@socionext.com, kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com, toshi.kani@hpe.com, dan.j.williams@intel.com, luto@kernel.org, JBeulich@suse.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, xie.baoyou@zte.com.cn

On Tue, Sep 13, 2016 at 03:26:37PM +0800, Baoyou Xie wrote:

> We get 1 warning when building kernel with W=1:
> drivers/char/mem.c:220:12: warning: no previous prototype for 'phys_mem_access_prot_allowed' [-Wmissing-prototypes]
>  int __weak phys_mem_access_prot_allowed(struct file *file,
> 
> In fact, its declaration is spreading to several header files
> in different architecture, but need to be declare in common
> header file.
> 
> So this patch moves phys_mem_access_prot_allowed() to pgtable.h.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
