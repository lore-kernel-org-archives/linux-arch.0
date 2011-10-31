From: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Subject: [folded] cross-memory-attach-v4.patch removed from -mm tree
Date: Mon, 31 Oct 2011 16:39:55 -0700
Message-ID: <201110312339.p9VNdu5H032350@hpaq2.eem.corp.google.com>
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cyeoh-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org
List-Id: linux-arch.vger.kernel.org


The patch titled
     Subject: cross-memory-attach-v4
has been removed from the -mm tree.  Its filename was
     cross-memory-attach-v4.patch

This patch was dropped because it was folded into cross-memory-attach-v3.patch

The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/

------------------------------------------------------
From: Christopher Yeoh <cyeoh-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>
Subject: cross-memory-attach-v4

> You might get some speed benefit by optimising for the small copies
> here.  Define a local on-stack array of N page*'s and point
> process_pages at that if the number of pages is <= N.  Saves a
> malloc/free and is more cache-friendly.  But only if the result is
> measurable!

I have done some benchmarking on this, and it gains about 5-7% on a
microbenchmark with 4kb size copies and about a 1% gain with a more
realistic (but modified for smaller copies) hpcc benchmark. The
performance gain disappears into the noise by about 64kb sized copies.
No measurable overhead for larger copies. So I think its worth including

Included below is the patch (based on v4) - for ease of review the first diff
is just against the latest version of CMA which has been posted here previously.
The second is the entire CMA patch.

Signed-off-by: Chris Yeoh <cyeoh-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>
Cc: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>
Cc: <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
---

 mm/process_vm_access.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff -puN mm/process_vm_access.c~cross-memory-attach-v4 mm/process_vm_access.c
--- a/mm/process_vm_access.c~cross-memory-attach-v4
+++ a/mm/process_vm_access.c
@@ -221,6 +221,10 @@ static int process_vm_rw_single_vec(unsi
 	return rc;
 }
 
+/* Maximum number of entries for process pages array
+   which lives on stack */
+#define PVM_MAX_PP_ARRAY_COUNT 16
+
 /**
  * process_vm_rw_core - core of reading/writing pages from task specified
  * @pid: PID of process to read/write from/to
@@ -241,7 +245,8 @@ static ssize_t process_vm_rw_core(pid_t 
 				  unsigned long flags, int vm_write)
 {
 	struct task_struct *task;
-	struct page **process_pages = NULL;
+	struct page *pp_stack[PVM_MAX_PP_ARRAY_COUNT];
+	struct page **process_pages = pp_stack;
 	struct mm_struct *mm;
 	unsigned long i;
 	ssize_t rc = 0;
@@ -271,13 +276,16 @@ static ssize_t process_vm_rw_core(pid_t 
 	if (nr_pages == 0)
 		return 0;
 
-	/* For reliability don't try to kmalloc more than 2 pages worth */
-	process_pages = kmalloc(min_t(size_t, PVM_MAX_KMALLOC_PAGES,
-				      sizeof(struct pages *)*nr_pages),
-				GFP_KERNEL);
+	if (nr_pages > PVM_MAX_PP_ARRAY_COUNT) {
+		/* For reliability don't try to kmalloc more than
+		   2 pages worth */
+		process_pages = kmalloc(min_t(size_t, PVM_MAX_KMALLOC_PAGES,
+					      sizeof(struct pages *)*nr_pages),
+					GFP_KERNEL);
 
-	if (!process_pages)
-		return -ENOMEM;
+		if (!process_pages)
+			return -ENOMEM;
+	}
 
 	/* Get process information */
 	rcu_read_lock();
@@ -331,7 +339,8 @@ put_task_struct:
 	put_task_struct(task);
 
 free_proc_pages:
-	kfree(process_pages);
+	if (process_pages != pp_stack)
+		kfree(process_pages);
 	return rc;
 }
 
_

Patches currently in -mm which might be from cyeoh-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org are

cross-memory-attach-v3.patch

--
To unsubscribe from this list: send the line "unsubscribe linux-man" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
