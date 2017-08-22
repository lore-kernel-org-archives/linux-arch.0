From: raymond pang <raymondpangxd@gmail.com>
Subject: [PATCH] x86/ioapic: Correctly print IRTE's index field when enabling INTR
Date: Tue, 22 Aug 2017 23:44:47 +0800
Message-ID: <CAHG4imNDzpDyOVi7MByVrLQ=QFuOVqpzJ5F-Xs5z6OZphubj-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33451 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933040AbdHVPos (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Aug 2017 11:44:48 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-arch@vger.kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org

When enabling interrupt remap, IOAPIC's RTE contains interrupt_index
field of IRTE. And this field is composed of index and index2 member of
struct IR_IO_APIC_route_entry. Make io_apic_print_entries() correctly
print interrupt index field.

Signed-off-by: Raymond Pang <raymondpangxd@gmail.com>
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 237e9c2..70e48aa 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1243,7 +1243,7 @@ static void io_apic_print_entries(unsigned int
apic, unsigned int nr_entries)
     entry.vector, entry.irr, entry.delivery_status);
   if (ir_entry->format)
    printk(KERN_DEBUG "%s, remapped, I(%04X),  Z(%X)\n",
-          buf, (ir_entry->index << 15) | ir_entry->index,
+          buf, (ir_entry->index2 << 15) | ir_entry->index,
           ir_entry->zero);
   else
    printk(KERN_DEBUG "%s, %s, D(%02X), M(%1d)\n",
-- 
1.9.1
