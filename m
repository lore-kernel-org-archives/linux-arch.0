From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Sun, 27 Mar 2016 14:44:01 +0200
Message-ID: <20160327124401.GA7407@ravnborg.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F3A77D.6060802@redhat.com>
 <56F75490.9010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:59688 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbcC0MoK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Mar 2016 08:44:10 -0400
Content-Disposition: inline
In-Reply-To: <56F75490.9010608@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Zeng.

Looking through the arch specific implementations of __arch_parity().
Some architectures uses #defines, other uses inline static functions.

Any particular reason that you select one approach over the other
in the different cases?

ia64:
+#define __arch_parity32(x) ((unsigned int) __arch_parity64((x) & 0xfffffffful))
+#define __arch_parity16(x) ((unsigned int) __arch_parity64((x) & 0xfffful))
+#define __arch_parity8(x)  ((unsigned int) __arch_parity64((x) & 0xfful))
+#define __arch_parity4(x)  ((unsigned int) __arch_parity64((x) & 0xful))

tile:
+static inline unsigned int __arch_parity32(unsigned int w)
+{
+	return __builtin_popcount(w) & 1;
+}
+
+static inline unsigned int __arch_parity16(unsigned int w)
+{
+	return __arch_parity32(w & 0xffff);
+}
+
+static inline unsigned int __arch_parity8(unsigned int w)
+{
+	return __arch_parity32(w & 0xff);
+}
+
+static inline unsigned int __arch_parity4(unsigned int w)
+{
+	return __arch_parity32(w & 0xf);
+}

Just two examples.

Adding the parity helpers seems like veny nice simplifications.

A few comments to some of those I looked at.
(I am not subscribed to lkml, so you get it as comments here)

[PATCH 21/31] mtd: use parity16 in ssfdc.c
The original code semes to check that the parity equals the
value of first bit in the address.
This seems lost after the conversion.

[PATCH 20/31] scsi: use parity32 in isci/phy.c
+	if (parity32(phy_cap.all))
 		phy_cap.parity = 1;
Could be written like this - simpler IMO:
	phy_cap.parity = parity32(phy_cap.all);


	Sam
