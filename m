From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 20/41] cpu alloc: Veth conversion
Date: Thu, 29 May 2008 20:56:40 -0700
Message-ID: <20080530040017.927696553@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:40509 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752491AbYE3EAU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 00:00:20 -0400
Content-Disposition: inline; filename=cpu_alloc_veth_conversion
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

veth statistics conversion.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 drivers/net/veth.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/net/veth.c
===================================================================
--- linux-2.6.orig/drivers/net/veth.c	2008-05-28 22:02:18.000000000 -0700
+++ linux-2.6/drivers/net/veth.c	2008-05-28 23:18:47.000000000 -0700
@@ -152,8 +152,7 @@
 {
 	struct net_device *rcv = NULL;
 	struct veth_priv *priv, *rcv_priv;
-	struct veth_net_stats *stats;
-	int length, cpu;
+	int length;
 
 	skb_orphan(skb);
 
@@ -161,9 +160,6 @@
 	rcv = priv->peer;
 	rcv_priv = netdev_priv(rcv);
 
-	cpu = smp_processor_id();
-	stats = per_cpu_ptr(priv->stats, cpu);
-
 	if (!(rcv->flags & IFF_UP))
 		goto outf;
 
@@ -180,19 +176,18 @@
 
 	length = skb->len;
 
-	stats->tx_bytes += length;
-	stats->tx_packets++;
+	__CPU_ADD(priv->stats->tx_bytes, length);
+	__CPU_INC(priv->stats->tx_packets);
 
-	stats = per_cpu_ptr(rcv_priv->stats, cpu);
-	stats->rx_bytes += length;
-	stats->rx_packets++;
+	__CPU_ADD(rcv_priv->stats->rx_bytes, length);
+	__CPU_INC(rcv_priv->stats->rx_packets);
 
 	netif_rx(skb);
 	return 0;
 
 outf:
 	kfree_skb(skb);
-	stats->tx_dropped++;
+	__CPU_INC(priv->stats->tx_dropped);
 	return 0;
 }
 
@@ -217,7 +212,7 @@
 	dev_stats->tx_dropped = 0;
 
 	for_each_online_cpu(cpu) {
-		stats = per_cpu_ptr(priv->stats, cpu);
+		stats = CPU_PTR(priv->stats, cpu);
 
 		dev_stats->rx_packets += stats->rx_packets;
 		dev_stats->tx_packets += stats->tx_packets;
@@ -249,7 +244,7 @@
 	struct veth_net_stats *stats;
 	struct veth_priv *priv;
 
-	stats = alloc_percpu(struct veth_net_stats);
+	stats = CPU_ALLOC(struct veth_net_stats, GFP_KERNEL | __GFP_ZER);
 	if (stats == NULL)
 		return -ENOMEM;
 
@@ -263,7 +258,7 @@
 	struct veth_priv *priv;
 
 	priv = netdev_priv(dev);
-	free_percpu(priv->stats);
+	CPU_FREE(priv->stats);
 	free_netdev(dev);
 }
 

-- 
