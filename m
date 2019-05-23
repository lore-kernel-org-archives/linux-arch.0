Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:58557 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWA7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:59:20 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:38:55 -0500
Message-ID: <20190523003916.20726-6-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 05/26] signal/bpfilter: Fix bpfilter_kernl to use send_sig not force_sig
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20190523003855.qOo9oSoPVeWvPdtpxUIsCd9Lfe_r8vUTZXAYbCEGGOc@z>

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
