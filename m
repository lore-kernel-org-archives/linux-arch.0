Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:36944 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbeHULcj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Aug 2018 07:32:39 -0400
Date: Tue, 21 Aug 2018 10:13:31 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Message-ID: <20180821081331.GC24940@nazgul.tnic>
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180821081331.7Xr0KYvQpz0r7p4obGPQrN7JZO2Xhzs-MwHg3FVZ6zc@z>

On Mon, Aug 20, 2018 at 12:14:58AM +0800, Pu Wen wrote:
> To make AMD64 EDAC and MCE drivers working on Hygon platforms, add
> vendor checking for Hygon by using the code path of AMD 0x17. Add a
> vendor field to struct amd64_pvt and initialize it in per_family_init
> for vendor checking.
> 
> Also Hygon PCI Device ID DF_F0/DF_F6(0x1460/0x1466) of Host bridges
> is needed for edac driver.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/edac/amd64_edac.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/edac/amd64_edac.h |  5 +++++
>  drivers/edac/mce_amd.c    | 15 +++++++++++++-
>  3 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 18aeabb..3cefb25 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -211,7 +211,8 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
>  
>  	scrubval = scrubrates[i].scrubval;
>  
> -	if (pvt->fam == 0x17) {
> +	if (pvt->fam == 0x17 ||
> +	   (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18)) {

Didn't we say that AMD won't do family 0x18 so you don't need the vendor check?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
