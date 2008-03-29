From: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] set_restore_sigmask TIF_SIGPENDING
Date: Fri, 28 Mar 2008 17:13:41 -0700 (PDT)
Message-ID: <20080329001341.7F93826FA1D@magilla.localdomain>
References: <20080329001230.D013726FA1D@magilla.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Roland McGrath's message of  Friday, 28 March 2008 17:12:30 -0700 <20080329001230.D013726FA1D-nL1rrgvulkcB9AHHLWeGtNQXobZC6xk2@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Set TIF_SIGPENDING in set_restore_sigmask.  This lets arch code take
TIF_RESTORE_SIGMASK out of the set of bits that will be noticed on
return to user mode.  On some machines those bits are scarce, and we
can free this unneeded one up for other uses.

It is probably the case that TIF_SIGPENDING is always set anyway
everywhere set_restore_sigmask() is used.  But this is some cheap
paranoia in case there is an arcane case where it might not be.

Signed-off-by: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 include/linux/thread_info.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index d82c073..4a89477 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -85,11 +85,17 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
  * set_restore_sigmask() - make sure saved_sigmask processing gets done
  *
  * This sets TIF_RESTORE_SIGMASK and ensures that the arch signal code
- * will run before returning to user mode, to process the flag.
+ * will run before returning to user mode, to process the flag.  For
+ * all callers, TIF_SIGPENDING is already set or it's no harm to set
+ * it.  TIF_RESTORE_SIGMASK need not be in the set of bits that the
+ * arch code will notice on return to user mode, in case those bits
+ * are scarce.  We set TIF_SIGPENDING here to ensure that the arch
+ * signal code always gets run when TIF_RESTORE_SIGMASK is set.
  */
 static inline void set_restore_sigmask(void)
 {
 	set_thread_flag(TIF_RESTORE_SIGMASK);
+	set_thread_flag(TIF_SIGPENDING);
 }
 #endif	/* TIF_RESTORE_SIGMASK */
 
