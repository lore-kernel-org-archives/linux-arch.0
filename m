Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:51803 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761713AbXKPXLI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 18:11:08 -0500
Message-Id: <20071116231107.817058594@sgi.com>
References: <20071116230920.278761667@sgi.com>
Date: Fri, 16 Nov 2007 15:09:43 -0800
From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 23/30] cpu alloc: veth conversion
Content-Disposition: inline; filename=0033-cpu-alloc-veth-conversion.patch
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 drivers/net/veth.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/net/veth.c
===================================================================
--- linux-2.6.orig/drivers/net/veth.c	2007-11-15 21:17:24.010404318 -0800
+++ linux-2.6/drivers/net/veth.c	2007-11-15 21:25:36.483154219 -0800
@@ -162,7 +162,7 @@ static int veth_xmit(struct sk_buff *skb
 	rcv_priv = netdev_priv(rcv);
 
 	cpu = smp_processor_id();
-	stats = per_cpu_ptr(priv->stats, cpu);
+	stats = CPU_PTR(priv->stats, cpu);
 
 	if (!(rcv->flags & IFF_UP))
 		goto outf;
@@ -183,7 +183,7 @@ static int veth_xmit(struct sk_buff *skb
 	stats->tx_bytes += length;
 	stats->tx_packets++;
 
-	stats = per_cpu_ptr(rcv_priv->stats, cpu);
+	stats = CPU_PTR(rcv_priv->stats, cpu);
 	stats->rx_bytes += length;
 	stats->rx_packets++;
 
@@ -217,7 +217,7 @@ static struct net_device_stats *veth_get
 	dev_stats->tx_dropped = 0;
 
 	for_each_online_cpu(cpu) {
-		stats = per_cpu_ptr(priv->stats, cpu);
+		stats = CPU_PTR(priv->stats, cpu);
 
 		dev_stats->rx_packets += stats->rx_packets;
 		dev_stats->tx_packets += stats->tx_packets;
@@ -261,7 +261,7 @@ static int veth_dev_init(struct net_devi
 	struct veth_net_stats *stats;
 	struct veth_priv *priv;
 
-	stats = alloc_percpu(struct veth_net_stats);
+	stats = CPU_ALLOC(struct veth_net_stats, GFP_KERNEL | __GFP_ZER);
 	if (stats == NULL)
 		return -ENOMEM;
 
@@ -275,7 +275,7 @@ static void veth_dev_free(struct net_dev
 	struct veth_priv *priv;
 
 	priv = netdev_priv(dev);
-	free_percpu(priv->stats);
+	CPU_FREE(priv->stats);
 	free_netdev(dev);
 }
 

-- 
