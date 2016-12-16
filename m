From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/13] clk: pxa: fix gcc-4.4 build
Date: Fri, 16 Dec 2016 11:56:26 +0100
Message-ID: <20161216105634.235457-6-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, kernel-build-reports@lists.linaro.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

With gcc-4.4 and earlier, the asm statement must not end in ':', or we
get this build error:

drivers/clk/pxa/clk-pxa.c: In function 'pxa2xx_core_turbo_switch':
drivers/clk/pxa/clk-pxa.c:152: error: expected string literal before ')' token

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/pxa/clk-pxa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index 74f64c3c4290..626ec5613bb1 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -148,8 +148,7 @@ void pxa2xx_core_turbo_switch(bool on)
 	"2:	b	1b\n"
 	"3:	nop\n"
 		: "=&r" (unused)
-		: "r" (clkcfg)
-		: );
+		: "r" (clkcfg));
 
 	local_irq_restore(flags);
 }
-- 
2.9.0
