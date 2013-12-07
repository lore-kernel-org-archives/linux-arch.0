From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 5/5] static_key: improve deferred inc behavior
Date: Sat,  7 Dec 2013 01:40:06 +0100
Message-ID: <1386376806-924-6-git-send-email-rkrcmar@redhat.com>
References: <1386376806-924-1-git-send-email-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758332Ab3LGAl0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Dec 2013 19:41:26 -0500
In-Reply-To: <1386376806-924-1-git-send-email-rkrcmar@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, rusty@rustcorp.com.au, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

We can cancel deferred static_key_slow_dec() instead of increasing
=2Eenabled.counter.

Timer now won't fire before 'timeout' since the last increase, so this =
patch
further stabilizes the case of frequent switching.

Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
---
 kernel/jump_label.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bd7ad31..9b57261 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -79,7 +79,8 @@ void static_key_slow_inc_deferred(struct static_key_d=
eferred *key)
 	STATIC_KEY_CHECK_USE();
 	if (atomic_dec_if_positive(&key->enabled_debt) >=3D 0)
 		return;
-	static_key_slow_inc(&key->key);
+	if (!cancel_delayed_work(&key->work))
+		static_key_slow_inc(&key->key);
 }
 EXPORT_SYMBOL_GPL(static_key_slow_inc_deferred);
=20
--=20
1.8.4.2
