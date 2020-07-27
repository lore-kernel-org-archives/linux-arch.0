From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC PATCH 5/5] mm: introduce MADV_DOEXEC
Date: Mon, 27 Jul 2020 10:11:27 -0700
Message-ID: <1595869887-23307-6-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
List-Id: linux-arch.vger.kernel.org

madvise MADV_DOEXEC preserves a memory range across exec.  Initially
only supported for non-executable, non-stack, anonymous memory.
MADV_DONTEXEC reverts the effect of a previous MADV_DOXEXEC call and
undoes the preservation of the range.  After a successful exec call,
the behavior of all ranges reverts to MADV_DONTEXEC.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/uapi/asm-generic/mman-common.h |  3 +++
 mm/madvise.c                           | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index f94f65d429be..7c5f616b28f7 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -72,6 +72,9 @@
 #define MADV_COLD	20		/* deactivate these pages */
 #define MADV_PAGEOUT	21		/* reclaim these pages */
 
+#define MADV_DOEXEC	22		/* do inherit across exec */
+#define MADV_DONTEXEC	23		/* don't inherit across exec */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index dd1d43cf026d..b447fa748649 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -103,6 +103,26 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	case MADV_KEEPONFORK:
 		new_flags &= ~VM_WIPEONFORK;
 		break;
+	case MADV_DOEXEC:
+		/*
+		 * MADV_DOEXEC is only supported on private, non-executable,
+		 * non-stack anonymous memory and if the VM_EXEC_KEEP flag
+		 * is available.
+		 */
+		if (!VM_EXEC_KEEP || vma->vm_file || vma->vm_flags & (VM_EXEC|VM_SHARED|VM_STACK)) {
+			error = -EINVAL;
+			goto out;
+		}
+		new_flags |= (new_flags & ~VM_MAYEXEC) | VM_EXEC_KEEP;
+		break;
+	case MADV_DONTEXEC:
+		if (!VM_EXEC_KEEP) {
+			error = -EINVAL;
+			goto out;
+		}
+		if (new_flags & VM_EXEC_KEEP)
+			new_flags |= (new_flags & ~VM_EXEC_KEEP) | VM_MAYEXEC;
+		break;
 	case MADV_DONTDUMP:
 		new_flags |= VM_DONTDUMP;
 		break;
@@ -983,6 +1003,8 @@ static int madvise_inject_error(int behavior,
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
 #endif
+	case MADV_DOEXEC:
+	case MADV_DONTEXEC:
 		return true;
 
 	default:
@@ -1037,6 +1059,9 @@ static int madvise_inject_error(int behavior,
  *  MADV_DONTDUMP - the application wants to prevent pages in the given range
  *		from being included in its core dump.
  *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
+ *  MADV_DOEXEC - On exec, preserve and duplicate this area in the new process
+ *		  if the new process allows it.
+ *  MADV_DONTEXEC - Undo the effect of MADV_DOEXEC.
  *
  * return values:
  *  zero    - success
-- 
1.8.3.1
