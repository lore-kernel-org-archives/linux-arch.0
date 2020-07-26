From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 4/6] arch, mm: wire up secretmemfd system call were relevant
Date: Sun, 26 Jul 2020 10:44:48 -0700 (PDT)
Message-ID: <mhng-ffb01b1d-16c2-4998-8434-99f1cae575bd@palmerdabbelt-glaptop1>
References: <20200720092435.17469-5-rppt@kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgGZRou (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 13:44:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE0C0619D5
        for <linux-arch@vger.kernel.org>; Sun, 26 Jul 2020 10:44:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k27so8126229pgm.2
        for <linux-arch@vger.kernel.org>; Sun, 26 Jul 2020 10:44:50 -0700 (PDT)
In-Reply-To: <20200720092435.17469-5-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, luto@kernel.org, Arnd Bergmann <arnd@arndb.de>, bp@alien8.de, catalin.marinas@arm.com, cl@linux.com, dan.j.williams@intel.com, dave.hansen@linux.intel.com, elena.reshetova@intel.com, hpa@zytor.com, idan.yaniv@ibm.com, mingo@redhat.com, jejb@linux.ibm.com, kirill@shutemov.name, willy@infradead.org, rppt@linux.ibm.com, rppt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org, tglx@linutronix.de, tycho@tycho.ws, will@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org

On Mon, 20 Jul 2020 02:24:33 PDT (-0700), rppt@kernel.org wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Wire up secretmemfd system call on architectures that define
> ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/unistd32.h      | 2 ++
>  arch/arm64/include/uapi/asm/unistd.h   | 1 +
>  arch/riscv/include/asm/unistd.h        | 1 +
>  arch/x86/entry/syscalls/syscall_32.tbl | 1 +
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  include/linux/syscalls.h               | 1 +
>  include/uapi/asm-generic/unistd.h      | 7 ++++++-
>  7 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
> index 977ee6181dab..9e47d9aed5eb 100644
> --- a/arch/riscv/include/asm/unistd.h
> +++ b/arch/riscv/include/asm/unistd.h
> @@ -9,6 +9,7 @@
>   */
>
>  #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SECRETMEMFD
>
>  #include <uapi/asm/unistd.h>

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
