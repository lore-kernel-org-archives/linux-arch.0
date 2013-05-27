From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: parisc: kernel: memory overflow, 'name' length is too
 short for using
Date: Mon, 27 May 2013 12:57:09 +0800
Message-ID: <51A2E7A5.5000904@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>
Cc: Parisc List <linux-parisc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


'path.bc[i]' can be asigned by PCI_SLOT() which can '> 10', so sizeof(6
* "%u:" + "%u" + '\0') may be 21.

Since 'name' length is 20, it may be memory overflow.

And 'path.bc[i]' is 'unsigned char' for printing, we can be sure the
max length of 'name' must be less than 28.

So simplify thinking, we can use 28 instead of 20 directly, and do not
think of whether 'patchc.bc[i]' can '> 100'.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/parisc/kernel/drivers.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index 5709c5e..14285ca 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -394,7 +394,7 @@ EXPORT_SYMBOL(print_pci_hwpath);
 static void setup_bus_id(struct parisc_device *padev)
 {
 	struct hardware_path path;
-	char name[20];
+	char name[28];
 	char *output = name;
 	int i;
 
-- 
1.7.7.6
