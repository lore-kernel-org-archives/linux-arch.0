Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db5eur01on0056.outbound.protection.outlook.com ([104.47.2.56]:19456
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757640AbcJXXMe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Oct 2016 19:12:34 -0400
Subject: Re: [PATCH 02/18] arm64: ilp32: add documentation on the ILP32 ABI
 for ARM64
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-3-git-send-email-ynorov@caviumnetworks.com>
From: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <352ff60e-3975-8421-3274-3a904c0ac642@mellanox.com>
Date: Mon, 24 Oct 2016 12:36:27 -0400
MIME-Version: 1.0
In-Reply-To: <1477081997-4770-3-git-send-email-ynorov@caviumnetworks.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com
Message-ID: <20161024163627.gIBA123AFXHW8-ESovUx5a5mGmu22kCC5KD5KMaVZL0@z>

On 10/21/2016 4:33 PM, Yury Norov wrote:
> Based on Andrew Pinski's patch-series.
>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>   Documentation/arm64/ilp32.txt | 46 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 Documentation/arm64/ilp32.txt
>
> diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
> new file mode 100644
> index 0000000..b96c18f
> --- /dev/null
> +++ b/Documentation/arm64/ilp32.txt
> @@ -0,0 +1,46 @@
> +ILP32 AARCH64 SYSCALL ABI
> +=========================
> +
> +This document describes the ILP32 syscall ABI and where it differs
> +from the generic compat linux syscall interface.
> +
> +AARCH64/ILP32 userspace can potentially access top halves of registers that
> +are passed as syscall arguments, so such registers (w0-w7) are deloused.

I'm not sure what "potentially access" here means: I think what you want to say
is that userspace can pass garbage in the top half, but you should be clearer about
what you mean here.  Also, you shouldn't use "deloused" here, since it's not a term
that's defined elsewhere in the kernel, even though it's been used colloquially on LKML.
Provide an actual implementation definition, like "have their top 32 bits zeroed".

> +AARCH64/ILP32 provides next types turned to 64-bit (comparing to AARCH32):

What does "turned" mean here?  And I "next types" isn't standard English; you want
to say something like "the following types".  Likewise later with "next syscalls".

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

