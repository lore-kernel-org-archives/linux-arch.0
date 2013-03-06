From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/4] UAPI: Fix endianness conditionals in linux/aio_abi.h
Date: Wed, 06 Mar 2013 20:47:33 +0000
Message-ID: <20130306204733.31327.97388.stgit@warthog.procyon.org.uk>
References: <20130306204724.31327.43118.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130306204724.31327.43118.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org, sfr@canb.auug.org.au, Joakim.Tjernlund@transmode.se, arnd@arndb.de, linux-aio@kvack.org, linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

In the UAPI header files, __BIG_ENDIAN and __LITTLE_ENDIAN must be compared
against __BYTE_ORDER in preprocessor conditionals where these are exposed to
userspace (that is they're not inside __KERNEL__ conditionals).

However, in the main kernel the norm is to check for "defined(__XXX_ENDIAN)"
rather than comparing against __BYTE_ORDER and this has incorrectly leaked
into the userspace headers.

The definition of PADDED() in linux/aio_abi.h is wrong in this way.  Note that
userspace will likely interpret this and thus the order of fields in struct
iocb incorrectly as the little-endian variant on big-endian machines -
depending on header inclusion order.

[!!!] NOTE [!!!]  This patch may adversely change the userspace API.  It might
be better to fix the ordering of aio_key and aio_reserved1 in struct iocb.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Benjamin LaHaise <bcrl@kvack.org>
cc: linux-aio@kvack.org
---

 include/uapi/linux/aio_abi.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index 86fa7a7..bb2554f 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -62,9 +62,9 @@ struct io_event {
 	__s64		res2;		/* secondary result */
 };
 
-#if defined(__LITTLE_ENDIAN)
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
 #define PADDED(x,y)	x, y
-#elif defined(__BIG_ENDIAN)
+#elif defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
 #define PADDED(x,y)	y, x
 #else
 #error edit for your odd byteorder.
