From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/10] char: Use get_unaligned_* helpers
Date: Mon, 14 Apr 2008 09:37:53 -0700
Message-ID: <1208191074.5721.23.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Remove unnecessary temp variable from_buf in snsc_event.c

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
All ten patches depend on the introduction of the new unaligned access
helpers I sent out last week.  This is a demonstration of the users of
the api.

 drivers/char/rocket_int.h |    2 +-
 drivers/char/snsc_event.c |   10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/rocket_int.h b/drivers/char/rocket_int.h
index b01d381..143cc43 100644
--- a/drivers/char/rocket_int.h
+++ b/drivers/char/rocket_int.h
@@ -55,7 +55,7 @@ static inline void sOutW(unsigned short port, unsigned short value)
 
 static inline void out32(unsigned short port, Byte_t *p)
 {
-	u32 value = le32_to_cpu(get_unaligned((__le32 *)p));
+	u32 value = get_unaligned_le32(p);
 #ifdef ROCKET_DEBUG_IO
 	printk(KERN_DEBUG "out32(%x, %lx)...\n", port, value);
 #endif
diff --git a/drivers/char/snsc_event.c b/drivers/char/snsc_event.c
index 1b75b0b..31a7765 100644
--- a/drivers/char/snsc_event.c
+++ b/drivers/char/snsc_event.c
@@ -63,16 +63,13 @@ static int
 scdrv_parse_event(char *event, int *src, int *code, int *esp_code, char *desc)
 {
 	char *desc_end;
-	__be32 from_buf;
 
 	/* record event source address */
-	from_buf = get_unaligned((__be32 *)event);
-	*src = be32_to_cpup(&from_buf);
+	*src = get_unaligned_be32(event);
 	event += 4; 			/* move on to event code */
 
 	/* record the system controller's event code */
-	from_buf = get_unaligned((__be32 *)event);
-	*code = be32_to_cpup(&from_buf);
+	*code = get_unaligned_be32(event);
 	event += 4;			/* move on to event arguments */
 
 	/* how many arguments are in the packet? */
@@ -86,8 +83,7 @@ scdrv_parse_event(char *event, int *src, int *code, int *esp_code, char *desc)
 		/* not an integer argument, so give up */
 		return -1;
 	}
-	from_buf = get_unaligned((__be32 *)event);
-	*esp_code = be32_to_cpup(&from_buf);
+	*esp_code = get_unaligned_be32(event);
 	event += 4;
 
 	/* parse out the event description */
-- 
1.5.5.144.g3e42
