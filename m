Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755613AbdJJAWy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JQf3139144
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:54 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgd11ab48-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:53 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:52 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 02/15] mn10300: READ_ONCE() now implies smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:36 -0700
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Message-ID: <1507594969-8347-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-am33-list@redhat.com
Message-ID: <20171010002236.RcTHKbL5mKDsbuU6H0w4b1921cIYehZupY8Jku691Wk@z>

Given that READ_ONCE() now implies smp_read_barrier_depends(),
there is no need for the open-coded smp_read_barrier_depends() in
mn10300_serial_receive_interrupt() and mn10300_serial_poll_get_char().
This commit therefore removes them, but replaces them with comments
calling out that carrying dependencies through non-pointers is quite
dangerous.  Compilers simply know too much about integers.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <linux-am33-list@redhat.com>
---
 arch/mn10300/kernel/mn10300-serial.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mn10300/kernel/mn10300-serial.c b/arch/mn10300/kernel/mn10300-serial.c
index d7ef1232a82a..4994b570dfd9 100644
--- a/arch/mn10300/kernel/mn10300-serial.c
+++ b/arch/mn10300/kernel/mn10300-serial.c
@@ -550,7 +550,7 @@ static void mn10300_serial_receive_interrupt(struct mn10300_serial_port *port)
 		return;
 	}
 
-	smp_read_barrier_depends();
+	/* READ_ONCE() enforces dependency, but dangerous through integer!!! */
 	ch = port->rx_buffer[ix++];
 	st = port->rx_buffer[ix++];
 	smp_mb();
@@ -1728,7 +1728,10 @@ static int mn10300_serial_poll_get_char(struct uart_port *_port)
 			if (CIRC_CNT(port->rx_inp, ix, MNSC_BUFFER_SIZE) == 0)
 				return NO_POLL_CHAR;
 
-			smp_read_barrier_depends();
+			/*
+			 * READ_ONCE() enforces dependency, but dangerous
+			 * through integer!!!
+			 */
 			ch = port->rx_buffer[ix++];
 			st = port->rx_buffer[ix++];
 			smp_mb();
-- 
2.5.2
