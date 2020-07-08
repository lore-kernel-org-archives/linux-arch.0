From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH -next] Documentation/vm: fix tables in
 arch_pgtable_helpers
Date: Wed, 8 Jul 2020 12:10:20 +0530
Message-ID: <d225534c-5214-9f05-d6b6-36f48c67d9c4@arm.com>
References: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:46242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgGHGkp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Jul 2020 02:40:45 -0400
In-Reply-To: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mike Rapoport <rppt@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>



On 07/08/2020 06:37 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Make the tables be presented as tables in the generated output files
> (the line drawing did not present well).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Documentation/vm/arch_pgtable_helpers.rst |  333 ++++++--------------
>  1 file changed, 116 insertions(+), 217 deletions(-)
> 
> --- linux-next-20200707.orig/Documentation/vm/arch_pgtable_helpers.rst
> +++ linux-next-20200707/Documentation/vm/arch_pgtable_helpers.rst
> @@ -17,242 +17,141 @@ test need to be in sync.
>  PTE Page Table Helpers
>  ======================
>  
> ---------------------------------------------------------------------------------
> -| pte_same                  | Tests whether both PTE entries are the same      |
> ---------------------------------------------------------------------------------
> -| pte_bad                   | Tests a non-table mapped PTE                     |
> ---------------------------------------------------------------------------------
> -| pte_present               | Tests a valid mapped PTE                         |
> ---------------------------------------------------------------------------------
> -| pte_young                 | Tests a young PTE                                |
> ---------------------------------------------------------------------------------
> -| pte_dirty                 | Tests a dirty PTE                                |
> ---------------------------------------------------------------------------------
> -| pte_write                 | Tests a writable PTE                             |
> ---------------------------------------------------------------------------------
> -| pte_special               | Tests a special PTE                              |
> ---------------------------------------------------------------------------------
> -| pte_protnone              | Tests a PROT_NONE PTE                            |
> ---------------------------------------------------------------------------------
> -| pte_devmap                | Tests a ZONE_DEVICE mapped PTE                   |
> ---------------------------------------------------------------------------------
> -| pte_soft_dirty            | Tests a soft dirty PTE                           |
> ---------------------------------------------------------------------------------
> -| pte_swp_soft_dirty        | Tests a soft dirty swapped PTE                   |
> ---------------------------------------------------------------------------------
> -| pte_mkyoung               | Creates a young PTE                              |
> ---------------------------------------------------------------------------------
> -| pte_mkold                 | Creates an old PTE                               |
> ---------------------------------------------------------------------------------
> -| pte_mkdirty               | Creates a dirty PTE                              |
> ---------------------------------------------------------------------------------
> -| pte_mkclean               | Creates a clean PTE                              |
> ---------------------------------------------------------------------------------
> -| pte_mkwrite               | Creates a writable PTE                           |
> ---------------------------------------------------------------------------------
> -| pte_mkwrprotect           | Creates a write protected PTE                    |
> ---------------------------------------------------------------------------------
> -| pte_mkspecial             | Creates a special PTE                            |
> ---------------------------------------------------------------------------------
> -| pte_mkdevmap              | Creates a ZONE_DEVICE mapped PTE                 |
> ---------------------------------------------------------------------------------
> -| pte_mksoft_dirty          | Creates a soft dirty PTE                         |
> ---------------------------------------------------------------------------------
> -| pte_clear_soft_dirty      | Clears a soft dirty PTE                          |
> ---------------------------------------------------------------------------------
> -| pte_swp_mksoft_dirty      | Creates a soft dirty swapped PTE                 |
> ---------------------------------------------------------------------------------
> -| pte_swp_clear_soft_dirty  | Clears a soft dirty swapped PTE                  |
> ---------------------------------------------------------------------------------
> -| pte_mknotpresent          | Invalidates a mapped PTE                         |
> ---------------------------------------------------------------------------------
> -| ptep_get_and_clear        | Clears a PTE                                     |
> ---------------------------------------------------------------------------------
> -| ptep_get_and_clear_full   | Clears a PTE                                     |
> ---------------------------------------------------------------------------------
> -| ptep_test_and_clear_young | Clears young from a PTE                          |
> ---------------------------------------------------------------------------------
> -| ptep_set_wrprotect        | Converts into a write protected PTE              |
> ---------------------------------------------------------------------------------
> -| ptep_set_access_flags     | Converts into a more permissive PTE              |
> ---------------------------------------------------------------------------------
> +===========================   ================================================
> +pte_same                      Tests whether both PTE entries are the same
> +pte_bad                       Tests a non-table mapped PTE
> +pte_present                   Tests a valid mapped PTE
> +pte_young                     Tests a young PTE
> +pte_dirty                     Tests a dirty PTE
> +pte_write                     Tests a writable PTE
> +pte_special                   Tests a special PTE
> +pte_protnone                  Tests a PROT_NONE PTE
> +pte_devmap                    Tests a ZONE_DEVICE mapped PTE
> +pte_soft_dirty                Tests a soft dirty PTE
> +pte_swp_soft_dirty            Tests a soft dirty swapped PTE
> +pte_mkyoung                   Creates a young PTE
> +pte_mkold                     Creates an old PTE
> +pte_mkdirty                   Creates a dirty PTE
> +pte_mkclean                   Creates a clean PTE
> +pte_mkwrite                   Creates a writable PTE
> +pte_mkwrprotect               Creates a write protected PTE
> +pte_mkspecial                 Creates a special PTE
> +pte_mkdevmap                  Creates a ZONE_DEVICE mapped PTE
> +pte_mksoft_dirty              Creates a soft dirty PTE
> +pte_clear_soft_dirty          Clears a soft dirty PTE
> +pte_swp_mksoft_dirty          Creates a soft dirty swapped PTE
> +pte_swp_clear_soft_dirty      Clears a soft dirty swapped PTE
> +pte_mknotpresent              Invalidates a mapped PTE
> +ptep_get_and_clear            Clears a PTE
> +ptep_get_and_clear_full       Clears a PTE
> +ptep_test_and_clear_young     Clears young from a PTE
> +ptep_set_wrprotect            Converts into a write protected PTE
> +ptep_set_access_flags         Converts into a more permissive PTE
> +===========================   ================================================
>  
>  ======================
>  PMD Page Table Helpers
>  ======================
>  
> ---------------------------------------------------------------------------------
> -| pmd_same                  | Tests whether both PMD entries are the same      |
> ---------------------------------------------------------------------------------
> -| pmd_bad                   | Tests a non-table mapped PMD                     |
> ---------------------------------------------------------------------------------
> -| pmd_leaf                  | Tests a leaf mapped PMD                          |
> ---------------------------------------------------------------------------------
> -| pmd_huge                  | Tests a HugeTLB mapped PMD                       |
> ---------------------------------------------------------------------------------
> -| pmd_trans_huge            | Tests a Transparent Huge Page (THP) at PMD       |
> ---------------------------------------------------------------------------------
> -| pmd_present               | Tests a valid mapped PMD                         |
> ---------------------------------------------------------------------------------
> -| pmd_young                 | Tests a young PMD                                |
> ---------------------------------------------------------------------------------
> -| pmd_dirty                 | Tests a dirty PMD                                |
> ---------------------------------------------------------------------------------
> -| pmd_write                 | Tests a writable PMD                             |
> ---------------------------------------------------------------------------------
> -| pmd_special               | Tests a special PMD                              |
> ---------------------------------------------------------------------------------
> -| pmd_protnone              | Tests a PROT_NONE PMD                            |
> ---------------------------------------------------------------------------------
> -| pmd_devmap                | Tests a ZONE_DEVICE mapped PMD                   |
> ---------------------------------------------------------------------------------
> -| pmd_soft_dirty            | Tests a soft dirty PMD                           |
> ---------------------------------------------------------------------------------
> -| pmd_swp_soft_dirty        | Tests a soft dirty swapped PMD                   |
> ---------------------------------------------------------------------------------
> -| pmd_mkyoung               | Creates a young PMD                              |
> ---------------------------------------------------------------------------------
> -| pmd_mkold                 | Creates an old PMD                               |
> ---------------------------------------------------------------------------------
> -| pmd_mkdirty               | Creates a dirty PMD                              |
> ---------------------------------------------------------------------------------
> -| pmd_mkclean               | Creates a clean PMD                              |
> ---------------------------------------------------------------------------------
> -| pmd_mkwrite               | Creates a writable PMD                           |
> ---------------------------------------------------------------------------------
> -| pmd_mkwrprotect           | Creates a write protected PMD                    |
> ---------------------------------------------------------------------------------
> -| pmd_mkspecial             | Creates a special PMD                            |
> ---------------------------------------------------------------------------------
> -| pmd_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
> ---------------------------------------------------------------------------------
> -| pmd_mksoft_dirty          | Creates a soft dirty PMD                         |
> ---------------------------------------------------------------------------------
> -| pmd_clear_soft_dirty      | Clears a soft dirty PMD                          |
> ---------------------------------------------------------------------------------
> -| pmd_swp_mksoft_dirty      | Creates a soft dirty swapped PMD                 |
> ---------------------------------------------------------------------------------
> -| pmd_swp_clear_soft_dirty  | Clears a soft dirty swapped PMD                  |
> ---------------------------------------------------------------------------------
> -| pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
> ---------------------------------------------------------------------------------
> -| pmd_set_huge              | Creates a PMD huge mapping                       |
> ---------------------------------------------------------------------------------
> -| pmd_clear_huge            | Clears a PMD huge mapping                        |
> ---------------------------------------------------------------------------------
> -| pmdp_get_and_clear        | Clears a PMD                                     |
> ---------------------------------------------------------------------------------
> -| pmdp_get_and_clear_full   | Clears a PMD                                     |
> ---------------------------------------------------------------------------------
> -| pmdp_test_and_clear_young | Clears young from a PMD                          |
> ---------------------------------------------------------------------------------
> -| pmdp_set_wrprotect        | Converts into a write protected PMD              |
> ---------------------------------------------------------------------------------
> -| pmdp_set_access_flags     | Converts into a more permissive PMD              |
> ---------------------------------------------------------------------------------
> +===========================   ================================================
> +pmd_same                      Tests whether both PMD entries are the same
> +pmd_bad                       Tests a non-table mapped PMD
> +pmd_leaf                      Tests a leaf mapped PMD
> +pmd_huge                      Tests a HugeTLB mapped PMD
> +pmd_trans_huge                Tests a Transparent Huge Page (THP) at PMD
> +pmd_present                   Tests a valid mapped PMD
> +pmd_young                     Tests a young PMD
> +pmd_dirty                     Tests a dirty PMD
> +pmd_write                     Tests a writable PMD
> +pmd_special                   Tests a special PMD
> +pmd_protnone                  Tests a PROT_NONE PMD
> +pmd_devmap                    Tests a ZONE_DEVICE mapped PMD
> +pmd_soft_dirty                Tests a soft dirty PMD
> +pmd_swp_soft_dirty            Tests a soft dirty swapped PMD
> +pmd_mkyoung                   Creates a young PMD
> +pmd_mkold                     Creates an old PMD
> +pmd_mkdirty                   Creates a dirty PMD
> +pmd_mkclean                   Creates a clean PMD
> +pmd_mkwrite                   Creates a writable PMD
> +pmd_mkwrprotect               Creates a write protected PMD
> +pmd_mkspecial                 Creates a special PMD
> +pmd_mkdevmap                  Creates a ZONE_DEVICE mapped PMD
> +pmd_mksoft_dirty              Creates a soft dirty PMD
> +pmd_clear_soft_dirty          Clears a soft dirty PMD
> +pmd_swp_mksoft_dirty          Creates a soft dirty swapped PMD
> +pmd_swp_clear_soft_dirty      Clears a soft dirty swapped PMD
> +pmd_mkinvalid                 Invalidates a mapped PMD [1]
> +pmd_set_huge                  Creates a PMD huge mapping
> +pmd_clear_huge                Clears a PMD huge mapping
> +pmdp_get_and_clear            Clears a PMD
> +pmdp_get_and_clear_full       Clears a PMD
> +pmdp_test_and_clear_young     Clears young from a PMD
> +pmdp_set_wrprotect            Converts into a write protected PMD
> +pmdp_set_access_flags         Converts into a more permissive PMD
> +===========================   ================================================
>  
>  ======================
>  PUD Page Table Helpers
>  ======================
>  
> ---------------------------------------------------------------------------------
> -| pud_same                  | Tests whether both PUD entries are the same      |
> ---------------------------------------------------------------------------------
> -| pud_bad                   | Tests a non-table mapped PUD                     |
> ---------------------------------------------------------------------------------
> -| pud_leaf                  | Tests a leaf mapped PUD                          |
> ---------------------------------------------------------------------------------
> -| pud_huge                  | Tests a HugeTLB mapped PUD                       |
> ---------------------------------------------------------------------------------
> -| pud_trans_huge            | Tests a Transparent Huge Page (THP) at PUD       |
> ---------------------------------------------------------------------------------
> -| pud_present               | Tests a valid mapped PUD                         |
> ---------------------------------------------------------------------------------
> -| pud_young                 | Tests a young PUD                                |
> ---------------------------------------------------------------------------------
> -| pud_dirty                 | Tests a dirty PUD                                |
> ---------------------------------------------------------------------------------
> -| pud_write                 | Tests a writable PUD                             |
> ---------------------------------------------------------------------------------
> -| pud_devmap                | Tests a ZONE_DEVICE mapped PUD                   |
> ---------------------------------------------------------------------------------
> -| pud_mkyoung               | Creates a young PUD                              |
> ---------------------------------------------------------------------------------
> -| pud_mkold                 | Creates an old PUD                               |
> ---------------------------------------------------------------------------------
> -| pud_mkdirty               | Creates a dirty PUD                              |
> ---------------------------------------------------------------------------------
> -| pud_mkclean               | Creates a clean PUD                              |
> ---------------------------------------------------------------------------------
> -| pud_mkwrite               | Creates a writable PMD                           |
> ---------------------------------------------------------------------------------
> -| pud_mkwrprotect           | Creates a write protected PMD                    |
> ---------------------------------------------------------------------------------
> -| pud_mkdevmap              | Creates a ZONE_DEVICE mapped PMD                 |
> ---------------------------------------------------------------------------------
> -| pud_mkinvalid             | Invalidates a mapped PUD [1]                     |
> ---------------------------------------------------------------------------------
> -| pud_set_huge              | Creates a PUD huge mapping                       |
> ---------------------------------------------------------------------------------
> -| pud_clear_huge            | Clears a PUD huge mapping                        |
> ---------------------------------------------------------------------------------
> -| pudp_get_and_clear        | Clears a PUD                                     |
> ---------------------------------------------------------------------------------
> -| pudp_get_and_clear_full   | Clears a PUD                                     |
> ---------------------------------------------------------------------------------
> -| pudp_test_and_clear_young | Clears young from a PUD                          |
> ---------------------------------------------------------------------------------
> -| pudp_set_wrprotect        | Converts into a write protected PUD              |
> ---------------------------------------------------------------------------------
> -| pudp_set_access_flags     | Converts into a more permissive PUD              |
> ---------------------------------------------------------------------------------
> +===========================   ================================================
> +pud_same                      Tests whether both PUD entries are the same
> +pud_bad                       Tests a non-table mapped PUD
> +pud_leaf                      Tests a leaf mapped PUD
> +pud_huge                      Tests a HugeTLB mapped PUD
> +pud_trans_huge                Tests a Transparent Huge Page (THP) at PUD
> +pud_present                   Tests a valid mapped PUD
> +pud_young                     Tests a young PUD
> +pud_dirty                     Tests a dirty PUD
> +pud_write                     Tests a writable PUD
> +pud_devmap                    Tests a ZONE_DEVICE mapped PUD
> +pud_mkyoung                   Creates a young PUD
> +pud_mkold                     Creates an old PUD
> +pud_mkdirty                   Creates a dirty PUD
> +pud_mkclean                   Creates a clean PUD

> +pud_mkwrite                   Creates a writable PMD
> +pud_mkwrprotect               Creates a write protected PMD
> +pud_mkdevmap                  Creates a ZONE_DEVICE mapped PMD

Three lines above should be change as s/PMD/PUD/. These typos are
present from the original patch.

> +pud_mkinvalid                 Invalidates a mapped PUD [1]
> +pud_set_huge                  Creates a PUD huge mapping
> +pud_clear_huge                Clears a PUD huge mapping
> +pudp_get_and_clear            Clears a PUD
> +pudp_get_and_clear_full       Clears a PUD
> +pudp_test_and_clear_young     Clears young from a PUD
> +pudp_set_wrprotect            Converts into a write protected PUD
> +pudp_set_access_flags         Converts into a more permissive PUD
> +===========================   ================================================
>  
>  ==========================
>  HugeTLB Page Table Helpers
>  ==========================
>  
> ---------------------------------------------------------------------------------
> -| pte_huge                  | Tests a HugeTLB                                  |
> ---------------------------------------------------------------------------------
> -| pte_mkhuge                | Creates a HugeTLB                                |
> ---------------------------------------------------------------------------------
> -| huge_pte_dirty            | Tests a dirty HugeTLB                            |
> ---------------------------------------------------------------------------------
> -| huge_pte_write            | Tests a writable HugeTLB                         |
> ---------------------------------------------------------------------------------
> -| huge_pte_mkdirty          | Creates a dirty HugeTLB                          |
> ---------------------------------------------------------------------------------
> -| huge_pte_mkwrite          | Creates a writable HugeTLB                       |
> ---------------------------------------------------------------------------------
> -| huge_pte_mkwrprotect      | Creates a write protected HugeTLB                |
> ---------------------------------------------------------------------------------
> -| huge_ptep_get_and_clear   | Clears a HugeTLB                                 |
> ---------------------------------------------------------------------------------
> -| huge_ptep_set_wrprotect   | Converts into a write protected HugeTLB          |
> ---------------------------------------------------------------------------------
> -| huge_ptep_set_access_flags  | Converts into a more permissive HugeTLB        |
> ---------------------------------------------------------------------------------
> +============================   ===============================================
> +pte_huge                       Tests a HugeTLB
> +pte_mkhuge                     Creates a HugeTLB
> +huge_pte_dirty                 Tests a dirty HugeTLB
> +huge_pte_write                 Tests a writable HugeTLB
> +huge_pte_mkdirty               Creates a dirty HugeTLB
> +huge_pte_mkwrite               Creates a writable HugeTLB
> +huge_pte_mkwrprotect           Creates a write protected HugeTLB
> +huge_ptep_get_and_clear        Clears a HugeTLB
> +huge_ptep_set_wrprotect        Converts into a write protected HugeTLB
> +huge_ptep_set_access_flags     Converts into a more permissive HugeTLB
> +============================   ===============================================
>  
>  ========================
>  SWAP Page Table Helpers
>  ========================
>  
> ---------------------------------------------------------------------------------
> -| __pte_to_swp_entry        | Creates a swapped entry (arch) from a mapepd PTE |
> ---------------------------------------------------------------------------------
> -| __swp_to_pte_entry        | Creates a mapped PTE from a swapped entry (arch) |
> ---------------------------------------------------------------------------------
> -| __pmd_to_swp_entry        | Creates a swapped entry (arch) from a mapepd PMD |
> ---------------------------------------------------------------------------------

s/mapepd/mapped.                                                        ^^^^^^^^^^

> -| __swp_to_pmd_entry        | Creates a mapped PMD from a swapped entry (arch) |
> ---------------------------------------------------------------------------------
> -| is_migration_entry        | Tests a migration (read or write) swapped entry  |
> ---------------------------------------------------------------------------------
> -| is_write_migration_entry  | Tests a write migration swapped entry            |
> ---------------------------------------------------------------------------------
> -| make_migration_entry_read | Converts into read migration swapped entry       |
> ---------------------------------------------------------------------------------
> -| make_migration_entry      | Creates a migration swapped entry (read or write)|
> ---------------------------------------------------------------------------------
> +==========================  =================================================
> +__pte_to_swp_entry          Creates a swapped entry (arch) from a mapepd PTE
> +__swp_to_pte_entry          Creates a mapped PTE from a swapped entry (arch)
> +__pmd_to_swp_entry          Creates a swapped entry (arch) from a mapepd PMD

Couple of original typos here as well - s/mapepd/mapped.             ^^^^^^^

> +__swp_to_pmd_entry          Creates a mapped PMD from a swapped entry (arch)
> +is_migration_entry          Tests a migration (read or write) swapped entry
> +is_write_migration_entry    Tests a write migration swapped entry
> +make_migration_entry_read   Converts into read migration swapped entry
> +make_migration_entry        Creates a migration swapped entry (read or write)
> +==========================  =================================================
>  
>  [1] https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com/

As this requires some typo fixes coming from the original patch, I could fold these
changes while adding your Signed-off-by: for relevant section and respin the series.
Please suggest.
