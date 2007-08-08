Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32222 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755873AbXHHXEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Aug 2007 19:04:46 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Needs review from arm, sparc, pa-risc, sh, xtensa (virtual indexed cache issue in page migration)
Date: Wed, 8 Aug 2007 16:04:44 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A0221324E@scsmsx411.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-ID: <linux-arch.vger.kernel.org>

This didn't raise any comment on LKML ... probably the
"ia64" in the Subject: deterred you all from reading it :-)

I don't think I understand either the migration code or the
virtual indexed cache issues well enough to figure this out.

Part 2of2 goes on to mess further with this code to cope with
the idiosyncracies on ia64 (keeping icache and dcache coherent).

-Tony

>-----Original Message-----
>From: KAMEZAWA Hiroyuki [mailto:kamezawa.hiroyu@jp.fujitsu.com] 
>Sent: Tuesday, August 07, 2007 1:27 AM
>To: KAMEZAWA Hiroyuki
>Cc: linux-kernel@vger.kernel.org; linux-ia64@vger.kernel.org; 
>Luck, Tony; Zoltan.Menyhart@bull.net
>Subject: [BUGFIX][PATCH] flush icache before set_pte() in ia64 
>take7, [1/2] migration fix
>
>In migration, a new page should be cache flushed before set_pte()
>in some archs which have virtually-tagged cache..
>
>V6 -> V7:
>   * adjusted against .2.6.23-rc2.
>
>V5 -> V6:
>   * no changes (added new patches to the patch set)
>V4 -> V5:
>   * changed flush_icache_page to flush_cache_page.
>
>Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>
>---
> mm/migrate.c |    1 +
> 1 file changed, 1 insertion(+)
>
>Index: linux-2.6.23-rc2.test/mm/migrate.c
>===================================================================
>--- linux-2.6.23-rc2.test.orig/mm/migrate.c
>+++ linux-2.6.23-rc2.test/mm/migrate.c
>@@ -171,6 +171,7 @@ static void remove_migration_pte(struct 
> 	pte = pte_mkold(mk_pte(new, vma->vm_page_prot));
> 	if (is_write_migration_entry(entry))
> 		pte = pte_mkwrite(pte);
>+	flush_cache_page(vma, addr, pte_pfn(pte));
> 	set_pte_at(mm, addr, ptep, pte);
> 
> 	if (PageAnon(new))
>
