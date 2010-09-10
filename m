From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/17] Drop a couple of unnecessary asm/system.h inclusions
Date: Fri, 10 Sep 2010 17:24:43 +0100
Message-ID: <20100910162443.20817.65678.stgit@warthog.procyon.org.uk>
References: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100910162407.20817.34359.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Greg Ungerer <gerg@uclinux.org>
List-Id: linux-arch.vger.kernel.org

Drop inclusions of asm/system.h from linux/hardirq.h and linux/list.h as
they're no longer required and prevent the M68K arch's IRQ flag handling macros
from being made into inlined functions due to circular dependencies.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Greg Ungerer <gerg@uclinux.org>
---

 include/linux/hardirq.h |    1 -
 include/linux/list.h    |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index d5b3876..7dfdc06 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -8,7 +8,6 @@
 #include <linux/lockdep.h>
 #include <linux/ftrace_irq.h>
 #include <asm/hardirq.h>
-#include <asm/system.h>
 
 /*
  * We put the hardirq and softirq counter into the preemption
diff --git a/include/linux/list.h b/include/linux/list.h
index d167b5d..88a0006 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -5,7 +5,6 @@
 #include <linux/stddef.h>
 #include <linux/poison.h>
 #include <linux/prefetch.h>
-#include <asm/system.h>
 
 /*
  * Simple doubly linked list implementation.
