Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38008 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464AbbL3Vw6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 16:52:58 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id F296F14CAB2
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 21:52:57 +0000 (UTC)
Received: from redhat.com (vpn1-6-186.ams2.redhat.com [10.36.6.186])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id tBULquOp007610
	for <linux-arch@vger.kernel.org>; Wed, 30 Dec 2015 16:52:57 -0500
Date: Wed, 30 Dec 2015 15:26:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 32/34] xen/io: use __smp_xxx barriers
Message-ID: <1451473761-30019-33-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xenproject.org
Message-ID: <20151230132628.WE-PybAeLWcvzctsD9YG9tXeeP3n-8-RG0cQOscnFxU@z>

include/xen/interface/io/ring.h uses
full memory barriers to communicate with the other side.

For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
would be sufficient, so mb() and wmb() here are only needed if
a non-SMP guest runs on an SMP host.

Switch to __smp_XXX barriers which serve this exact purpose.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/xen/interface/io/ring.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 7dc685b..46dfc65 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -208,12 +208,12 @@ struct __name##_back_ring {						\
 
 
 #define RING_PUSH_REQUESTS(_r) do {					\
-    wmb(); /* back sees requests /before/ updated producer index */	\
+    __smp_wmb(); /* back sees requests /before/ updated producer index */	\
     (_r)->sring->req_prod = (_r)->req_prod_pvt;				\
 } while (0)
 
 #define RING_PUSH_RESPONSES(_r) do {					\
-    wmb(); /* front sees responses /before/ updated producer index */	\
+    __smp_wmb(); /* front sees responses /before/ updated producer index */	\
     (_r)->sring->rsp_prod = (_r)->rsp_prod_pvt;				\
 } while (0)
 
@@ -250,9 +250,9 @@ struct __name##_back_ring {						\
 #define RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(_r, _notify) do {		\
     RING_IDX __old = (_r)->sring->req_prod;				\
     RING_IDX __new = (_r)->req_prod_pvt;				\
-    wmb(); /* back sees requests /before/ updated producer index */	\
+    __smp_wmb(); /* back sees requests /before/ updated producer index */	\
     (_r)->sring->req_prod = __new;					\
-    mb(); /* back sees new requests /before/ we check req_event */	\
+    __smp_mb(); /* back sees new requests /before/ we check req_event */	\
     (_notify) = ((RING_IDX)(__new - (_r)->sring->req_event) <		\
 		 (RING_IDX)(__new - __old));				\
 } while (0)
@@ -260,9 +260,9 @@ struct __name##_back_ring {						\
 #define RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(_r, _notify) do {		\
     RING_IDX __old = (_r)->sring->rsp_prod;				\
     RING_IDX __new = (_r)->rsp_prod_pvt;				\
-    wmb(); /* front sees responses /before/ updated producer index */	\
+    __smp_wmb(); /* front sees responses /before/ updated producer index */	\
     (_r)->sring->rsp_prod = __new;					\
-    mb(); /* front sees new responses /before/ we check rsp_event */	\
+    __smp_mb(); /* front sees new responses /before/ we check rsp_event */	\
     (_notify) = ((RING_IDX)(__new - (_r)->sring->rsp_event) <		\
 		 (RING_IDX)(__new - __old));				\
 } while (0)
@@ -271,7 +271,7 @@ struct __name##_back_ring {						\
     (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
     if (_work_to_do) break;						\
     (_r)->sring->req_event = (_r)->req_cons + 1;			\
-    mb();								\
+    __smp_mb();								\
     (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
 } while (0)
 
@@ -279,7 +279,7 @@ struct __name##_back_ring {						\
     (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
     if (_work_to_do) break;						\
     (_r)->sring->rsp_event = (_r)->rsp_cons + 1;			\
-    mb();								\
+    __smp_mb();								\
     (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
 } while (0)
 
-- 
MST

