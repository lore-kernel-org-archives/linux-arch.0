Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33325 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHKWbc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Aug 2018 18:31:32 -0400
MIME-Version: 1.0
In-Reply-To: <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn> <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
From: Michael Jin <mikhail.jin@gmail.com>
Date: Sat, 11 Aug 2018 15:56:17 -0400
Message-ID: <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180811195617.4gj5wWZdQxw7kTIPePMZr_jnLeGzZQi8WCuv51PEo0g@z>

On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 18aeabb..fb81354 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
>
>         scrubval = scrubrates[i].scrubval;
>
> -       if (pvt->fam == 0x17) {
> +       if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
>                 __f17h_set_scrubval(pvt, scrubval);

Separating the vendor check as an "else if (pvt->vendor ==
X86_VENDOR_HYGON)" block would make architectural changes (future
hygon models, i.e. 19h, 20h, etc) less confusing.



> +                       amd64_read_pci_cfg(pvt->F6,
> +                               F17H_SCR_BASE_ADDR, &scrubval);
> +                       if (scrubval & BIT(0)) {
> +                               amd64_read_pci_cfg(pvt->F6,

The new lines after "amd64_read_pci_cfg(pvt->F6," can be removed.



> @@ -1051,6 +1065,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>                 else
>                         pvt->dram_type = MEM_DDR4;
>                 return;
> +       case 0x18:
> +               if (pvt->vendor == X86_VENDOR_HYGON) {

This vendor checking is not necessary as there are no other known
family 18h processors.


>         switch (pvt->fam) {
> @@ -3192,6 +3227,13 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>                 pvt->ops        = &family_types[F17_CPUS].ops;
>                 break;
>
> +       case 0x18:
> +               if (pvt->vendor == X86_VENDOR_HYGON) {
> +                       fam_type        = &family_types[HYGON_F18_CPUS];
> +                       pvt->ops        = &family_types[HYGON_F18_CPUS].ops;
> +                       break;
> +               }

There is a missing second 'break' statement after the "if (pvt->vendor
== X86_VENDOR_HYGON)" block for case 0x18, see case 0x15 and case 0x16
for comparison.



> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 2ab4d61..f7adc47 100644
> +       case 0x18:
> +               if (c->x86_vendor == X86_VENDOR_HYGON) {
> +                       xec_mask = 0x3f;
> +                       if (!boot_cpu_has(X86_FEATURE_SMCA)) {
> +                               pr_warn("Decoding supported only on Scalable MCA processors.\n");
> +                               goto err_out;
> +                       }
> +                       break;
> +               }

The 'break' statement could be moved outside of the "if (c->x86_vendor
== X86_VENDOR_HYGON)" block, this is to allow case 0x18 to reach the
'break' statement if the vendor is not X86_VENDOR_HYGON.
