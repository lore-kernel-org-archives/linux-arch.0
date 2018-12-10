Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr700115.outbound.protection.outlook.com ([40.107.70.115]:23520
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726677AbeLJTvu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Dec 2018 14:51:50 -0500
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Date: Mon, 10 Dec 2018 19:51:46 +0000
Message-ID: <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6994742102DF064DB805071693ED2AB2@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Message-ID: <20181210195146.lRJ9G36UmiF99D6ht5daVsUjHUVaQPKqCyIvCto32CM@z>

Hi Firoz,

On Thu, Dec 06, 2018 at 10:48:24AM +0530, Firoz Khan wrote:
> diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include/uap=
i/asm/sgidefs.h
> index 26143e3..0364eec 100644
> --- a/arch/mips/include/uapi/asm/sgidefs.h
> +++ b/arch/mips/include/uapi/asm/sgidefs.h
> @@ -40,6 +40,6 @@
>   */
>  #define _MIPS_SIM_ABI32		1
>  #define _MIPS_SIM_NABI32	2
> -#define _MIPS_SIM_ABI64		3
> +#define _MIPS_SIM_ABIN64	3

Whilst I agree with changing our own definitions & filenames to use n64,
this macro actually reflects naming used by the toolchain. ie:

    $ mips-linux-gcc -mips64 -mabi=3D64 -dM -E - </dev/null | grep ABI64
    #define _ABI64 3
    #define _MIPS_SIM _ABI64

Our macro here is used to compare against _MIPS_SIM provided by the
toolchain, so for consistency I think we should keep the same name for
the macro that the toolchain uses.

And I realise that undoing that but keeping n64 in our own filenames &
macros is another type of inconsistency, but something imperfect is
unavoidable at this point given that the engineers way back when decided
to use "ABI64" for n64.

Thanks,
    Paul
