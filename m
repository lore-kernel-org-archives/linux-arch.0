From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Date: Mon, 16 Mar 2020 09:47:57 +0100
Message-ID: <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com> <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:57731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbgCPIsR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Mar 2020 04:48:17 -0400
In-Reply-To: <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de, Andy Whitcroft <apw@canonical.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com, "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com, Boqun Feng <boqun.feng@gmail.com>

On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:

> +
> +/* Define input and output layout for Get VP Register hypercall */
> +struct hv_get_vp_register_input {
> +       u64 partitionid;
> +       u32 vpindex;
> +       u8  inputvtl;
> +       u8  padding[3];
> +       u32 name0;
> +       u32 name1;
> +} __packed;

Are you sure these need to be made byte-aligned according to the
specification? If the structure itself is aligned to 64 bit, better mark only
the individual fields that are misaligned as __packed.

If the structure is aligned to only 32-bit addresses instead of
64-bit, mark it as "__packed __aligned(4)" to let the compiler
generate better code for accessing it.

Also, in order to write portable code, it would be helpful to mark
all the fields as explicitly little-endian, and use __le32_to_cpu()
etc for accessing them.

> +/* Define synthetic interrupt controller message flags. */
> +union hv_message_flags {
> +       __u8 asu8;
> +       struct {
> +               __u8 msg_pending:1;
> +               __u8 reserved:7;
> +       } __packed;
> +};

For similar reasons, please avoid bit fields and just use a
bit mask on the first member of the union.

The __packed annotation here is not meaningful,
as the total size is already only a single byte.

> +/* Define port identifier type. */
> +union hv_port_id {
> +       __u32 asu32;
> +       struct {
> +               __u32 id:24;
> +               __u32 reserved:8;
> +       }  __packed u;
> +};

Here, the __packed annotation is inconsistent with the use
in the rest of the file: marking only one member of the union
as __packed means that the union itself is still expected to
be 4 byte aligned. I would expect that either all of these
structures have a sensible alignment, or they are all
completely unaligned.

> + * Use the Hyper-V provided stimer0 as the timer that is made
> + * available to the architecture independent Hyper-V drivers.
> + */
> +#define hv_init_timer(timer, tick) \
> +               hv_set_vpreg(HV_REGISTER_STIMER0_COUNT + (2*timer), tick)
> +#define hv_init_timer_config(timer, val) \
> +               hv_set_vpreg(HV_REGISTER_STIMER0_CONFIG + (2*timer), val)
> +#define hv_get_current_tick(tick) \
> +               (tick = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))

In general, we prefer inline functions over macros in header files.

> +#if IS_ENABLED(CONFIG_HYPERV)
> +#define hv_enable_stimer0_percpu_irq(irq)      enable_percpu_irq(irq, 0)
> +#define hv_disable_stimer0_percpu_irq(irq)     disable_percpu_irq(irq)
> +#endif

Should there be an #else definition here? It helps readability
to have the two versions (with and without hyperv support) close
together rather than in different files. If there is no other
definition, just drop the #if.

     Arnd
