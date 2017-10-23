From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 10/19] samples: mic/mpssd/mpssd.c: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:20 -0700
Message-ID: <1508792849-3115-10-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751525AbdJWVHl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL6A9F083459
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dsksdbdqd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:40 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:40 -0400
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

The bulk of the kernel code can be transformed via Coccinelle to use
{READ,WRITE}_ONCE(), though this only modifies users of ACCESS_ONCE(),
and not the implementation itself. As such, it has the potential to
break homebrew ACCESS_ONCE() macros seen in some user code in the kernel
tree (e.g. the virtio code, as fixed in commit ea9156fb3b71d9f7).

To avoid fragility if/when that transformation occurs, and to align with
the preferred usage of {READ,WRITE}_ONCE(), this patch updates the MPSSD
sample code to use READ_ONCE() rather than ACCESS_ONCE(). There should
be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 samples/mic/mpssd/mpssd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/mic/mpssd/mpssd.c b/samples/mic/mpssd/mpssd.c
index 49db1def1721..f42ce551bb48 100644
--- a/samples/mic/mpssd/mpssd.c
+++ b/samples/mic/mpssd/mpssd.c
@@ -65,7 +65,7 @@ static struct mic_info mic_list;
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)        _ALIGN(addr, PAGE_SIZE)
 
-#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
 
 #define GSO_ENABLED		1
 #define MAX_GSO_SIZE		(64 * 1024)
@@ -382,7 +382,7 @@ disp_iovec(struct mic_info *mic, struct mic_copy_desc *copy,
 
 static inline __u16 read_avail_idx(struct mic_vring *vr)
 {
-	return ACCESS_ONCE(vr->info->avail_idx);
+	return READ_ONCE(vr->info->avail_idx);
 }
 
 static inline void txrx_prepare(int type, bool tx, struct mic_vring *vr,
@@ -523,7 +523,7 @@ spin_for_descriptors(struct mic_info *mic, struct mic_vring *vr)
 {
 	__u16 avail_idx = read_avail_idx(vr);
 
-	while (avail_idx == le16toh(ACCESS_ONCE(vr->vr.avail->idx))) {
+	while (avail_idx == le16toh(READ_ONCE(vr->vr.avail->idx))) {
 #ifdef DEBUG
 		mpsslog("%s %s waiting for desc avail %d info_avail %d\n",
 			mic->name, __func__,
-- 
2.5.2
