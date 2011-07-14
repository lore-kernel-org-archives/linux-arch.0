From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2.5/13] memblock: Use __meminit[data] instead of __init[data]
Date: Thu, 14 Jul 2011 14:00:51 -0700
Message-ID: <CAE9FiQU92k-GAy3DVB4HYpn6D6_u=4T7t9_8FOGh8BLDEAKD=Q@mail.gmail.com>
References: <1310462166-31469-1-git-send-email-tj@kernel.org>
	<20110714094203.GE3455@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65276 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab1GNVAw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2011 17:00:52 -0400
In-Reply-To: <20110714094203.GE3455@htj.dyndns.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, benh@kernel.crashing.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On Thu, Jul 14, 2011 at 2:42 AM, Tejun Heo <tj@kernel.org> wrote:
> From 19ab281ed67b87a6623d725237a7333ca79f1e75 Mon Sep 17 00:00:00 200=
1
> From: Tejun Heo <tj@kernel.org>
> Date: Thu, 14 Jul 2011 11:22:16 +0200
>
> memblock will be extended to include early_node_map[], which is also
> used during memory hotplug. =A0Make memblock use __meminit[data] inst=
ead
> of __init[data] so that memory hotplug code can safely reference it.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> =A0include/linux/memblock.h | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index aa5df9e..434b958 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -152,8 +152,8 @@ static inline unsigned long memblock_region_reser=
ved_end_pfn(const struct memblo
>
>
> =A0#ifdef ARCH_DISCARD_MEMBLOCK
> -#define __init_memblock __init
> -#define __initdata_memblock __initdata
> +#define __init_memblock __meminit
> +#define __initdata_memblock __meminitdata
> =A0#else
> =A0#define __init_memblock
> =A0#define __initdata_memblock

that is not good. It will keep memblock.reserved related data and
functions after boot.
and those data/func are not used after slab is ready.

Thanks

Yinghai
