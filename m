Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Changing  update_mmu_cache()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 15:53:17 +1100
Message-Id: <1109047997.5327.70.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

Hi !

I'm doing some work on the ppc32 MMU stuff and I'm faced to a problem
related to HIGHMEM, and more specifically to PTE pages in HIGHMEM: 

update_mmu_cache() currently doesn't take the pte pointer. This means it
has to look it up on ppc, and eventually map the pte page (gack !). But
if you look at all the call sites for update_mmu_cache, they all have
the pte pointer and the PTE page already kmap'ed either just before or
around the call to update_mmu_cache().

My changes require me to write to the PTE (well, we already did that but
with MMU off which was sort-of ok, but my new code is different) in
update_mmu_cache().

So I want to change all call sites to pass the ptep to
update_mmu_cache() with the semantics that it will always be kmap'ed by
the caller.

Is that ok with everybody ?

Ben.
