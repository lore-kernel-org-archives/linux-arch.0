From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 14/17] dt: Consolidate __dtb_start declarations in <linux/of_fdt.h>
Date: Wed, 13 Nov 2013 09:51:28 -0600
Message-ID: <5283A000.8090007@gmail.com>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org> <1384285347-13506-15-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384285347-13506-15-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 12, 2013 at 1:42 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> The different architectures used their own (and different) declarations:
>
>     extern struct boot_param_header __dtb_start;
>     extern u32 __dtb_start[];
>     extern char __dtb_start[];
>
> Consolidate them using the first variant in <linux/of_fdt.h>.
> This requires adding a few "address of" operators on architectures where
> __dtb_start was an array before.
>
> Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> Cc: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> Cc: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
> CC: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  arch/arc/include/asm/sections.h             |    1 -
>  arch/arc/kernel/setup.c                     |    2 +-
>  arch/metag/kernel/setup.c                   |    6 +-----
>  arch/mips/include/asm/mips-boards/generic.h |    4 ----
>  arch/mips/lantiq/prom.h                     |    2 --
>  arch/mips/netlogic/xlp/dt.c                 |    4 ++--
>  arch/mips/ralink/of.c                       |    2 --
>  arch/openrisc/kernel/setup.c                |    2 +-
>  arch/openrisc/kernel/vmlinux.h              |    2 --
>  arch/xtensa/kernel/setup.c                  |    3 +--
>  include/linux/of_fdt.h                      |    3 +++
>  11 files changed, 9 insertions(+), 22 deletions(-)

This is great, but I would like to see this taken one step further and
move the selection logic into the core code. We can try to use the
built-in dtb if early_init_dt_scan is passed a NULL or invalid dtb. This
should work for most arches I think and still allows an arch to do a
different selection algorithm if desired.

Are the DT related patches dependent on the rest of the series?

Something like this is what I have in mind:

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 5c47910..723f854d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -869,14 +869,16 @@ void * __init __weak
early_init_dt_alloc_memory_arch(u64 size, u64 align)

 bool __init early_init_dt_scan(void *params)
 {
-	if (!params)
-		return false;
-
 	/* Setup flat device-tree pointer */
 	initial_boot_params = params;

+	if (!initial_boot_params ||
+	    (be32_to_cpu(initial_boot_params->magic) != OF_DT_HEADER))
+		initial_boot_params = &__dtb_start;
+
 	/* check device tree validity */
-	if (be32_to_cpu(initial_boot_params->magic) != OF_DT_HEADER) {
+	if (!initial_boot_params ||
+	    (be32_to_cpu(initial_boot_params->magic) != OF_DT_HEADER)) {
 		initial_boot_params = NULL;
 		return false;
 	}
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
