From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [RFC] persistent store (version 2) (part 1 of 2)
Date: Wed, 01 Dec 2010 10:01:19 -0800
Message-ID: <4cf68d6f178373258a@agluck-desktop.sc.intel.com>
References: <20101201005851.GA31571@kroah.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5574 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755691Ab0LASBT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Dec 2010 13:01:19 -0500
In-reply-to: <20101201005851.GA31571@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greg@kroah.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, mingo@elte.hu, akpm@linux-foundation.org, ying.huang@intel.com, Borislav Petkov <bp@alien8.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

> As you are adding new sysfs files, you are required to document them in
> Documentation/ABI/ as well.

Is this what you need?

-Tony

---

diff --git a/Documentation/ABI/testing/sysfs-pstore b/Documentation/ABI/testing/sysfs-pstore
new file mode 100644
index 0000000..083fcf7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-pstore
@@ -0,0 +1,35 @@
+Where:		/sys/firmware/pstore/...
+Date:		January 2011
+Kernel Version: 2.6.38
+Contact:	tony.luck@intel.com
+Description:	Generic interface to platform dependent persistent storage.
+
+		Platforms that provide a mechanism to preserve some data
+		across system reboots can register with this driver to
+		provide a generic interface to show records captured in
+		the dying moments.  In the case of a panic() the last part
+		of the console log is captured, but other interesting
+		data can also be saved.
+
+		$ ls -l /sys/firmware/pstore
+		total 0
+		-r--r--r-- 1 root root 7896 Nov 30 15:38 dmesg-1
+		--w------- 1 root root    0 Nov 30 15:38 erase
+
+		Different users of this interface will result in different
+		filename prefixes.  Currently two are defined:
+
+		"dmesg"	- saved console log
+		"mce"	- architecture dependent data from fatal h/w error
+
+		The "erase" file is used to signal that a file has been
+		read and that the underlying platform driver can reclaim
+		the space in the persistent store. Just write the name of
+		the file to be removed to the "erase" file:
+
+		$ echo dmesg-1 > /sys/firmware/pstore/erase
+
+		The expectation is that all files in /sys/firmware/pstore
+		will be saved elsewhere and erased from persistent store
+		soon after boot to free up space ready for the next
+		catastrophe.
