From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: alpha: kernel: typo issue, using '1' instead of '11'
Date: Wed, 29 May 2013 19:04:09 +0800
Message-ID: <51A5E0A9.70605@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, josh@joshtriplett.org, srivatsa.bhat@linux.vnet.ibm.com
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


For sending message:

        *(unsigned int *)&cpu->ipc_buffer[0] = len;
        cp1 = (char *) &cpu->ipc_buffer[1];

But for receive message:

                cnt = cpu->ipc_buffer[0] >> 32;
                ...
                       cp1 = (char *) &cpu->ipc_buffer[11];

They are not pairs, it is typo issue of the redundency '1'.

So need use '1' instead of '11'.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/alpha/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 7b60834..8beb6b2 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -264,7 +264,7 @@ recv_secondary_console_msg(void)
 		if (cnt <= 0 || cnt >= 80)
 			strcpy(buf, "<<< BOGUS MSG >>>");
 		else {
-			cp1 = (char *) &cpu->ipc_buffer[11];
+			cp1 = (char *) &cpu->ipc_buffer[1];
 			cp2 = buf;
 			strcpy(cp2, cp1);
 			
-- 
1.7.7.6
