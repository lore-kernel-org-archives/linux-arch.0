From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 3/6] riscv: include <asm/pgtable.h> in <asm/uaccess.h>
Date: Tue, 21 Jul 2020 16:02:05 -0700 (PDT)
Message-ID: <mhng-2e6d1568-076d-40fc-988a-9d035d54af79@palmerdabbelt-glaptop1>
References: <20200710135706.537715-4-hch@lst.de>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200710135706.537715-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
