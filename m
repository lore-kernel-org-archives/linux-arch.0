Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45547 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeHLMug (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Aug 2018 08:50:36 -0400
MIME-Version: 1.0
References: <cover.1533989492.git.puwen@hygon.cn> <e282c406c34d5cdc92f7ec0bc12e9406405544d8.1533989493.git.puwen@hygon.cn>
In-Reply-To: <e282c406c34d5cdc92f7ec0bc12e9406405544d8.1533989493.git.puwen@hygon.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 12 Aug 2018 12:12:54 +0200
Message-ID: <CAJZ5v0i=KMjQEqkJmO-XSgnjTUYBepXzOTohQV62sUqXLi+QJw@mail.gmail.com>
Subject: Re: [PATCH v3 14/17] driver/acpi: enable Hygon support to ACPI driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: puwen@hygon.cn
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Message-ID: <20180812101254.23vKKCegWmWGIUQLZJ8P9Op-qPxaZJd5H3-GYTIu3Gc@z>

On Sat, Aug 11, 2018 at 3:36 PM Pu Wen <puwen@hygon.cn> wrote:
>
> For Dhyana processors have NONSTOP TSC feature, so enable the support
> to ACPI driver.
>
> Signed-off-by: Pu Wen <puwen@hygon.cn>

This patch is fine by me, but I'm assuming that the series will be
handled as a whole, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_pad.c       | 1 +
>  drivers/acpi/processor_idle.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 552c1f7..a47676a 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -70,6 +70,7 @@ static void power_saving_mwait_init(void)
>
>  #if defined(CONFIG_X86)
>         switch (boot_cpu_data.x86_vendor) {
> +       case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
>         case X86_VENDOR_INTEL:
>                 /*
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index abb559c..b2131c4 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -205,6 +205,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
>  static void tsc_check_state(int state)
>  {
>         switch (boot_cpu_data.x86_vendor) {
> +       case X86_VENDOR_HYGON:
>         case X86_VENDOR_AMD:
>         case X86_VENDOR_INTEL:
>         case X86_VENDOR_CENTAUR:
> --
> 2.7.4
>
