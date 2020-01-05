Return-Path: <SRS0=cGiU=22=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34778 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAEIjb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jan 2020 03:39:31 -0500
From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
References: <20200105025215.2522-1-guoren@kernel.org>
        <20200105025215.2522-2-guoren@kernel.org>
Date: Sun, 05 Jan 2020 09:39:23 +0100
In-Reply-To: <20200105025215.2522-2-guoren@kernel.org> (guoren@kernel.org's
        message of "Sun, 5 Jan 2020 10:52:15 +0800")
Message-ID: <87o8viwb44.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, Anup.Patel@wdc.com, vincent.chen@sifive.com, zong.li@sifive.com, greentime.hu@sifive.com, bmeng.cn@gmail.com, atish.patra@wdc.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20200105083923.WiQYEVEupbkop7oOU0PT8OxY68AvXLNByjBvbzwLSSg@z>

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
