From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 05/26] signal/bpfilter: Fix bpfilter_kernl to use send_sig not force_sig
Date: Wed, 22 May 2019 19:38:55 -0500
Message-ID: <20190523003916.20726-6-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, "David S . Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

The locking in force_sig_info is not prepared to deal with
a task that exits or execs (as sighand may change).  As force_sig
is only built to handle synchronous exceptions.

Further the function force_sig_info changes the signal state if the
signal is ignored, or blocked or if SIGNAL_UNKILLABLE will prevent the
delivery of the signal.  The signal SIGKILL can not be ignored and can
not be blocked and SIGNAL_UNKILLABLE won't prevent it from being
delivered.

So using force_sig rather than send_sig for SIGKILL is pointless.

Because it won't impact the sending of the signal and and because
using force_sig is wrong, replace force_sig with send_sig.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 net/bpfilter/bpfilter_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 7ee4fea93637..c0f0990f30b6 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -22,7 +22,7 @@ static void shutdown_umh(void)
 
 	tsk = get_pid_task(find_vpid(bpfilter_ops.info.pid), PIDTYPE_PID);
 	if (tsk) {
-		force_sig(SIGKILL, tsk);
+		send_sig(SIGKILL, tsk, 1);
 		put_task_struct(tsk);
 	}
 }
-- 
2.21.0
