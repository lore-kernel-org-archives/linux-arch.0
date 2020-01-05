From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
Date: Sun, 05 Jan 2020 09:39:23 +0100
Message-ID: <87o8viwb44.fsf@hase.home>
References: <20200105025215.2522-1-guoren@kernel.org>
        <20200105025215.2522-2-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105025215.2522-2-guoren@kernel.org> (guoren@kernel.org's
        message of "Sun, 5 Jan 2020 10:52:15 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, Anup.Patel@wdc.com, vincent.chen@sifive.com, zong.li@sifive.com, greentime.hu@sifive.com, bmeng.cn@gmail.com, atish.patra@wdc.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Jan 05 2020, guoren@kernel.org wrote:

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d8efbaa78d67..3d336f869ffe 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -286,6 +286,15 @@ config FPU
>  
>  	  If you don't know what to do here, say Y.
>  
> +config VECTOR
> +	bool "VECTOR support"
> +	default n

default n is the default.  Did you mean default y?

> +	help
> +	  Say N here if you want to disable all vecotr related procedure

s/vecotr/vector/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
