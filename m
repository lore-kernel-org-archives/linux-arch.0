From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH v4 10/16] rtc: m68k: provide ioctl for q40
Date: Mon, 30 May 2016 20:57:58 +0200
Message-ID: <1464634684-1248135-11-git-send-email-arnd@arndb.de>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDEKVJM7XAHRBPM2WK5AKGQE3ON4ABA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

The q40 platform is the only machine in the kernel that provides
RTC_PLL_GET/RTC_PLL_SET ioctl commands in its rtc through the
mach_get_rtc_pll/mach_set_rtc_pll callbacks.

However, this currenctly works only in the old-style genrtc
driver, not the (somewhat) modern rtc-generic driver replacing
it. This adds an ioctl implementation to the m68k generic_rtc_ops
in order to let both drivers provide the same API.

After this, we should be able to remove support for genrtc
from the m68k architecture.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 arch/m68k/kernel/time.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index bd6417d38d5a..4e5aa2f4f522 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -100,7 +100,32 @@ static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct rtc_pll_info pll;
+	struct rtc_pll_info __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case RTC_PLL_GET:
+		if (!mach_get_rtc_pll || mach_get_rtc_pll(&pll))
+			return -EINVAL;
+		return copy_to_user(argp, &pll, sizeof pll) ? -EFAULT : 0;
+
+	case RTC_PLL_SET:
+		if (!mach_set_rtc_pll)
+			return -EINVAL;
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+		if (copy_from_user(&pll, argp, sizeof(pll)))
+			return -EFAULT;
+		return mach_set_rtc_pll(&pll);
+	}
+
+	return -ENOIOCTLCMD;
+}
+
 static const struct rtc_class_ops generic_rtc_ops = {
+	.ioctl = rtc_ioctl,
 	.read_time = rtc_generic_get_time,
 	.set_time = rtc_generic_set_time,
 };
-- 
2.7.0

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
