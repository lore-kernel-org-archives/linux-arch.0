Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbgGUXCI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 19:02:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDFC0619DB
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 16:02:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so17072plr.8
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 16:02:07 -0700 (PDT)
Date: Tue, 21 Jul 2020 16:02:05 -0700 (PDT)
Subject: Re: [PATCH 3/6] riscv: include <asm/pgtable.h> in <asm/uaccess.h>
In-Reply-To: <20200710135706.537715-4-hch@lst.de>
From: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <mhng-2e6d1568-076d-40fc-988a-9d035d54af79@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200721230205.Fjmo3oOzPdOabEBezsExruUw4LUJNy5ZhxBDEouyBNc@z>

On Fri, 10 Jul 2020 06:57:03 PDT (-0700), Christoph Hellwig wrote:
> To ensure TASK_SIZE is defined for USER_DS.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/uaccess.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 8ce9d607b53dce..22de922d6ecb2f 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -8,6 +8,8 @@
>  #ifndef _ASM_RISCV_UACCESS_H
>  #define _ASM_RISCV_UACCESS_H
>
> +#include <asm/pgtable.h>		/* for TASK_SIZE */
> +
>  /*
>   * User space memory access functions
>   */

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
