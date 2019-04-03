Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:43424 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCT3Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 15:29:24 -0400
From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: fix memory nodes topology in case of highmem
 enabled
Date: Wed, 3 Apr 2019 19:29:22 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146440183@US01WEMBX2.internal.synopsys.com>
References: <20190401184242.7636-1-Eugeniy.Paltsev@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <alexey.brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Message-ID: <20190403192922.CJvT0FGuBsEfsTIR6NsgC5_hLb0MSahsGPm6XifhziM@z>

On 4/1/19 11:43 AM, Eugeniy Paltsev wrote:=0A=
> Tweak generic node topology in case of CONFIG_HIGHMEM enabled to=0A=
> prioritize allocations from ZONE_HIGHMEM to avoid ZONE_NORMAL=0A=
> pressure.=0A=
=0A=
Can you explain the "pressure" part a bit more concretely - as in when did =
you saw=0A=
crashes, oom, yadi yada ....=0A=
=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
> Tested on both NSIM and HSDK (require memory apertures remmaping and=0A=
> device tree patching)=0A=
=0A=
How can one test this patch w/o those - are they secret which rest of world=
 should=0A=
not know about :-)=0A=
Jokes apart, at the very least, please include them as part of changelog "a=
s=0A=
indicative code" which people can use in testing if needed.=0A=
Preferably they need to be part of platform code under the right config (HI=
GHMEM +=0A=
PAE etc)=0A=
=0A=
FWIW as mentioned on other thread, for my setup of PAE + 2GB  HIGHMEM (so 2=
 nodes)=0A=
1. I didn't need any AXI aperture remapping=0A=
2. Didn't see any extra mem pressure / failures when running glibc testsuit=
e=0A=
=0A=
>=0A=
>  arch/arc/include/asm/Kbuild     |  1 -=0A=
>  arch/arc/include/asm/topology.h | 30 ++++++++++++++++++++++++++++++=0A=
>  2 files changed, 30 insertions(+), 1 deletion(-)=0A=
>  create mode 100644 arch/arc/include/asm/topology.h=0A=
>=0A=
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild=0A=
> index caa270261521..e64e0439baff 100644=0A=
> --- a/arch/arc/include/asm/Kbuild=0A=
> +++ b/arch/arc/include/asm/Kbuild=0A=
> @@ -18,7 +18,6 @@ generic-y +=3D msi.h=0A=
>  generic-y +=3D parport.h=0A=
>  generic-y +=3D percpu.h=0A=
>  generic-y +=3D preempt.h=0A=
> -generic-y +=3D topology.h=0A=
>  generic-y +=3D trace_clock.h=0A=
>  generic-y +=3D user.h=0A=
>  generic-y +=3D vga.h=0A=
> diff --git a/arch/arc/include/asm/topology.h b/arch/arc/include/asm/topol=
ogy.h=0A=
> new file mode 100644=0A=
> index 000000000000..c273506931c9=0A=
> --- /dev/null=0A=
> +++ b/arch/arc/include/asm/topology.h=0A=
> @@ -0,0 +1,30 @@=0A=
> +#ifndef _ASM_ARC_TOPOLOGY_H=0A=
> +#define _ASM_ARC_TOPOLOGY_H=0A=
> +=0A=
> +/*=0A=
> + * On ARC (w/o PAE) HIGHMEM addresses are smaller (0x0 based) than addre=
sses in=0A=
> + * NORMAL aka low memory (0x8000_0000 based).=0A=
> + * Thus HIGHMEM on ARC is imlemented with DISCONTIGMEM which requires mu=
ltiple=0A=
=0A=
s/imlemented/implemented=0A=
> + * nodes. So here is memory node map depending on the CONFIG_HIGHMEM=0A=
> + * enabled/disabled:=0A=
> + *=0A=
> + * CONFIG_HIGHMEM disabled:=0A=
> + *  - node 0: ZONE_NORMAL memory only.=0A=
> + *=0A=
> + * CONFIG_HIGHMEM enabled:=0A=
> + *  - node 0: ZONE_NORMAL memory only.=0A=
> + *  - node 1: ZONE_HIGHMEM memory only.=0A=
=0A=
Perhaps we could reduce the text above by having 2 lines and adding a "()" =
comment=0A=
for node 1=0A=
=0A=
+ *  - node 0: ZONE_NORMAL memory  (always)=0A=
+ *  - node 1: ZONE_HIGHMEM memory (HIGHMEM only)=0A=
=0A=
=0A=
=0A=
> + *=0A=
> + * In case of CONFIG_HIGHMEM enabled we tweak generic node topology and =
mark=0A=
> + * node 1 as the closest to all CPUs to prioritize allocations from ZONE=
_HIGHMEM=0A=
> + * where it is possible to avoid ZONE_NORMAL pressure.=0A=
> + */=0A=
> +#ifdef CONFIG_HIGHMEM=0A=
> +#define cpu_to_node(cpu)	((void)(cpu), 1)=0A=
> +#define cpu_to_mem(cpu)		((void)(cpu), 1)=0A=
> +#define cpumask_of_node(node)	((node) =3D=3D 1 ? cpu_online_mask : cpu_n=
one_mask)=0A=
> +#endif /* CONFIG_HIGHMEM */=0A=
> +=0A=
> +#include <asm-generic/topology.h>=0A=
> +=0A=
> +#endif /* _ASM_ARC_TOPOLOGY_H */=0A=
=0A=
Otherwise LGTM. I would like to give this a spin myself, but first need to =
know=0A=
what tests cause the increased failures which this patch mitigates.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
