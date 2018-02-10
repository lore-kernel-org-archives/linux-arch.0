Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:35813 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJRBY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Feb 2018 12:01:24 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH for 4.16] Documentation: Allow comments in arch features files
Date: Sat, 10 Feb 2018 12:00:58 -0500
Message-ID: <1518282058-24226-1-git-send-email-mathieu.desnoyers@efficios.com>
In-Reply-To: <20180210114700.mq2rg4lbjtzyx5pn@gmail.com>
References: <20180210114700.mq2rg4lbjtzyx5pn@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Andrea Parri <parri.andrea@gmail.com>, Andrew Hunter <ahh@google.com>, Andy Lutomirski <luto@kernel.org>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boqun Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>, Greg Hackmann <ghackmann@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Maged Michael <maged.michael@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180210170058.NBunGQKck7k1LZvLoNVuRDT_Y3gBY3Li1jjboy4vZDk@z>

The list-arch.sh script considers lines beginning with "#" as match for
the feature table.

Given that those tables are never in lines beginning with "#",
add a reverse grep on "^#" when matching the "ok/TODO" state of
the architecture.

This allows adding comments within the feature files, for instance
describing the architecture requirements for the feature in each
architecture.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: David Sehr <sehr@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
 Documentation/features/list-arch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
index c16b5b5..1ec47c3 100755
--- a/Documentation/features/list-arch.sh
+++ b/Documentation/features/list-arch.sh
@@ -17,7 +17,7 @@ for F in */*/arch-support.txt; do
   N=$(grep -h "^# Feature name:"        $F | cut -c25-)
   C=$(grep -h "^#         Kconfig:"     $F | cut -c25-)
   D=$(grep -h "^#         description:" $F | cut -c25-)
-  S=$(grep -hw $ARCH $F | cut -d\| -f3)
+  S=$(grep -hv "^#" $F | grep -w $ARCH | cut -d\| -f3)
 
   printf "%10s/%-22s:%s| %35s # %s\n" "$SUBSYS" "$N" "$S" "$C" "$D"
 done
-- 
1.9.1
