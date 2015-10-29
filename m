From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/2] asm/sections: Add helpers to check for section data
Date: Thu, 29 Oct 2015 09:26:06 +0100
Message-ID: <1446107167-7001-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add a helper to check if an object (given an address and a size) is part
of a section (given beginning and end addresses). For convenience, also
provide a helper that performs this check for __init data using the
__init_begin and __init_end limits.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/asm-generic/sections.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index b58fd667f87b..529909090cd6 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -63,4 +63,15 @@ static inline int arch_is_kernel_data(unsigned long addr)
 }
 #endif
 
+static inline bool section_contains(void *virt, size_t size, void *begin,
+				    void *end)
+{
+	return virt >= begin && virt + size <= end;
+}
+
+static inline bool init_section_contains(void *virt, size_t size)
+{
+	return section_contains(virt, size, __init_begin, __init_end);
+}
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
-- 
2.5.0
