From: David Howells <dhowells@redhat.com>
Subject: [PATCH 11/13] test_taint() should return bool
Date: Wed, 29 Apr 2015 20:22:40 +0100
Message-ID: <20150429192240.24909.93842.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

test_taint() should return bool as it returns a boolean value.  This allows
gcc to make better decisions about using the return value, though it might
make test_taint() itself slightly bigger.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/kernel.h |    2 +-
 kernel/panic.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3a5b48e52a9e..77670ddcd686 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -453,7 +453,7 @@ enum lockdep_ok {
 	LOCKDEP_NOW_UNRELIABLE
 };
 extern void add_taint(unsigned flag, enum lockdep_ok);
-extern int test_taint(unsigned flag);
+extern bool test_taint(unsigned flag);
 extern unsigned long get_taint(void);
 extern int root_mountflags;
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 8136ad76e5fd..17f056eab21a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -272,7 +272,7 @@ const char *print_tainted(void)
 	return buf;
 }
 
-int test_taint(unsigned flag)
+bool test_taint(unsigned flag)
 {
 	return test_bit(flag, &tainted_mask);
 }
