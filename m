From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2] x86: PAT: Documentation: rewrite "MTRR effects on PAT / non-PAT systems"
Date: Fri,  4 Mar 2016 14:45:01 -0800
Message-ID: <1457131501-14855-1-git-send-email-mcgrof@kernel.org>
References: <20160304210900.GT3577@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160304210900.GT3577@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com, bp@alien8.de, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, toshi.kani@hp.com
Cc: airlied@redhat.com, benh@kernel.crashing.org, mst@redhat.com, vinod.koul@intel.com, jgross@suse.com, daniel.vetter@ffwll.ch, luto@amacapital.net, davem@davemloft.net, ben@decadent.org.uk, benjamin.poirier@gmail.com, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-arch.vger.kernel.org

The current documentation refers to using set_memory_wc() as a
possible hole strategy when you have overlapping ioremap() regions,
that's incorrect as set_memory_*() helpers can only be used on RAM,
not IO memory. Using set_memory_wc() will not fail, that's a problem
which must be corrected in the future. This fixes that, and updates
the documention to *strongly* discourage overlapping ioremap() memory
uses, but also documents a possible solution should there really be
no other option to remain compatible on both PAT and MTRR memory
constarained systems. While at it, this provides some same guidlines
to system designers to remain sane and compatible on both PAT and
non-PAT systems.

As per Toshi this also fixes the table for the effective memory type
when using MTRR WC on PAT UC- to WC.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/x86/pat.txt | 54 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/Documentation/x86/pat.txt b/Documentation/x86/pat.txt
index 54944c71b819..6323f24f3b59 100644
--- a/Documentation/x86/pat.txt
+++ b/Documentation/x86/pat.txt
@@ -112,19 +112,47 @@ before the page is freed to free pool.
 MTRR effects on PAT / non-PAT systems
 -------------------------------------
 
+As of v4.3 mtrr_add() has been phased out in favor of arch_phys_wc_add(),
+these calls are a no-op on PAT enabled systems but remain MTRR effective
+on non-PAT systems. In order for this to work properly on both PAT and
+non-PAT systems the region over which an arch_phys_wc_add() is made should be
+ioremapped with WC attributes or PAT entries, using ioremap_wc().
+
+To enable simplifying device drivers, and to help support PAT and remain
+compatible with non-PAT systems, PCI devices are encouraged to dedicate a full
+PCI bar for different intended regions of IO, for instance one PCI BAR for
+MMIO and another PCI BAR for write-combing, if needed.
+
+Firmware should always expose to the operating system where write-combining is
+desirable, otherwise PAT cannot be supported, PAT systems need to know the
+physical address of the area where write-combining is desirable.
+
+Devices which use a single PCI BAR to combine different areas of IO memory
+must use separate ioremap() calls for each type of intended IO memory.
+Physically overlapping ioremap calls are strongly discouraged and may soon be
+disallowed. Devices that have one PCI BAR with an area of IO where
+write-combining is desirable followed contiguously by an area of MMIO
+should ioremap_wc() only on the area where write-combining is desired,
+followed by a physically non-overlapping ioremap_uc() for MMIO. Since MTRR
+calls are limited, and since MTRR calls must be done with orders of power of 2
+on both the size and base address one may be constrained to use just one MTRR
+call which will include the full MMIO range. In such cases, in order to remain
+compatible with PAT and functional on non-PAT systems arch_phys_wc_add() can
+be used to enable MTRR WC on the entire PCI BAR for all the combined IO range
+(both write-combining and MMIO range). Using ioremap_uc() ensures that a
+MTRR WC applied to it effectively yields UC, while using ioremap_wc()
+white-lists the MTRR WC effects over its region. For an example of this
+strategy refer to commit 3cc2dac5be ("drivers/video/fbdev/atyfb: Replace
+MTRR UC hole with strong UC"). Such use is nevertheless heavily discouraged
+as the effective memory type for the write-combined area on non-PAT is
+technically considered implementation defined. This strategy should only be
+used used as a last resort measure.
+
+You cannot use set_memory_*() helpers on ioremap'd regions (IO memory), even
+though its use currently gives no hint of an error.
+
 The following table provides the effects of using write-combining MTRRs when
-using ioremap*() calls on x86 for both non-PAT and PAT systems. Ideally
-mtrr_add() usage will be phased out in favor of arch_phys_wc_add() which will
-be a no-op on PAT enabled systems. The region over which a arch_phys_wc_add()
-is made, should already have been ioremapped with WC attributes or PAT entries,
-this can be done by using ioremap_wc() / set_memory_wc().  Devices which
-combine areas of IO memory desired to remain uncacheable with areas where
-write-combining is desirable should consider use of ioremap_uc() followed by
-set_memory_wc() to white-list effective write-combined areas.  Such use is
-nevertheless discouraged as the effective memory type is considered
-implementation defined, yet this strategy can be used as last resort on devices
-with size-constrained regions where otherwise MTRR write-combining would
-otherwise not be effective.
+using ioremap*() calls on x86 for both non-PAT and PAT systems.
 
 ----------------------------------------------------------------------
 MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
@@ -136,7 +164,7 @@ MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
      |||
 WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
 WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
-WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
+WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   WC
 WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
 ----------------------------------------------------------------------
 
-- 
2.7.2
