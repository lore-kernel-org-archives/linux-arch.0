From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 10/30] compat: Use COMPAT_USE_64BIT_TIME in the Bluetooth subsystem
Date: Sun, 19 Feb 2012 16:07:48 -0800
Message-ID: <1329696488-16970-11-git-send-email-hpa@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57203 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab2BTANa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:13:30 -0500
In-Reply-To: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com, Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>, "David S. Miller" <davem@davemloft.net>

From: "H. J. Lu" <hjl.tools@gmail.com>

Enable the Bluetooth subsystem to be used with a compat ABI with
64-bit time.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo F. Padovan <padovan@profusion.mobi>
Cc: David S. Miller <davem@davemloft.net>
---
 net/bluetooth/hci_sock.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0dcc962..b2eb2b9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -418,7 +418,8 @@ static inline void hci_sock_cmsg(struct sock *sk, struct msghdr *msg, struct sk_
 		data = &tv;
 		len = sizeof(tv);
 #ifdef CONFIG_COMPAT
-		if (msg->msg_flags & MSG_CMSG_COMPAT) {
+		if (!COMPAT_USE_64BIT_TIME &&
+		    (msg->msg_flags & MSG_CMSG_COMPAT)) {
 			ctv.tv_sec = tv.tv_sec;
 			ctv.tv_usec = tv.tv_usec;
 			data = &ctv;
-- 
1.7.6.5
