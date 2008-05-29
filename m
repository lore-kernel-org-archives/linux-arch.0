From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 09/37] firewire: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:12 -0700
Message-ID: <1212092292.28403.111.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43327 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbYE2USO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:14 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392252yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:13 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/firewire/fw-card.c   |    2 +-
 drivers/firewire/fw-device.c |    2 +-
 drivers/firewire/fw-ohci.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firewire/fw-card.c b/drivers/firewire/fw-card.c
index 5b4c0d9..2947db5 100644
--- a/drivers/firewire/fw-card.c
+++ b/drivers/firewire/fw-card.c
@@ -204,7 +204,7 @@ complete_bm_lock(struct fw_card *card, int rcode,
 	struct bm_data *bmd = data;
 
 	if (rcode == RCODE_COMPLETE)
-		bmd->old = be32_to_cpu(*(__be32 *) payload);
+		bmd->old = get_be32((__be32 *)payload);
 	bmd->rcode = rcode;
 	complete(&bmd->done);
 }
diff --git a/drivers/firewire/fw-device.c b/drivers/firewire/fw-device.c
index d9c8daf..4072658 100644
--- a/drivers/firewire/fw-device.c
+++ b/drivers/firewire/fw-device.c
@@ -394,7 +394,7 @@ complete_transaction(struct fw_card *card, int rcode,
 	struct read_quadlet_callback_data *callback_data = data;
 
 	if (rcode == RCODE_COMPLETE)
-		callback_data->data = be32_to_cpu(*(__be32 *)payload);
+		callback_data->data = get_be32((__be32 *)payload);
 	callback_data->rcode = rcode;
 	complete(&callback_data->done);
 }
diff --git a/drivers/firewire/fw-ohci.c b/drivers/firewire/fw-ohci.c
index 4f02c55..ee5c87f 100644
--- a/drivers/firewire/fw-ohci.c
+++ b/drivers/firewire/fw-ohci.c
@@ -1781,7 +1781,7 @@ static int handle_ir_dualbuffer_packet(struct context *context,
 		memcpy(ctx->header + i + 4, p + 8, ctx->base.header_size - 4);
 		i += ctx->base.header_size;
 		ctx->excess_bytes +=
-			(le32_to_cpu(*(__le32 *)(p + 4)) >> 16) & 0xffff;
+			(get_le32((__le32 *)(p + 4)) >> 16) & 0xffff;
 		p += ctx->base.header_size + 4;
 	}
 	ctx->header_length = i;
-- 
1.5.6.rc0.277.g804cf
