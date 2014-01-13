From: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: [PATCH 1/7] sched: allow try_to_wake_up to be used internally outside
	of core.c
Date: Mon, 13 Jan 2014 13:31:31 +0100
Message-ID: <20140113123126.20574.74329.stgit@patser>
References: <20140113122818.20574.34710.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140113122818.20574.34710.stgit@patser>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, ccross@google.com, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The kernel fence implementation doesn't use event queues, but needs
to perform the same wake up. The symbol is not exported, since the
fence implementation is not built as a module.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@canonical.com>
---
 include/linux/wait.h |    1 +
 kernel/sched/core.c  |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index eaa00b10abaa..c54e3ef50134 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -12,6 +12,7 @@
 typedef struct __wait_queue wait_queue_t;
 typedef int (*wait_queue_func_t)(wait_queue_t *wait, unsigned mode, int flags, void *key);
 int default_wake_function(wait_queue_t *wait, unsigned mode, int flags, void *key);
+int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags);
 
 struct __wait_queue {
 	unsigned int		flags;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a88f4a485c5e..f41d317042dd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1578,7 +1578,7 @@ static void ttwu_queue(struct task_struct *p, int cpu)
  * Return: %true if @p was woken up, %false if it was already running.
  * or @state didn't match @p's state.
  */
-static int
+int
 try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	unsigned long flags;
