From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 02/15] mn10300: READ_ONCE() now implies smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:36 -0700
Message-ID: <1507594969-8347-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-am33-list@redhat.com
List-Id: linux-arch.vger.kernel.org

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
