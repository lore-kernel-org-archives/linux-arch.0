Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 21 Jun 2005 02:13:52 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: sparsemem patches in -mm
Message-Id: <20050621021352.46fc3b81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>, Matt Tolentino <matthew.e.tolentino@intel.com>, Bob Picco <bob.picco@hp.com>
List-ID: <linux-arch.vger.kernel.org>


Could I ask the arch maintainers to review the `sparsemem' patches from -mm,
please, if you haven't done so...

They're all in http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/

Applying order is:

http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/remove-non-discontig-use-of-pgdat-node_mem_map.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/resubmit-sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/resubmit-sparsemem-base-simple-numa-remap-space-allocator.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/resubmit-sparsemem-base-reorganize-page-flags-bit-operations.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/resubmit-sparsemem-base-teach-discontig-about-sparse-ranges.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/create-mm-kconfig-for-arch-independent-memory-options.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/make-each-arch-use-mm-kconfig.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/update-all-defconfigs-for-arch_discontigmem_enable.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/introduce-new-kconfig-option-for-numa-or-discontig.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/sparsemem-fix-minor-defaults-issue-in-mm-kconfig.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/mm-kconfig-kill-unused-arch_flatmem_disable.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/mm-kconfig-hide-memory-model-selection-menu.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/mm-kconfig-give-discontig-more-help-text.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/ppc64-kconfig-memory-models.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/generify-early_pfn_to_nid.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/generify-memory-present.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/sparsemem-memory-model.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/sparsemem-memory-model-for-i386.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/sparsemem-swiss-cheese-numa-layouts.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/sparsemem-hotplug-base.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/ppc64-add-early_pfn_to_nid.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/ppc64-add-memory-present.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/ppc64-sparsemem-memory-model.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/sparsemem-extreme.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/remove-direct-ref-to-contig_page_data-for-x86-64.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/add-x86-64-kconfig-options-for-sparsemem.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/reorganize-x86-64-numa-and-discontigmem-config-options.patch
http://www.zip.com.au/~akpm/linux/patches/stuff/sparsemem/add-x86-64-specific-support-for-sparsemem.patch

Thanks.
