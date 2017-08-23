From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/ioapic: Correctly print IRTE's index field when
 enabling INTR
Date: Wed, 23 Aug 2017 10:16:39 +0200
Message-ID: <20170823081638.qcxex3576qkta3lb@gmail.com>
References: <CAHG4imNDzpDyOVi7MByVrLQ=QFuOVqpzJ5F-Xs5z6OZphubj-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34595 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbdHWIQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2017 04:16:42 -0400
Content-Disposition: inline
In-Reply-To: <CAHG4imNDzpDyOVi7MByVrLQ=QFuOVqpzJ5F-Xs5z6OZphubj-Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: raymond pang <raymondpangxd@gmail.com>
Cc: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org


* raymond pang <raymondpangxd@gmail.com> wrote:

> When enabling interrupt remap, IOAPIC's RTE contains interrupt_index
> field of IRTE. And this field is composed of index and index2 member of
> struct IR_IO_APIC_route_entry. Make io_apic_print_entries() correctly
> print interrupt index field.
> 
> Signed-off-by: Raymond Pang <raymondpangxd@gmail.com>
> ---
>  arch/x86/kernel/apic/io_apic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 237e9c2..70e48aa 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -1243,7 +1243,7 @@ static void io_apic_print_entries(unsigned int
> apic, unsigned int nr_entries)
>      entry.vector, entry.irr, entry.delivery_status);
>    if (ir_entry->format)
>     printk(KERN_DEBUG "%s, remapped, I(%04X),  Z(%X)\n",
> -          buf, (ir_entry->index << 15) | ir_entry->index,
> +          buf, (ir_entry->index2 << 15) | ir_entry->index,
>            ir_entry->zero);
>    else
>     printk(KERN_DEBUG "%s, %s, D(%02X), M(%1d)\n",

Applied.

[ Note that your patch was whitespace damaged (all tabs were converted to spaces), 
  I fixed that up manually. It's a pain to keep some mailers from doing that, see
  Documentation/process/email-clients.rst for best practices. ]

Thanks,

	Ingo
