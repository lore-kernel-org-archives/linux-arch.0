From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 06/15] Provide 16-bit ISO atomics
Date: Wed, 18 May 2016 16:11:22 +0100
Message-ID: <146358428286.8596.2865175107430611616.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

Provide an implementation of atomic_inc_short() using ISO atomics.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/iso-atomic16.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/asm-generic/iso-atomic16.h

diff --git a/include/asm-generic/iso-atomic16.h b/include/asm-generic/iso-atomic16.h
new file mode 100644
index 000000000000..383baaae7208
--- /dev/null
+++ b/include/asm-generic/iso-atomic16.h
@@ -0,0 +1,27 @@
+/* Use ISO C++11 intrinsics to implement 16-bit atomic ops.
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _ASM_GENERIC_ISO_ATOMIC16_H
+#define _ASM_GENERIC_ISO_ATOMIC16_H
+
+/**
+ * atomic_inc_short - increment of a short integer
+ * @v: pointer to type int
+ *
+ * Atomically adds 1 to @v
+ * Returns the new value of @v
+ */
+static __always_inline short int atomic_inc_short(short int *v)
+{
+	return __atomic_add_fetch(v, 1, __ATOMIC_SEQ_CST);
+}
+
+#endif /* _ASM_GENERIC_ISO_ATOMIC16_H */
