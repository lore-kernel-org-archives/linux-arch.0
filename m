From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC 05/10] tools: Add <endian.h> libc support for unaligned references
Date: Tue, 10 Jun 2014 16:13:09 -0700
Message-ID: <1402441994-16780-6-git-send-email-hpa@zytor.com>
References: <1402441994-16780-1-git-send-email-hpa@zytor.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1402441994-16780-1-git-send-email-hpa@zytor.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

Add support for the <endian.h> byteswap macros for unaligned
references.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 tools/include/tools/unaligned/be_endian.h | 40 +++++++++++++++++++++++++++++++
 tools/include/tools/unaligned/le_endian.h | 40 +++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tools/include/tools/unaligned/be_endian.h
 create mode 100644 tools/include/tools/unaligned/le_endian.h

diff --git a/tools/include/tools/unaligned/be_endian.h b/tools/include/tools/unaligned/be_endian.h
new file mode 100644
index 000000000000..4106c082855e
--- /dev/null
+++ b/tools/include/tools/unaligned/be_endian.h
@@ -0,0 +1,40 @@
+#ifndef _TOOLS_BE_ENDIAN_H
+#define _TOOLS_BE_ENDIAN_H
+
+#ifndef _BSD_SOURCE
+# define _BSD_SOURCE 1
+#endif
+#include <endian.h>
+#include <stdint.h>
+
+static inline uint16_t get_unaligned_be16(const void *_p)
+{
+	return be16toh(get_unaligned_le16(_p));
+}
+
+static inline uint32_t get_unaligned_be32(const void *_p)
+{
+	return be32toh(get_unaligned_le32(_p));
+}
+
+static inline uint64_t get_unaligned_be64(const void *_p)
+{
+	return be64toh(get_unaligned_le64(_p));
+}
+
+static inline void put_unaligned_be16(uint16_t val, void *_p)
+{
+	put_unaligned_le16(htobe16(val), _p);
+}
+
+static inline void put_unaligned_be32(uint32_t val, void *_p)
+{
+	put_unaligned_le32(htobe32(val), _p);
+}
+
+static inline void put_unaligned_be64(uint64_t val, void *_p)
+{
+	put_unaligned_le64(htobe64(val), _p);
+}
+
+#endif /* _TOOLS_BE_ENDIAN_H */
diff --git a/tools/include/tools/unaligned/le_endian.h b/tools/include/tools/unaligned/le_endian.h
new file mode 100644
index 000000000000..0429f1b29250
--- /dev/null
+++ b/tools/include/tools/unaligned/le_endian.h
@@ -0,0 +1,40 @@
+#ifndef _TOOLS_LE_ENDIAN_H
+#define _TOOLS_LE_ENDIAN_H
+
+#ifndef _BSD_SOURCE
+# define _BSD_SOURCE 1
+#endif
+#include <endian.h>
+#include <stdint.h>
+
+static inline uint16_t get_unaligned_le16(const void *_p)
+{
+	return le16toh(get_unaligned_be16(_p));
+}
+
+static inline uint32_t get_unaligned_le32(const void *_p)
+{
+	return le32toh(get_unaligned_be32(_p));
+}
+
+static inline uint64_t get_unaligned_le64(const void *_p)
+{
+	return le64toh(get_unaligned_be64(_p));
+}
+
+static inline void put_unaligned_le16(uint16_t val, void *_p)
+{
+	put_unaligned_be16(htole16(val), _p);
+}
+
+static inline void put_unaligned_le32(uint32_t val, void *_p)
+{
+	put_unaligned_be32(htole32(val), _p);
+}
+
+static inline void put_unaligned_le64(uint64_t val, void *_p)
+{
+	put_unaligned_be64(htole64(val), _p);
+}
+
+#endif /* _TOOLS_LE_ENDIAN_H */
-- 
1.9.3

