Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 17 Mar 2005 14:03:16 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Consolidation of asm/unaligned.h
Message-Id: <20050317140316.79210a73.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0503172255380.8760@numbat.sonytel.be>
References: <20050317104744.4be7e550.davem@davemloft.net>
	<Pine.LNX.4.62.0503172255380.8760@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 17 Mar 2005 22:57:25 +0100 (CET)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Thu, 17 Mar 2005, David S. Miller wrote:
> > 6) M68K can do unaligned access directly.
> 
> Just for the record, this is true for 68020 and later only. I.e. some MMU-less
> variants need unaligned support.

Thanks for the info.  I've just added the following diff
on top so that the COLDFIRE build uses the new generic
unaligned header.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/17 14:02:44-08:00 davem@sunset.davemloft.net 
#   [M68KNOMMU]: Use asm-generic/unaligned.h for COLDFIRE.
#   
#   Based upon comments from Geert Uytterhoeven.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# include/asm-m68knommu/unaligned.h
#   2005/03/17 14:02:09-08:00 davem@sunset.davemloft.net +1 -9
#   [M68KNOMMU]: Use asm-generic/unaligned.h for COLDFIRE.
# 
diff -Nru a/include/asm-m68knommu/unaligned.h b/include/asm-m68knommu/unaligned.h
--- a/include/asm-m68knommu/unaligned.h	2005-03-17 14:03:19 -08:00
+++ b/include/asm-m68knommu/unaligned.h	2005-03-17 14:03:19 -08:00
@@ -5,15 +5,7 @@
 
 #ifdef CONFIG_COLDFIRE
 
-/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
+#include <asm-generic/unaligned.h>
 
 #else
 /*
