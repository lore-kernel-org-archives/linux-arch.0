From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2] kernel: revamp handling of unaligned access
Date: Wed, 09 Apr 2008 17:58:40 -0700
Message-ID: <1207789120.16220.30.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

This conversion found a possible typo in the lzo compressor which I will
send a bugreport for.  That is the only place that should have a functional
change with this patch.  Other than arches that can take advantage of doing
the byteswapping as part of the unaligned accesses now.

Create a linux/unaligned folder similar in spirit to the linux/byteorder
folder to hold generic implementations collected from various arches.

Conversions of places like le16_to_cpu(get_unaligned((__le16 *)p)) has
been included to show the cleanup that can happen and how common this
is in the kernel currently.  The put_* side has not, and is slightly
less common.

Currently there are five implementations:
1) cpu_endian.h: C-struct based, from asm-generic/unaligned.h
2) little_endian.h: Open coded byte-swapping, taken from arm
3) big_endian.h: Open coded byte-swapping, taken from arm
4) no_builtin_memcpy.h: multiple implementations
5) access_ok.h: x86 and others, unaligned access is ok.

There is also the addition of some byteorder unaligned accesses api:

get_unaligned_{le16|le32|le64|be16|be32|be64}(p) which is meant to replace
code of the form:
le16_to_cpu(get_unaligned((__le16 *)p));

put_unaligned_{le16|le32|le64|be16|be32|be64}(val, pointer) which is meant to
replace code of the form:
put_unaligned(cpu_to_le16(val), (__le16 *)p);

Helpers to create these based on the selected implementation and define the
appropriate get_unaligned() and put_unaligned() macros are:

generic_le.h: Use the C-struct for get/put_unaligned and the le helpers, use the
opencoded be byteswapping implementation for be.

generic_be.h: Use the C-struct for get/put_unaligned and the be helpers, use the
opencoded le byteswapping implementation for le.

generic.h: Use opencoded byteswapping for all helpers, leaves it to the arch to
define get/put_unaligned

A naive attempt at incorporating the frv asm versions is included.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/block/aoe/aoecmd.c                  |   26 +-
 drivers/block/aoe/aoenet.c                  |    4 +-
 drivers/char/rocket_int.h                   |    2 +-
 drivers/hid/hid-core.c                      |    6 +-
 drivers/ide/ide-tape.c                      |    2 +-
 drivers/input/tablet/aiptek.c               |   16 +-
 drivers/input/tablet/gtco.c                 |   14 +-
 drivers/input/tablet/kbtab.c                |    4 +-
 drivers/media/radio/radio-si470x.c          |   11 +-
 drivers/mmc/host/mmc_spi.c                  |    2 +-
 drivers/net/hamachi.c                       |    2 +-
 drivers/net/irda/mcs7780.c                  |    2 +-
 drivers/net/irda/stir4200.c                 |    2 +-
 drivers/net/tulip/de4x5.c                   |    2 +-
 drivers/net/tulip/de4x5.h                   |    2 +-
 drivers/net/tulip/tulip_core.c              |    4 +-
 drivers/net/wireless/airo.c                 |    2 +-
 drivers/net/wireless/ath5k/base.c           |    4 +-
 drivers/net/wireless/b43/main.c             |    2 +-
 drivers/net/wireless/b43legacy/main.c       |    2 +-
 drivers/net/wireless/libertas/scan.c        |    2 +-
 drivers/net/wireless/zd1211rw/zd_usb.c      |    2 +-
 drivers/net/yellowfin.c                     |    2 +-
 drivers/pcmcia/cistpl.c                     |    4 +-
 drivers/scsi/libiscsi.c                     |    2 +-
 drivers/usb/atm/ueagle-atm.c                |    8 +-
 drivers/usb/class/cdc-acm.c                 |    2 +-
 drivers/usb/gadget/goku_udc.c               |    2 +-
 drivers/usb/gadget/rndis.c                  |   40 ++--
 drivers/video/matrox/matroxfb_misc.c        |    4 +-
 drivers/video/metronomefb.c                 |    6 +-
 fs/fat/inode.c                              |    8 +-
 fs/hfsplus/wrapper.c                        |    2 +-
 fs/isofs/isofs.h                            |   12 +-
 fs/ncpfs/ncplib_kernel.c                    |   12 +-
 fs/partitions/ldm.h                         |    6 +-
 fs/xfs/xfs_inode.c                          |    4 +-
 include/asm-alpha/unaligned.h               |    2 +-
 include/asm-arm/unaligned.h                 |  166 +------------
 include/asm-avr32/unaligned.h               |    2 +-
 include/asm-blackfin/unaligned.h            |    2 +-
 include/asm-cris/unaligned.h                |    8 +-
 include/asm-frv/unaligned.h                 |  360 ++++++++++++++++-----------
 include/asm-generic/unaligned.h             |  124 ---------
 include/asm-h8300/unaligned.h               |   11 +-
 include/asm-ia64/unaligned.h                |    2 +-
 include/asm-m32r/unaligned.h                |   15 +-
 include/asm-m68k/unaligned.h                |    9 +-
 include/asm-m68knommu/unaligned.h           |   10 +-
 include/asm-mips/unaligned.h                |   30 +--
 include/asm-mn10300/unaligned.h             |  126 +---------
 include/asm-parisc/unaligned.h              |    2 +-
 include/asm-powerpc/unaligned.h             |    9 +-
 include/asm-s390/unaligned.h                |    9 +-
 include/asm-sh/unaligned.h                  |    6 +-
 include/asm-sparc/unaligned.h               |    2 +-
 include/asm-sparc64/unaligned.h             |    2 +-
 include/asm-v850/unaligned.h                |  111 +--------
 include/asm-x86/unaligned.h                 |   30 +---
 include/asm-xtensa/unaligned.h              |   12 +-
 include/linux/reiserfs_fs.h                 |    2 +-
 include/linux/smb_fs.h                      |    9 +-
 include/linux/unaligned/access_ok.h         |   70 +++++
 include/linux/unaligned/big_endian.h        |   82 ++++++
 include/linux/unaligned/cpu_endian.h        |   88 +++++++
 include/linux/unaligned/generic.h           |   67 +++++
 include/linux/unaligned/generic_be.h        |   70 +++++
 include/linux/unaligned/generic_le.h        |   70 +++++
 include/linux/unaligned/little_endian.h     |   82 ++++++
 include/linux/unaligned/no_builtin_memcpy.h |   80 ++++++
 include/net/ieee80211_radiotap.h            |    2 +-
 lib/lzo/lzo1x_decompress.c                  |    6 +-
 net/bluetooth/hci_event.c                   |    6 +-
 net/bluetooth/hci_sock.c                    |    2 +-
 net/bluetooth/l2cap.c                       |    2 +-
 net/irda/iriap.c                            |    6 +-
 net/wireless/radiotap.c                     |    8 +-
 77 files changed, 985 insertions(+), 946 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d00293b..1fe19b2 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -668,16 +668,16 @@ ataid_complete(struct aoedev *d, struct aoetgt *t, unsigned char *id)
 	u16 n;
 
 	/* word 83: command set supported */
-	n = le16_to_cpu(get_unaligned((__le16 *) &id[83<<1]));
+	n = get_unaligned_le16((__le16 *)&id[83 << 1]);
 
 	/* word 86: command set/feature enabled */
-	n |= le16_to_cpu(get_unaligned((__le16 *) &id[86<<1]));
+	n |= get_unaligned_le16((__le16 *)&id[86 << 1]);
 
 	if (n & (1<<10)) {	/* bit 10: LBA 48 */
 		d->flags |= DEVFL_EXT;
 
 		/* word 100: number lba48 sectors */
-		ssize = le64_to_cpu(get_unaligned((__le64 *) &id[100<<1]));
+		ssize = get_unaligned_le64((__le64 *)&id[100 << 1]);
 
 		/* set as in ide-disk.c:init_idedisk_capacity */
 		d->geo.cylinders = ssize;
@@ -688,12 +688,12 @@ ataid_complete(struct aoedev *d, struct aoetgt *t, unsigned char *id)
 		d->flags &= ~DEVFL_EXT;
 
 		/* number lba28 sectors */
-		ssize = le32_to_cpu(get_unaligned((__le32 *) &id[60<<1]));
+		ssize = get_unaligned_le32((__le32 *)&id[60 << 1]);
 
 		/* NOTE: obsolete in ATA 6 */
-		d->geo.cylinders = le16_to_cpu(get_unaligned((__le16 *) &id[54<<1]));
-		d->geo.heads = le16_to_cpu(get_unaligned((__le16 *) &id[55<<1]));
-		d->geo.sectors = le16_to_cpu(get_unaligned((__le16 *) &id[56<<1]));
+		d->geo.cylinders = get_unaligned_le16((__le16 *)&id[54 << 1]);
+		d->geo.heads = get_unaligned_le16((__le16 *)&id[55 << 1]);
+		d->geo.sectors = get_unaligned_le16((__le16 *)&id[56 << 1]);
 	}
 
 	if (d->ssize != ssize)
@@ -779,7 +779,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 	u16 aoemajor;
 
 	hin = (struct aoe_hdr *) skb_mac_header(skb);
-	aoemajor = be16_to_cpu(get_unaligned(&hin->major));
+	aoemajor = get_unaligned_be16(&hin->major);
 	d = aoedev_by_aoeaddr(aoemajor, hin->minor);
 	if (d == NULL) {
 		snprintf(ebuf, sizeof ebuf, "aoecmd_ata_rsp: ata response "
@@ -791,7 +791,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 
 	spin_lock_irqsave(&d->lock, flags);
 
-	n = be32_to_cpu(get_unaligned(&hin->tag));
+	n = get_unaligned_be32(&hin->tag);
 	t = gettgt(d, hin->src);
 	if (t == NULL) {
 		printk(KERN_INFO "aoe: can't find target e%ld.%d:%012llx\n",
@@ -806,9 +806,9 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 		snprintf(ebuf, sizeof ebuf,
 			"%15s e%d.%d    tag=%08x@%08lx\n",
 			"unexpected rsp",
-			be16_to_cpu(get_unaligned(&hin->major)),
+			get_unaligned_be16(&hin->major),
 			hin->minor,
-			be32_to_cpu(get_unaligned(&hin->tag)),
+			get_unaligned_be32(&hin->tag),
 			jiffies);
 		aoechr_error(ebuf);
 		return;
@@ -873,7 +873,7 @@ aoecmd_ata_rsp(struct sk_buff *skb)
 			printk(KERN_INFO
 				"aoe: unrecognized ata command %2.2Xh for %d.%d\n",
 				ahout->cmdstat,
-				be16_to_cpu(get_unaligned(&hin->major)),
+				get_unaligned_be16(&hin->major),
 				hin->minor);
 		}
 	}
@@ -1001,7 +1001,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	 * Enough people have their dip switches set backwards to
 	 * warrant a loud message for this special case.
 	 */
-	aoemajor = be16_to_cpu(get_unaligned(&h->major));
+	aoemajor = get_unaligned_be16(&h->major);
 	if (aoemajor == 0xfff) {
 		printk(KERN_ERR "aoe: Warning: shelf address is all ones.  "
 			"Check shelf dip switches.\n");
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 8460ef7..dece4fb 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -128,7 +128,7 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 	skb_push(skb, ETH_HLEN);	/* (1) */
 
 	h = (struct aoe_hdr *) skb_mac_header(skb);
-	n = be32_to_cpu(get_unaligned(&h->tag));
+	n = get_unaligned_be32(&h->tag);
 	if ((h->verfl & AOEFL_RSP) == 0 || (n & 1<<31))
 		goto exit;
 
@@ -140,7 +140,7 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 			printk(KERN_ERR
 				"%s%d.%d@%s; ecode=%d '%s'\n",
 				"aoe: error packet from ",
-				be16_to_cpu(get_unaligned(&h->major)),
+				get_unaligned_be16(&h->major),
 				h->minor, skb->dev->name,
 				h->err, aoe_errlist[n]);
 		goto exit;
diff --git a/drivers/char/rocket_int.h b/drivers/char/rocket_int.h
index b01d381..d8ced99 100644
--- a/drivers/char/rocket_int.h
+++ b/drivers/char/rocket_int.h
@@ -55,7 +55,7 @@ static inline void sOutW(unsigned short port, unsigned short value)
 
 static inline void out32(unsigned short port, Byte_t *p)
 {
-	u32 value = le32_to_cpu(get_unaligned((__le32 *)p));
+	u32 value = get_unaligned_le32((__le32 *)p);
 #ifdef ROCKET_DEBUG_IO
 	printk(KERN_DEBUG "out32(%x, %lx)...\n", port, value);
 #endif
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f0b00ec..e2b0c7a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -606,7 +606,7 @@ static u8 *fetch_item(__u8 *start, __u8 *end, struct hid_item *item)
 		case 2:
 			if ((end - start) < 2)
 				return NULL;
-			item->data.u16 = le16_to_cpu(get_unaligned((__le16*)start));
+			item->data.u16 = get_unaligned_le16((__le16 *)start);
 			start = (__u8 *)((__le16 *)start + 1);
 			return start;
 
@@ -614,7 +614,7 @@ static u8 *fetch_item(__u8 *start, __u8 *end, struct hid_item *item)
 			item->size++;
 			if ((end - start) < 4)
 				return NULL;
-			item->data.u32 = le32_to_cpu(get_unaligned((__le32*)start));
+			item->data.u32 = get_unaligned_le32((__le32 *)start);
 			start = (__u8 *)((__le32 *)start + 1);
 			return start;
 	}
@@ -765,7 +765,7 @@ static __inline__ __u32 extract(__u8 *report, unsigned offset, unsigned n)
 
 	report += offset >> 3;  /* adjust byte index */
 	offset &= 7;            /* now only need bit offset into one byte */
-	x = le64_to_cpu(get_unaligned((__le64 *) report));
+	x = get_unaligned_le64((__le64 *)report);
 	x = (x >> offset) & ((1ULL << n) - 1);  /* extract bit field */
 	return (u32) x;
 }
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 0598ecf..0d3972d 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -681,7 +681,7 @@ static void idetape_analyze_error(ide_drive_t *drive, u8 *sense)
 	if (test_bit(PC_DMA_ERROR, &pc->flags)) {
 		pc->actually_transferred = pc->request_transfer -
 			tape->blk_size *
-			be32_to_cpu(get_unaligned((u32 *)&sense[3]));
+			get_unaligned_be32((__be32 *)&sense[3]);
 		idetape_update_buffers(pc);
 	}
 
diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 94683f5..794de89 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -527,9 +527,9 @@ static void aiptek_irq(struct urb *urb)
 			    (aiptek->curSetting.pointerMode)) {
 				aiptek->diagnostic = AIPTEK_DIAGNOSTIC_TOOL_DISALLOWED;
 		} else {
-			x = le16_to_cpu(get_unaligned((__le16 *) (data + 1)));
-			y = le16_to_cpu(get_unaligned((__le16 *) (data + 3)));
-			z = le16_to_cpu(get_unaligned((__le16 *) (data + 6)));
+			x = get_unaligned_le16((__le16 *)(data + 1));
+			y = get_unaligned_le16((__le16 *)(data + 3));
+			z = get_unaligned_le16((__le16 *)(data + 6));
 
 			dv = (data[5] & 0x01) != 0 ? 1 : 0;
 			p = (data[5] & 0x02) != 0 ? 1 : 0;
@@ -612,8 +612,8 @@ static void aiptek_irq(struct urb *urb)
 			(aiptek->curSetting.pointerMode)) {
 			aiptek->diagnostic = AIPTEK_DIAGNOSTIC_TOOL_DISALLOWED;
 		} else {
-			x = le16_to_cpu(get_unaligned((__le16 *) (data + 1)));
-			y = le16_to_cpu(get_unaligned((__le16 *) (data + 3)));
+			x = get_unaligned_le16((__le16 *)(data + 1));
+			y = get_unaligned_le16((__le16 *)(data + 3));
 
 			jitterable = data[5] & 0x1c;
 
@@ -678,7 +678,7 @@ static void aiptek_irq(struct urb *urb)
 		pck = (data[1] & aiptek->curSetting.stylusButtonUpper) != 0 ? 1 : 0;
 
 		macro = dv && p && tip && !(data[3] & 1) ? (data[3] >> 1) : -1;
-		z = le16_to_cpu(get_unaligned((__le16 *) (data + 4)));
+		z = get_unaligned_le16((__le16 *)(data + 4));
 
 		if (dv) {
 		        /* If the selected tool changed, reset the old
@@ -756,7 +756,7 @@ static void aiptek_irq(struct urb *urb)
 	 * hat switches (which just so happen to be the macroKeys.)
 	 */
 	else if (data[0] == 6) {
-		macro = le16_to_cpu(get_unaligned((__le16 *) (data + 1)));
+		macro = get_unaligned_le16((__le16 *)(data + 1));
 		if (macro > 0) {
 			input_report_key(inputdev, macroKeyEvents[macro - 1],
 					 0);
@@ -950,7 +950,7 @@ aiptek_query(struct aiptek *aiptek, unsigned char command, unsigned char data)
 		    buf[0], buf[1], buf[2]);
 		ret = -EIO;
 	} else {
-		ret = le16_to_cpu(get_unaligned((__le16 *) (buf + 1)));
+		ret = get_unaligned_le16((__le16 *)(buf + 1));
 	}
 	kfree(buf);
 	return ret;
diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index d2c6da2..b3cc20c 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -245,11 +245,11 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
 			data = report[i];
 			break;
 		case 2:
-			data16 = le16_to_cpu(get_unaligned((__le16 *)&report[i]));
+			data16 = get_unaligned_le16((__le16 *)&report[i]);
 			break;
 		case 3:
 			size = 4;
-			data32 = le32_to_cpu(get_unaligned((__le32 *)&report[i]));
+			data32 = get_unaligned_le32((__le32 *)&report[i]);
 			break;
 		}
 
@@ -695,10 +695,10 @@ static void gtco_urb_callback(struct urb *urbinfo)
 			/*  Fall thru */
 		case 1:
 			/* All reports have X and Y coords in the same place */
-			val = le16_to_cpu(get_unaligned((__le16 *)&device->buffer[1]));
+			val = get_unaligned_le16((__le16 *)&device->buffer[1]);
 			input_report_abs(inputdev, ABS_X, val);
 
-			val = le16_to_cpu(get_unaligned((__le16 *)&device->buffer[3]));
+			val = get_unaligned_le16((__le16 *)&device->buffer[3]);
 			input_report_abs(inputdev, ABS_Y, val);
 
 			/* Ditto for proximity bit */
@@ -762,7 +762,7 @@ static void gtco_urb_callback(struct urb *urbinfo)
 				le_buffer[1]  = (u8)(device->buffer[4] >> 1);
 				le_buffer[1] |= (u8)((device->buffer[5] & 0x1) << 7);
 
-				val = le16_to_cpu(get_unaligned((__le16 *)le_buffer));
+				val = get_unaligned_le16((__le16 *)le_buffer);
 				input_report_abs(inputdev, ABS_Y, val);
 
 				/*
@@ -772,10 +772,10 @@ static void gtco_urb_callback(struct urb *urbinfo)
 				buttonbyte = device->buffer[5] >> 1;
 			} else {
 
-				val = le16_to_cpu(get_unaligned((__le16 *)&device->buffer[1]));
+				val = get_unaligned_le16((__le16 *)&device->buffer[1]);
 				input_report_abs(inputdev, ABS_X, val);
 
-				val = le16_to_cpu(get_unaligned((__le16 *)&device->buffer[3]));
+				val = get_unaligned_le16((__le16 *)&device->buffer[3]);
 				input_report_abs(inputdev, ABS_Y, val);
 
 				buttonbyte = device->buffer[5];
diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index 1182fc1..4130ebc 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -63,8 +63,8 @@ static void kbtab_irq(struct urb *urb)
 		goto exit;
 	}
 
-	kbtab->x = le16_to_cpu(get_unaligned((__le16 *) &data[1]));
-	kbtab->y = le16_to_cpu(get_unaligned((__le16 *) &data[3]));
+	kbtab->x = get_unaligned_le16((__le16 *)&data[1]);
+	kbtab->y = get_unaligned_le16((__le16 *)&data[3]);
 
 	kbtab->pressure = (data[5]);
 
diff --git a/drivers/media/radio/radio-si470x.c b/drivers/media/radio/radio-si470x.c
index 649f14d..526d0b0 100644
--- a/drivers/media/radio/radio-si470x.c
+++ b/drivers/media/radio/radio-si470x.c
@@ -513,8 +513,7 @@ static int si470x_get_register(struct si470x_device *radio, int regnr)
 	retval = si470x_get_report(radio, (void *) &buf, sizeof(buf));
 
 	if (retval >= 0)
-		radio->registers[regnr] = be16_to_cpu(get_unaligned(
-			(unsigned short *) &buf[1]));
+		radio->registers[regnr] = get_unaligned_be16((__be16 *)&buf[1]);
 
 	return (retval < 0) ? -EINVAL : 0;
 }
@@ -553,9 +552,8 @@ static int si470x_get_all_registers(struct si470x_device *radio)
 
 	if (retval >= 0)
 		for (regnr = 0; regnr < RADIO_REGISTER_NUM; regnr++)
-			radio->registers[regnr] = be16_to_cpu(get_unaligned(
-				(unsigned short *)
-				&buf[regnr * RADIO_REGISTER_SIZE + 1]));
+			radio->registers[regnr] =
+				get_unaligned_be16((__be16 *)&buf[regnr * RADIO_REGISTER_SIZE + 1]);
 
 	return (retval < 0) ? -EINVAL : 0;
 }
@@ -586,8 +584,7 @@ static int si470x_get_rds_registers(struct si470x_device *radio)
 	if (retval >= 0)
 		for (regnr = 0; regnr < RDS_REGISTER_NUM; regnr++)
 			radio->registers[STATUSRSSI + regnr] =
-				be16_to_cpu(get_unaligned((unsigned short *)
-				&buf[regnr * RADIO_REGISTER_SIZE + 1]));
+				get_unaligned_be16((__be16 *)&buf[regnr * RADIO_REGISTER_SIZE + 1]);
 
 	return (retval < 0) ? -EINVAL : 0;
 }
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 365024b..3959715 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -340,7 +340,7 @@ checkstatus:
 
 	/* SPI R3, R4, or R7 == R1 + 4 bytes */
 	case MMC_RSP_SPI_R3:
-		cmd->resp[1] = be32_to_cpu(get_unaligned((u32 *)cp));
+		cmd->resp[1] = get_unaligned_be32((__be32 *)cp);
 		break;
 
 	/* SPI R1 == just one status byte */
diff --git a/drivers/net/hamachi.c b/drivers/net/hamachi.c
index b53f6b6..25c9bce 100644
--- a/drivers/net/hamachi.c
+++ b/drivers/net/hamachi.c
@@ -1508,7 +1508,7 @@ static int hamachi_rx(struct net_device *dev)
 					    hmp->rx_buf_sz,
 					    PCI_DMA_FROMDEVICE);
 		buf_addr = (u8 *) hmp->rx_skbuff[entry]->data;
-		frame_status = le32_to_cpu(get_unaligned((__le32*)&(buf_addr[data_size - 12])));
+		frame_status = get_unaligned_le32((__le32 *)&(buf_addr[data_size - 12]));
 		if (hamachi_debug > 4)
 			printk(KERN_DEBUG "  hamachi_rx() status was %8.8x.\n",
 				frame_status);
diff --git a/drivers/net/irda/mcs7780.c b/drivers/net/irda/mcs7780.c
index 93916cf..f12ff1f 100644
--- a/drivers/net/irda/mcs7780.c
+++ b/drivers/net/irda/mcs7780.c
@@ -464,7 +464,7 @@ static void mcs_unwrap_fir(struct mcs_cb *mcs, __u8 *buf, int len)
 	}
 
 	fcs = ~(crc32_le(~0, buf, new_len));
-	if(fcs != le32_to_cpu(get_unaligned((__le32 *)(buf+new_len)))) {
+	if(fcs != get_unaligned_le32((__le32 *)(buf + new_len))) {
 		IRDA_ERROR("crc error calc 0x%x len %d\n", fcs, new_len);
 		mcs->stats.rx_errors++;
 		mcs->stats.rx_crc_errors++;
diff --git a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
index e59c485..36ecae3 100644
--- a/drivers/net/irda/stir4200.c
+++ b/drivers/net/irda/stir4200.c
@@ -329,7 +329,7 @@ static void fir_eof(struct stir_cb *stir)
 	}
 
 	fcs = ~(crc32_le(~0, rx_buff->data, len));
-	if (fcs != le32_to_cpu(get_unaligned((__le32 *)(rx_buff->data+len)))) {
+	if (fcs != get_unaligned_le32((__le32 *)(rx_buff->data + len))) {
 		pr_debug("crc error calc 0x%x len %d\n", fcs, len);
 		stir->stats.rx_errors++;
 		stir->stats.rx_crc_errors++;
diff --git a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
index 6c6fc32..8e7afb5 100644
--- a/drivers/net/tulip/de4x5.c
+++ b/drivers/net/tulip/de4x5.c
@@ -482,7 +482,7 @@
 static char version[] __devinitdata = "de4x5.c:V0.546 2001/02/22 davies-grZBVNbCM2v09vganRf5J0EOCMrvLtNR@public.gmane.org\n";
 
 #define c_char const char
-#define TWIDDLE(a) (u_short)le16_to_cpu(get_unaligned((__le16 *)(a)))
+#define TWIDDLE(a) (u_short)get_unaligned_le16((__le16 *)(a))
 
 /*
 ** MII Information
diff --git a/drivers/net/tulip/de4x5.h b/drivers/net/tulip/de4x5.h
index 9fb8d7f..bee8e28 100644
--- a/drivers/net/tulip/de4x5.h
+++ b/drivers/net/tulip/de4x5.h
@@ -1017,4 +1017,4 @@ struct de4x5_ioctl {
 #define DE4X5_SET_OMR           0x0d /* Set the OMR Register contents */
 #define DE4X5_GET_REG           0x0e /* Get the DE4X5 Registers */
 
-#define MOTO_SROM_BUG    ((lp->active == 8) && (((le32_to_cpu(get_unaligned(((__le32 *)dev->dev_addr))))&0x00ffffff)==0x3e0008))
+#define MOTO_SROM_BUG    ((lp->active == 8) && ((get_unaligned_le32((__le32 *)dev->dev_addr) & 0x00ffffff) == 0x3e0008))
diff --git a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
index 82f404b..ba4e042 100644
--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -327,8 +327,8 @@ static void tulip_up(struct net_device *dev)
 	tp->dirty_rx = tp->dirty_tx = 0;
 
 	if (tp->flags & MC_HASH_ONLY) {
-		u32 addr_low = le32_to_cpu(get_unaligned((__le32 *)dev->dev_addr));
-		u32 addr_high = le16_to_cpu(get_unaligned((__le16 *)(dev->dev_addr+4)));
+		u32 addr_low = get_unaligned_le32((__le32 *)dev->dev_addr);
+		u32 addr_high = get_unaligned_le16((__le16 *)(dev->dev_addr+4));
 		if (tp->chip_id == AX88140) {
 			iowrite32(0, ioaddr + CSR13);
 			iowrite32(addr_low,  ioaddr + CSR14);
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 932d6b1..aeb1005 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -3657,7 +3657,7 @@ void mpi_receive_802_11 (struct airo_info *ai)
 	ptr += hdrlen;
 	if (hdrlen == 24)
 		ptr += 6;
-	gap = le16_to_cpu(get_unaligned((__le16 *)ptr));
+	gap = get_unaligned_le16((__le16 *)ptr);
 	ptr += sizeof(__le16);
 	if (gap) {
 		if (gap <= 8)
diff --git a/drivers/net/wireless/ath5k/base.c b/drivers/net/wireless/ath5k/base.c
index bef967c..fa1edb1 100644
--- a/drivers/net/wireless/ath5k/base.c
+++ b/drivers/net/wireless/ath5k/base.c
@@ -59,8 +59,8 @@
 #include "debug.h"
 
 /* unaligned little endian access */
-#define LE_READ_2(_p) (le16_to_cpu(get_unaligned((__le16 *)(_p))))
-#define LE_READ_4(_p) (le32_to_cpu(get_unaligned((__le32 *)(_p))))
+#define LE_READ_2(_p) (get_unaligned_le16((__le16 *)(_p)))
+#define LE_READ_4(_p) (get_unaligned_le32((__le32 *)(_p)))
 
 enum {
 	ATH_LED_TX,
diff --git a/drivers/net/wireless/b43/main.c b/drivers/net/wireless/b43/main.c
index c73a75b..1ab78e4 100644
--- a/drivers/net/wireless/b43/main.c
+++ b/drivers/net/wireless/b43/main.c
@@ -1915,7 +1915,7 @@ static int b43_write_initvals(struct b43_wldev *dev,
 				goto err_format;
 			array_size -= sizeof(iv->data.d32);
 
-			value = be32_to_cpu(get_unaligned(&iv->data.d32));
+			value = get_unaligned_be32(&iv->data.d32);
 			b43_write32(dev, offset, value);
 
 			iv = (const struct b43_iv *)((const uint8_t *)iv +
diff --git a/drivers/net/wireless/b43legacy/main.c b/drivers/net/wireless/b43legacy/main.c
index 5f3f34e..54f2e01 100644
--- a/drivers/net/wireless/b43legacy/main.c
+++ b/drivers/net/wireless/b43legacy/main.c
@@ -1690,7 +1690,7 @@ static int b43legacy_write_initvals(struct b43legacy_wldev *dev,
 				goto err_format;
 			array_size -= sizeof(iv->data.d32);
 
-			value = be32_to_cpu(get_unaligned(&iv->data.d32));
+			value = get_unaligned_be32(&iv->data.d32);
 			b43legacy_write32(dev, offset, value);
 
 			iv = (const struct b43legacy_iv *)((const uint8_t *)iv +
diff --git a/drivers/net/wireless/libertas/scan.c b/drivers/net/wireless/libertas/scan.c
index 69f94c9..7ca8d22 100644
--- a/drivers/net/wireless/libertas/scan.c
+++ b/drivers/net/wireless/libertas/scan.c
@@ -711,7 +711,7 @@ static int lbs_process_bss(struct bss_descriptor *bss,
 
 	if (*bytesleft >= sizeof(beaconsize)) {
 		/* Extract & convert beacon size from the command buffer */
-		beaconsize = le16_to_cpu(get_unaligned((__le16 *)*pbeaconinfo));
+		beaconsize = get_unaligned_le16((__le16 *)*pbeaconinfo);
 		*bytesleft -= sizeof(beaconsize);
 		*pbeaconinfo += sizeof(beaconsize);
 	}
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.c b/drivers/net/wireless/zd1211rw/zd_usb.c
index 7942b15..cd7eb7c 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
@@ -542,7 +542,7 @@ static void handle_rx_packet(struct zd_usb *usb, const u8 *buffer,
 	{
 		unsigned int l, k, n;
 		for (i = 0, l = 0;; i++) {
-			k = le16_to_cpu(get_unaligned(&length_info->length[i]));
+			k = get_unaligned_le16(&length_info->length[i]);
 			if (k == 0)
 				return;
 			n = l+k;
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index fe6ff3e..ae2e71b 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -1062,7 +1062,7 @@ static int yellowfin_rx(struct net_device *dev)
 		buf_addr = rx_skb->data;
 		data_size = (le32_to_cpu(desc->dbdma_cmd) -
 			le32_to_cpu(desc->result_status)) & 0xffff;
-		frame_status = le16_to_cpu(get_unaligned((__le16*)&(buf_addr[data_size - 2])));
+		frame_status = get_unaligned_le16((__le16*)&(buf_addr[data_size - 2]));
 		if (yellowfin_debug > 4)
 			printk(KERN_DEBUG "  yellowfin_rx() status was %4.4x.\n",
 				   frame_status);
diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index 06a85d7..459c2ee 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -404,11 +404,11 @@ EXPORT_SYMBOL(pcmcia_replace_cis);
 
 static inline u16 cis_get_u16(void *ptr)
 {
-	return le16_to_cpu(get_unaligned((__le16 *) ptr));
+	return get_unaligned_le16((__le16 *)ptr);
 }
 static inline u32 cis_get_u32(void *ptr)
 {
-	return le32_to_cpu(get_unaligned((__le32 *) ptr));
+	return get_unaligned_le32((__le32 *)ptr);
 }
 
 typedef struct tuple_flags {
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index bdd7de7..7d77a8d 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -423,7 +423,7 @@ invalid_datalen:
 			goto out;
 		}
 
-		senselen = be16_to_cpu(get_unaligned((__be16 *) data));
+		senselen = get_unaligned_be16((__be16 *)data);
 		if (datalen < senselen)
 			goto invalid_datalen;
 
diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index c5ec1a5..604872a 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -305,8 +305,8 @@ enum {
  */
 
 #define FW_GET_BYTE(p)	*((__u8 *) (p))
-#define FW_GET_WORD(p)	le16_to_cpu(get_unaligned((__le16 *) (p)))
-#define FW_GET_LONG(p)	le32_to_cpu(get_unaligned((__le32 *) (p)))
+#define FW_GET_WORD(p)	get_unaligned_le16((__le16 *)(p))
+#define FW_GET_LONG(p)	get_unaligned_le32((__le32 *)(p))
 
 #define FW_DIR "ueagle-atm/"
 #define NB_MODEM 4
@@ -1978,11 +1978,11 @@ static void uea_dispatch_cmv_e1(struct uea_softc *sc, struct intr_pkt *intr)
 
 	/* in case of MEMACCESS */
 	if (le16_to_cpu(cmv->wIndex) != dsc->idx ||
-	    le32_to_cpu(get_unaligned(&cmv->dwSymbolicAddress)) != dsc->address ||
+	    get_unaligned_le32(&cmv->dwSymbolicAddress) != dsc->address ||
 	    le16_to_cpu(cmv->wOffsetAddress) != dsc->offset)
 		goto bad2;
 
-	sc->data = le32_to_cpu(get_unaligned(&cmv->dwData));
+	sc->data = get_unaligned_le32(&cmv->dwData);
 	sc->data = sc->data << 16 | sc->data >> 16;
 
 	wake_up_cmv_ack(sc);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 0147ea3..0f4ed11 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -288,7 +288,7 @@ static void acm_ctrl_irq(struct urb *urb)
 
 		case USB_CDC_NOTIFY_SERIAL_STATE:
 
-			newctrl = le16_to_cpu(get_unaligned((__le16 *) data));
+			newctrl = get_unaligned_le16((__le16 *)data);
 
 			if (acm->tty && !acm->clocal && (acm->ctrlin & ~newctrl & ACM_CTRL_DCD)) {
 				dbg("calling hangup");
diff --git a/drivers/usb/gadget/goku_udc.c b/drivers/usb/gadget/goku_udc.c
index d3e7025..6aacbe1 100644
--- a/drivers/usb/gadget/goku_udc.c
+++ b/drivers/usb/gadget/goku_udc.c
@@ -127,7 +127,7 @@ goku_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 
 	/* enabling the no-toggle interrupt mode would need an api hook */
 	mode = 0;
-	max = le16_to_cpu(get_unaligned(&desc->wMaxPacketSize));
+	max = get_unaligned_le16(&desc->wMaxPacketSize);
 	switch (max) {
 	case 64:	mode++;
 	case 32:	mode++;
diff --git a/drivers/usb/gadget/rndis.c b/drivers/usb/gadget/rndis.c
index 3d03664..1d4936c 100644
--- a/drivers/usb/gadget/rndis.c
+++ b/drivers/usb/gadget/rndis.c
@@ -183,14 +183,10 @@ gen_ndis_query_resp (int configNr, u32 OID, u8 *buf, unsigned buf_len,
 		DBG("query OID %08x value, len %d:\n", OID, buf_len);
 		for (i = 0; i < buf_len; i += 16) {
 			DBG("%03d: %08x %08x %08x %08x\n", i,
-				le32_to_cpu(get_unaligned((__le32 *)
-					&buf[i])),
-				le32_to_cpu(get_unaligned((__le32 *)
-					&buf[i + 4])),
-				le32_to_cpu(get_unaligned((__le32 *)
-					&buf[i + 8])),
-				le32_to_cpu(get_unaligned((__le32 *)
-					&buf[i + 12])));
+				get_unaligned_le32((__le32 *)&buf[i]),
+				get_unaligned_le32((__le32 *)&buf[i + 4]),
+				get_unaligned_le32((__le32 *)&buf[i + 8]),
+				get_unaligned_le32((__le32 *)&buf[i + 12]));
 		}
 	}
 
@@ -666,7 +662,7 @@ gen_ndis_query_resp (int configNr, u32 OID, u8 *buf, unsigned buf_len,
 		break;
 	case OID_PNP_QUERY_POWER:
 		DBG("%s: OID_PNP_QUERY_POWER D%d\n", __FUNCTION__,
-				le32_to_cpu(get_unaligned((__le32 *)buf)) - 1);
+				get_unaligned_le32((__le32 *)buf) - 1);
 		/* only suspend is a real power state, and
 		 * it can't be entered by OID_PNP_SET_POWER...
 		 */
@@ -705,14 +701,10 @@ static int gen_ndis_set_resp (u8 configNr, u32 OID, u8 *buf, u32 buf_len,
 		DBG("set OID %08x value, len %d:\n", OID, buf_len);
 		for (i = 0; i < buf_len; i += 16) {
 			DBG("%03d: %08x %08x %08x %08x\n", i,
-				le32_to_cpu(get_unaligned((__le32 *)
-					&buf[i])),
-				le32_to_cpu(get_unaligned((__le32 *)
-					&buf[i + 4])),
-				le32_to_cpu(get_unaligned((__le32 *)
-					&buf[i + 8])),
-				le32_to_cpu(get_unaligned((__le32 *)
-					&buf[i + 12])));
+				get_unaligned_le32((__le32 *)&buf[i]),
+				get_unaligned_le32((__le32 *)&buf[i + 4]),
+				get_unaligned_le32((__le32 *)&buf[i + 8]),
+				get_unaligned_le32((__le32 *)&buf[i + 12]));
 		}
 	}
 
@@ -726,8 +718,7 @@ static int gen_ndis_set_resp (u8 configNr, u32 OID, u8 *buf, u32 buf_len,
 		 *	PROMISCUOUS, DIRECTED,
 		 *	MULTICAST, ALL_MULTICAST, BROADCAST
 		 */
-		*params->filter = (u16) le32_to_cpu(get_unaligned(
-				(__le32 *)buf));
+		*params->filter = (u16)get_unaligned_le32((__le32 *)buf);
 		DBG("%s: OID_GEN_CURRENT_PACKET_FILTER %08x\n",
 			__FUNCTION__, *params->filter);
 
@@ -777,7 +768,7 @@ update_linkstate:
 		 * resuming, Windows forces a reset, and then SET_POWER D0.
 		 * FIXME ... then things go batty; Windows wedges itself.
 		 */
-		i = le32_to_cpu(get_unaligned((__le32 *)buf));
+		i = get_unaligned_le32((__le32 *)buf);
 		DBG("%s: OID_PNP_SET_POWER D%d\n", __FUNCTION__, i - 1);
 		switch (i) {
 		case NdisDeviceStateD0:
@@ -1064,8 +1055,8 @@ int rndis_msg_parser (u8 configNr, u8 *buf)
 		return -ENOMEM;
 
 	tmp = (__le32 *) buf;
-	MsgType   = le32_to_cpu(get_unaligned(tmp++));
-	MsgLength = le32_to_cpu(get_unaligned(tmp++));
+	MsgType   = get_unaligned_le32(tmp++);
+	MsgLength = get_unaligned_le32(tmp++);
 
 	if (configNr >= RNDIS_MAX_CONFIGS)
 		return -ENOTSUPP;
@@ -1296,10 +1287,9 @@ int rndis_rm_hdr(struct sk_buff *skb)
 	tmp++;
 
 	/* DataOffset, DataLength */
-	if (!skb_pull(skb, le32_to_cpu(get_unaligned(tmp++))
-			+ 8 /* offset of DataOffset */))
+	if (!skb_pull(skb, get_unaligned_le32(tmp++)+ 8 /* offset of DataOffset */))
 		return -EOVERFLOW;
-	skb_trim(skb, le32_to_cpu(get_unaligned(tmp++)));
+	skb_trim(skb, get_unaligned_le32(tmp++));
 
 	return 0;
 }
diff --git a/drivers/video/matrox/matroxfb_misc.c b/drivers/video/matrox/matroxfb_misc.c
index ab7fb50..4641fed 100644
--- a/drivers/video/matrox/matroxfb_misc.c
+++ b/drivers/video/matrox/matroxfb_misc.c
@@ -522,8 +522,8 @@ static void parse_bios(unsigned char __iomem* vbios, struct matrox_bios* bd) {
 #endif
 }
 
-#define get_u16(x) (le16_to_cpu(get_unaligned((__u16*)(x))))
-#define get_u32(x) (le32_to_cpu(get_unaligned((__u32*)(x))))
+#define get_u16(x) (get_unaligned_le16((__u16*)(x)))
+#define get_u32(x) (get_unaligned_le16((__u32*)(x)))
 static int parse_pins1(WPMINFO const struct matrox_bios* bd) {
 	unsigned int maxdac;
 
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index e9a89fd..1f93df2 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -236,7 +236,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 	}
 
 	/* check waveform mode table address checksum */
-	wmta = le32_to_cpu(get_unaligned((__le32 *) wfm_hdr->wmta));
+	wmta = get_unaligned_le32((__le32 *)wfm_hdr->wmta);
 	wmta &= 0x00FFFFFF;
 	cksum_idx = wmta + m*4 + 3;
 	if (cksum_idx > size)
@@ -249,7 +249,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 	}
 
 	/* check waveform temperature table address checksum */
-	tta = le32_to_cpu(get_unaligned((int *) (mem + wmta + m*4)));
+	tta = get_unaligned_le32((__le32 *)(mem + wmta + m*4));
 	tta &= 0x00FFFFFF;
 	cksum_idx = tta + trn*4 + 3;
 	if (cksum_idx > size)
@@ -263,7 +263,7 @@ static int load_waveform(u8 *mem, size_t size, u8 *metromem, int m, int t,
 
 	/* here we do the real work of putting the waveform into the
 	metromem buffer. this does runlength decoding of the waveform */
-	wfm_idx = le32_to_cpu(get_unaligned((__le32 *) (mem + tta + trn*4)));
+	wfm_idx = get_unaligned_le32((__le32 *)(mem + tta + trn*4));
 	wfm_idx &= 0x00FFFFFF;
 	owfm_idx = wfm_idx;
 	if (wfm_idx > size)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 53f3cf6..29a520a 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1215,8 +1215,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent,
 		brelse(bh);
 		goto out_invalid;
 	}
-	logical_sector_size =
-		le16_to_cpu(get_unaligned((__le16 *)&b->sector_size));
+	logical_sector_size = get_unaligned_le16((__le16 *)&b->sector_size);
 	if (!is_power_of_2(logical_sector_size)
 	    || (logical_sector_size < 512)
 	    || (PAGE_CACHE_SIZE < logical_sector_size)) {
@@ -1314,8 +1313,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent,
 	sbi->dir_per_block_bits = ffs(sbi->dir_per_block) - 1;
 
 	sbi->dir_start = sbi->fat_start + sbi->fats * sbi->fat_length;
-	sbi->dir_entries =
-		le16_to_cpu(get_unaligned((__le16 *)&b->dir_entries));
+	sbi->dir_entries = get_unaligned_le16((__le16 *)&b->dir_entries);
 	if (sbi->dir_entries & (sbi->dir_per_block - 1)) {
 		if (!silent)
 			printk(KERN_ERR "FAT: bogus directroy-entries per block"
@@ -1327,7 +1325,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent,
 	rootdir_sectors = sbi->dir_entries
 		* sizeof(struct msdos_dir_entry) / sb->s_blocksize;
 	sbi->data_start = sbi->dir_start + rootdir_sectors;
-	total_sectors = le16_to_cpu(get_unaligned((__le16 *)&b->sectors));
+	total_sectors = get_unaligned_le16((__le16 *)&b->sectors);
 	if (total_sectors == 0)
 		total_sectors = le32_to_cpu(b->total_sect);
 
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 72cab78..4c465a9 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -47,7 +47,7 @@ static int hfsplus_read_mdb(void *bufptr, struct hfsplus_wd *wd)
 		return 0;
 	wd->ablk_start = be16_to_cpu(*(__be16 *)(bufptr + HFSP_WRAPOFF_ABLKSTART));
 
-	extent = be32_to_cpu(get_unaligned((__be32 *)(bufptr + HFSP_WRAPOFF_EMBEDEXT)));
+	extent = get_unaligned_be32((__be32 *)(bufptr + HFSP_WRAPOFF_EMBEDEXT));
 	wd->embed_start = (extent >> 16) & 0xFFFF;
 	wd->embed_count = extent & 0xFFFF;
 
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index d1bdf8a..0b3daab 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -78,29 +78,29 @@ static inline int isonum_712(char *p)
 }
 static inline unsigned int isonum_721(char *p)
 {
-	return le16_to_cpu(get_unaligned((__le16 *)p));
+	return get_unaligned_le16((__le16 *)p);
 }
 static inline unsigned int isonum_722(char *p)
 {
-	return be16_to_cpu(get_unaligned((__le16 *)p));
+	return get_unaligned_be16((__be16 *)p);
 }
 static inline unsigned int isonum_723(char *p)
 {
 	/* Ignore bigendian datum due to broken mastering programs */
-	return le16_to_cpu(get_unaligned((__le16 *)p));
+	return get_unaligned_le16((__le16 *)p);
 }
 static inline unsigned int isonum_731(char *p)
 {
-	return le32_to_cpu(get_unaligned((__le32 *)p));
+	return get_unaligned_le32((__le32 *)p);
 }
 static inline unsigned int isonum_732(char *p)
 {
-	return be32_to_cpu(get_unaligned((__le32 *)p));
+	return get_unaligned_be32((__be32 *)p);
 }
 static inline unsigned int isonum_733(char *p)
 {
 	/* Ignore bigendian datum due to broken mastering programs */
-	return le32_to_cpu(get_unaligned((__le32 *)p));
+	return get_unaligned_le32((__le32 *)p);
 }
 extern int iso_date(char *, int);
 
diff --git a/fs/ncpfs/ncplib_kernel.c b/fs/ncpfs/ncplib_kernel.c
index df6d60b..02282bf 100644
--- a/fs/ncpfs/ncplib_kernel.c
+++ b/fs/ncpfs/ncplib_kernel.c
@@ -120,24 +120,24 @@ static __u8
 
 static inline __u16 WVAL_LH(void* data)
 {
-	return le16_to_cpu(get_unaligned((__le16*)data));
+	return get_unaligned_le16((__le16*)data);
 }
 
 static __u16
  ncp_reply_le16(struct ncp_server *server, int offset)
 {
-	return le16_to_cpu(get_unaligned((__le16 *) ncp_reply_data(server, offset)));
+	return get_unaligned_le16((__le16 *)ncp_reply_data(server, offset));
 }
 
 static __u16
  ncp_reply_be16(struct ncp_server *server, int offset)
 {
-	return be16_to_cpu(get_unaligned((__be16 *) ncp_reply_data(server, offset)));
+	return get_unaligned_be16((__be16 *)ncp_reply_data(server, offset));
 }
 
 static inline __u32 DVAL_LH(void* data)
 {
-	return le32_to_cpu(get_unaligned((__le32*)data));
+	return get_unaligned_le32((__le32 *)data);
 }
 
 static __le32
@@ -1006,8 +1006,8 @@ ncp_read_bounce(struct ncp_server *server, const char *file_id,
 	result = ncp_request2(server, 72, bounce, bufsize);
 	ncp_unlock_server(server);
 	if (!result) {
-		int len = be16_to_cpu(get_unaligned((__be16*)((char*)bounce + 
-			  sizeof(struct ncp_reply_header))));
+		int len = get_unaligned_be16((__be16*)((char*)bounce + 
+			  sizeof(struct ncp_reply_header)));
 		result = -EIO;
 		if (len <= to_read) {
 			char* source;
diff --git a/fs/partitions/ldm.h b/fs/partitions/ldm.h
index 80f63b5..1357f44 100644
--- a/fs/partitions/ldm.h
+++ b/fs/partitions/ldm.h
@@ -99,9 +99,9 @@ struct parsed_partitions;
 #define TOC_BITMAP2		"log"		/* bitmaps in the TOCBLOCK. */
 
 /* Most numbers we deal with are big-endian and won't be aligned. */
-#define BE16(x)			((u16)be16_to_cpu(get_unaligned((__be16*)(x))))
-#define BE32(x)			((u32)be32_to_cpu(get_unaligned((__be32*)(x))))
-#define BE64(x)			((u64)be64_to_cpu(get_unaligned((__be64*)(x))))
+#define BE16(x)			((u16)get_unaligned_be16((__be16*)(x)))
+#define BE32(x)			((u32)get_unaligned_be32((__be32*)(x)))
+#define BE64(x)			((u64)get_unaligned_be64((__be64*)(x)))
 
 /* Borrowed from msdos.c */
 #define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index a550546..de749a3 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -634,8 +634,8 @@ xfs_iformat_extents(
 		xfs_validate_extents(ifp, nex, XFS_EXTFMT_INODE(ip));
 		for (i = 0; i < nex; i++, dp++) {
 			xfs_bmbt_rec_host_t *ep = xfs_iext_get_ext(ifp, i);
-			ep->l0 = be64_to_cpu(get_unaligned(&dp->l0));
-			ep->l1 = be64_to_cpu(get_unaligned(&dp->l1));
+			ep->l0 = get_unaligned_be64(&dp->l0);
+			ep->l1 = get_unaligned_be64(&dp->l1);
 		}
 		XFS_BMAP_TRACE_EXLIST(ip, nex, whichfork);
 		if (whichfork != XFS_DATA_FORK ||
diff --git a/include/asm-alpha/unaligned.h b/include/asm-alpha/unaligned.h
index a1d7284..18acc19 100644
--- a/include/asm-alpha/unaligned.h
+++ b/include/asm-alpha/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef __ALPHA_UNALIGNED_H
 #define __ALPHA_UNALIGNED_H
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_le.h>
 
 #endif
diff --git a/include/asm-arm/unaligned.h b/include/asm-arm/unaligned.h
index 5db03cf..d5cf478 100644
--- a/include/asm-arm/unaligned.h
+++ b/include/asm-arm/unaligned.h
@@ -1,171 +1,7 @@
 #ifndef __ASM_ARM_UNALIGNED_H
 #define __ASM_ARM_UNALIGNED_H
 
-#include <asm/types.h>
-
-extern int __bug_unaligned_x(const void *ptr);
-
-/*
- * What is the most efficient way of loading/storing an unaligned value?
- *
- * That is the subject of this file.  Efficiency here is defined as
- * minimum code size with minimum register usage for the common cases.
- * It is currently not believed that long longs are common, so we
- * trade efficiency for the chars, shorts and longs against the long
- * longs.
- *
- * Current stats with gcc 2.7.2.2 for these functions:
- *
- *	ptrsize	get:	code	regs	put:	code	regs
- *	1		1	1		1	2
- *	2		3	2		3	2
- *	4		7	3		7	3
- *	8		20	6		16	6
- *
- * gcc 2.95.1 seems to code differently:
- *
- *	ptrsize	get:	code	regs	put:	code	regs
- *	1		1	1		1	2
- *	2		3	2		3	2
- *	4		7	4		7	4
- *	8		19	8		15	6
- *
- * which may or may not be more efficient (depending upon whether
- * you can afford the extra registers).  Hopefully the gcc 2.95
- * is inteligent enough to decide if it is better to use the
- * extra register, but evidence so far seems to suggest otherwise.
- *
- * Unfortunately, gcc is not able to optimise the high word
- * out of long long >> 32, or the low word from long long << 32
- */
-
-#define __get_unaligned_2_le(__p)					\
-	(unsigned int)(__p[0] | __p[1] << 8)
-
-#define __get_unaligned_2_be(__p)					\
-	(unsigned int)(__p[0] << 8 | __p[1])
-
-#define __get_unaligned_4_le(__p)					\
-	(unsigned int)(__p[0] | __p[1] << 8 | __p[2] << 16 | __p[3] << 24)
-
-#define __get_unaligned_4_be(__p)					\
-	(unsigned int)(__p[0] << 24 | __p[1] << 16 | __p[2] << 8 | __p[3])
-
-#define __get_unaligned_8_le(__p)					\
-	((unsigned long long)__get_unaligned_4_le((__p+4)) << 32 |	\
-		__get_unaligned_4_le(__p))
-
-#define __get_unaligned_8_be(__p)					\
-	((unsigned long long)__get_unaligned_4_be(__p) << 32 |		\
-		__get_unaligned_4_be((__p+4)))
-
-#define __get_unaligned_le(ptr)						\
-	((__force typeof(*(ptr)))({					\
-		const __u8 *__p = (const __u8 *)(ptr);			\
-		__builtin_choose_expr(sizeof(*(ptr)) == 1, *__p,	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 2, __get_unaligned_2_le(__p),	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 4, __get_unaligned_4_le(__p),	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 8, __get_unaligned_8_le(__p),	\
-		    (void)__bug_unaligned_x(__p)))));			\
-	}))
-
-#define __get_unaligned_be(ptr)						\
-	((__force typeof(*(ptr)))({					\
-		const __u8 *__p = (const __u8 *)(ptr);			\
-		__builtin_choose_expr(sizeof(*(ptr)) == 1, *__p,	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 2, __get_unaligned_2_be(__p),	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 4, __get_unaligned_4_be(__p),	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 8, __get_unaligned_8_be(__p),	\
-		    (void)__bug_unaligned_x(__p)))));			\
-	}))
-
-
-static inline void __put_unaligned_2_le(__u32 __v, register __u8 *__p)
-{
-	*__p++ = __v;
-	*__p++ = __v >> 8;
-}
-
-static inline void __put_unaligned_2_be(__u32 __v, register __u8 *__p)
-{
-	*__p++ = __v >> 8;
-	*__p++ = __v;
-}
-
-static inline void __put_unaligned_4_le(__u32 __v, register __u8 *__p)
-{
-	__put_unaligned_2_le(__v >> 16, __p + 2);
-	__put_unaligned_2_le(__v, __p);
-}
-
-static inline void __put_unaligned_4_be(__u32 __v, register __u8 *__p)
-{
-	__put_unaligned_2_be(__v >> 16, __p);
-	__put_unaligned_2_be(__v, __p + 2);
-}
-
-static inline void __put_unaligned_8_le(const unsigned long long __v, register __u8 *__p)
-{
-	/*
-	 * tradeoff: 8 bytes of stack for all unaligned puts (2
-	 * instructions), or an extra register in the long long
-	 * case - go for the extra register.
-	 */
-	__put_unaligned_4_le(__v >> 32, __p+4);
-	__put_unaligned_4_le(__v, __p);
-}
-
-static inline void __put_unaligned_8_be(const unsigned long long __v, register __u8 *__p)
-{
-	/*
-	 * tradeoff: 8 bytes of stack for all unaligned puts (2
-	 * instructions), or an extra register in the long long
-	 * case - go for the extra register.
-	 */
-	__put_unaligned_4_be(__v >> 32, __p);
-	__put_unaligned_4_be(__v, __p+4);
-}
-
-/*
- * Try to store an unaligned value as efficiently as possible.
- */
-#define __put_unaligned_le(val,ptr)					\
-	({							\
-		(void)sizeof(*(ptr) = (val));			\
-		switch (sizeof(*(ptr))) {			\
-		case 1:						\
-			*(ptr) = (val);				\
-			break;					\
-		case 2: __put_unaligned_2_le((__force u16)(val),(__u8 *)(ptr));	\
-			break;					\
-		case 4:	__put_unaligned_4_le((__force u32)(val),(__u8 *)(ptr));	\
-			break;					\
-		case 8:	__put_unaligned_8_le((__force u64)(val),(__u8 *)(ptr)); \
-			break;					\
-		default: __bug_unaligned_x(ptr);		\
-			break;					\
-		}						\
-		(void) 0;					\
-	})
-
-#define __put_unaligned_be(val,ptr)					\
-	({							\
-		(void)sizeof(*(ptr) = (val));			\
-		switch (sizeof(*(ptr))) {			\
-		case 1:						\
-			*(ptr) = (val);				\
-			break;					\
-		case 2: __put_unaligned_2_be((__force u16)(val),(__u8 *)(ptr));	\
-			break;					\
-		case 4:	__put_unaligned_4_be((__force u32)(val),(__u8 *)(ptr));	\
-			break;					\
-		case 8:	__put_unaligned_8_be((__force u64)(val),(__u8 *)(ptr)); \
-			break;					\
-		default: __bug_unaligned_x(ptr);		\
-			break;					\
-		}						\
-		(void) 0;					\
-	})
+#include <linux/unaligned/generic.h>
 
 /*
  * Select endianness
diff --git a/include/asm-avr32/unaligned.h b/include/asm-avr32/unaligned.h
index 36f5fd4..28fa20e 100644
--- a/include/asm-avr32/unaligned.h
+++ b/include/asm-avr32/unaligned.h
@@ -11,6 +11,6 @@
  * optimize word loads in general.
  */
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #endif /* __ASM_AVR32_UNALIGNED_H */
diff --git a/include/asm-blackfin/unaligned.h b/include/asm-blackfin/unaligned.h
index 10081dc..25861cd 100644
--- a/include/asm-blackfin/unaligned.h
+++ b/include/asm-blackfin/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef __BFIN_UNALIGNED_H
 #define __BFIN_UNALIGNED_H
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_le.h>
 
 #endif				/* __BFIN_UNALIGNED_H */
diff --git a/include/asm-cris/unaligned.h b/include/asm-cris/unaligned.h
index 7fbbb39..8bd3555 100644
--- a/include/asm-cris/unaligned.h
+++ b/include/asm-cris/unaligned.h
@@ -3,14 +3,8 @@
 
 /*
  * CRIS can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
 
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif
diff --git a/include/asm-frv/unaligned.h b/include/asm-frv/unaligned.h
index dc8e9c9..06224d9 100644
--- a/include/asm-frv/unaligned.h
+++ b/include/asm-frv/unaligned.h
@@ -9,9 +9,175 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef _ASM_UNALIGNED_H
-#define _ASM_UNALIGNED_H
+#ifndef _ASM_FRV_UNALIGNED_H
+#define _ASM_FRV_UNALIGNED_H
 
+#include <linux/unaligned/little_endian.h>
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return __get_unaligned_le16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return __get_unaligned_le32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return __get_unaligned_le64((const u8 *)p);
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	u8 a;
+	u16 x;
+	const char *__p = (const char *)p;
+
+	asm("	ldub%I2		%M2,%0		\n"
+	    "	ldub%I3.p	%M3,%1		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%1,%0	\n"
+	    : "=&r"(x), "=&r"(a)
+	    : "m"(__p[0]),  "m"(__p[1])
+	    );
+
+	return x;
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	u8 a;
+	u32 x;
+	const char *__p = (const char *)p;
+
+	asm("	ldub%I2		%M2,%0		\n"
+	    "	ldub%I3.p	%M3,%1		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%1,%0	\n"
+	    "	ldub%I4.p	%M4,%1		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%1,%0	\n"
+	    "	ldub%I5.p	%M5,%1		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%1,%0	\n"
+	    : "=&r"(x), "=&r"(a)
+	    : "m"(__p[0]),  "m"(__p[1]), "m"(__p[2]), "m"(__p[3])
+	    );
+
+	return x;
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	u8 a;
+	u32 x;
+	const char *__p = (const char *)p;
+	union { u64 x; u32 y[2]; } z;
+
+	asm("	ldub%I3		%M3,%0		\n"
+	    "	ldub%I4.p	%M4,%2		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%2,%0	\n"
+	    "	ldub%I5.p	%M5,%2		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%2,%0	\n"
+	    "	ldub%I6.p	%M6,%2		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%2,%0	\n"
+	    "	ldub%I7		%M7,%1		\n"
+	    "	ldub%I8.p	%M8,%2		\n"
+	    "	slli		%1,#8,%1	\n"
+	    "	or		%1,%2,%1	\n"
+	    "	ldub%I9.p	%M9,%2		\n"
+	    "	slli		%1,#8,%1	\n"
+	    "	or		%1,%2,%1	\n"
+	    "	ldub%I10.p	%M10,%2		\n"
+	    "	slli		%1,#8,%1	\n"
+	    "	or		%1,%2,%1	\n"
+	    : "=&r"(z.y[0]), "=&r"(z.y[1]), "=&r"(a)
+	    : "m"(__p[0]), "m"(__p[1]), "m"(__p[2]), "m"(__p[3]),
+	      "m"(__p[4]), "m"(__p[5]), "m"(__p[6]), "m"(__p[7])
+	    );
+	x = z.x;
+
+	return x;
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_le16(val, p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_le32(val, p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_le64(val, p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	char *__p = p;
+	int x;
+
+	asm("	stb%I1.p	%0,%M1		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I2		%0,%M2		\n"
+	    : "=r"(x), "=m"(__p[1]),  "=m"(__p[0])
+	    : "0"(val)
+	    );
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	char *__p = p;
+	int x;
+
+	asm("	stb%I1.p	%0,%M1		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I2.p	%0,%M2		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I3.p	%0,%M3		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I4		%0,%M4		\n"
+	    : "=r"(x), "=m"(__p[3]),  "=m"(__p[2]), "=m"(__p[1]), "=m"(__p[0])
+	    : "0"(val)
+	    );
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	char *__p = p;
+	u32 __high, __low;
+
+	__high = val >> 32;
+	__low = val & 0xffffffff;
+	asm("	stb%I2.p	%0,%M2		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I3.p	%0,%M3		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I4.p	%0,%M4		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I5.p	%0,%M5		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I6.p	%1,%M6		\n"
+	    "	srli		%1,#8,%1	\n"
+	    "	stb%I7.p	%1,%M7		\n"
+	    "	srli		%1,#8,%1	\n"
+	    "	stb%I8.p	%1,%M8		\n"
+	    "	srli		%1,#8,%1	\n"
+	    "	stb%I9		%1,%M9		\n"
+	    : "=&r"(__low), "=&r"(__high), "=m"(__p[7]), "=m"(__p[6]),
+	      "=m"(__p[5]), "=m"(__p[4]), "=m"(__p[3]), "=m"(__p[2]),
+	      "=m"(__p[1]), "=m"(__p[0])
+	    : "0"(__low), "1"(__high)
+	    );
+}
 
 /*
  * Unaligned accesses on uClinux can't be performed in a fault handler - the
@@ -49,153 +215,51 @@ extern int handle_misalignment(unsigned long esr0, unsigned long ear0, unsigned
 
 #else
 
-#define get_unaligned(ptr)							\
-({										\
-	typeof(*(ptr)) x;							\
-	const char *__p = (const char *) (ptr);					\
-										\
-	switch (sizeof(x)) {							\
-	case 1:									\
-		x = *(ptr);							\
-		break;								\
-	case 2:									\
-	{									\
-		uint8_t a;							\
-		asm("	ldub%I2		%M2,%0		\n"			\
-		    "	ldub%I3.p	%M3,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    : "=&r"(x), "=&r"(a)					\
-		    : "m"(__p[0]),  "m"(__p[1])					\
-		    );								\
-		break;								\
-	}									\
-										\
-	case 4:									\
-	{									\
-		uint8_t a;							\
-		asm("	ldub%I2		%M2,%0		\n"			\
-		    "	ldub%I3.p	%M3,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    "	ldub%I4.p	%M4,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    "	ldub%I5.p	%M5,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    : "=&r"(x), "=&r"(a)					\
-		    : "m"(__p[0]),  "m"(__p[1]), "m"(__p[2]), "m"(__p[3])	\
-		    );								\
-		break;								\
-	}									\
-										\
-	case 8:									\
-	{									\
-		union { uint64_t x; u32 y[2]; } z;				\
-		uint8_t a;							\
-		asm("	ldub%I3		%M3,%0		\n"			\
-		    "	ldub%I4.p	%M4,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I5.p	%M5,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I6.p	%M6,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I7		%M7,%1		\n"			\
-		    "	ldub%I8.p	%M8,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    "	ldub%I9.p	%M9,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    "	ldub%I10.p	%M10,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    : "=&r"(z.y[0]), "=&r"(z.y[1]), "=&r"(a)			\
-		    : "m"(__p[0]), "m"(__p[1]), "m"(__p[2]), "m"(__p[3]),	\
-		      "m"(__p[4]), "m"(__p[5]), "m"(__p[6]), "m"(__p[7])	\
-		    );								\
-		x = z.x;							\
-		break;								\
-	}									\
-										\
-	default:								\
-		x = 0;								\
-		BUG();								\
-		break;								\
-	}									\
-										\
-	x;									\
-})
+#define get_unaligned(ptr) ({				\
+	typeof(*(ptr)) x;				\
+							\
+	switch (sizeof(x)) {				\
+	case 1:						\
+		x = *(ptr);				\
+		break;					\
+	case 2:						\
+		x = get_unaligned_be16((ptr));		\
+		break;					\
+	case 4:						\
+		x = get_unaligned_be32((ptr));		\
+		break;					\
+	case 8:						\
+		x = get_unaligned_be64((ptr));		\
+		break;					\
+	default:					\
+		BUILD_BUG_ON(1);			\
+		break;					\
+	}						\
+	x; })
 
-#define put_unaligned(val, ptr)								\
-do {											\
-	char *__p = (char *) (ptr);							\
-	int x;										\
-											\
-	switch (sizeof(*ptr)) {								\
-	case 2:										\
-	{										\
-		asm("	stb%I1.p	%0,%M1		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I2		%0,%M2		\n"				\
-		    : "=r"(x), "=m"(__p[1]),  "=m"(__p[0])				\
-		    : "0"(val)								\
-		    );									\
-		break;									\
-	}										\
-											\
-	case 4:										\
-	{										\
-		asm("	stb%I1.p	%0,%M1		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I2.p	%0,%M2		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I3.p	%0,%M3		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I4		%0,%M4		\n"				\
-		    : "=r"(x), "=m"(__p[3]),  "=m"(__p[2]), "=m"(__p[1]), "=m"(__p[0])	\
-		    : "0"(val)								\
-		    );									\
-		break;									\
-	}										\
-											\
-	case 8:										\
-	{										\
-		uint32_t __high, __low;							\
-		__high = (uint64_t)val >> 32;						\
-		__low = val & 0xffffffff;						\
-		asm("	stb%I2.p	%0,%M2		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I3.p	%0,%M3		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I4.p	%0,%M4		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I5.p	%0,%M5		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I6.p	%1,%M6		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I7.p	%1,%M7		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I8.p	%1,%M8		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I9		%1,%M9		\n"				\
-		    : "=&r"(__low), "=&r"(__high), "=m"(__p[7]), "=m"(__p[6]), 		\
-		      "=m"(__p[5]), "=m"(__p[4]), "=m"(__p[3]), "=m"(__p[2]), 		\
-		      "=m"(__p[1]), "=m"(__p[0])					\
-		    : "0"(__low), "1"(__high)						\
-		    );									\
-		break;									\
-	}										\
-											\
-        default:									\
-		*(ptr) = (val);								\
-		break;									\
-	}										\
-} while(0)
+#define put_unaligned(val, ptr) ({			\
+							\
+	char *__p = (char *) (ptr);			\
+	int x;						\
+							\
+	switch (sizeof(*ptr)) {				\
+	case 1:						\
+		*(ptr) = (val);				\
+		break;					\
+	case 2:						\
+		put_unaligned_be16((val), (ptr));	\
+		break;					\
+	case 4:						\
+		put_unaligned_be32((val), (ptr));	\
+		break;					\
+	case 8:						\
+		put_unaligned_be64((val), (ptr));	\
+		break;					\
+	default:					\
+		BUILD_BUG_ON(1);			\
+		break;					\
+	}						\
+	(void)0; })
 
 #endif
 
diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
deleted file mode 100644
index 2fe1b2e..0000000
--- a/include/asm-generic/unaligned.h
+++ /dev/null
@@ -1,124 +0,0 @@
-#ifndef _ASM_GENERIC_UNALIGNED_H_
-#define _ASM_GENERIC_UNALIGNED_H_
-
-/*
- * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents. 
- *
- * This is based almost entirely upon Richard Henderson's
- * asm-alpha/unaligned.h implementation.  Some comments were
- * taken from David Mosberger's asm-ia64/unaligned.h header.
- */
-
-#include <linux/types.h>
-
-/* 
- * The main single-value unaligned transfer routines.
- */
-#define get_unaligned(ptr) \
-	__get_unaligned((ptr), sizeof(*(ptr)))
-#define put_unaligned(x,ptr) \
-	((void)sizeof(*(ptr)=(x)),\
-	__put_unaligned((__force __u64)(x), (ptr), sizeof(*(ptr))))
-
-/*
- * This function doesn't actually exist.  The idea is that when
- * someone uses the macros below with an unsupported size (datatype),
- * the linker will alert us to the problem via an unresolved reference
- * error.
- */
-extern void bad_unaligned_access_length(void) __attribute__((noreturn));
-
-struct __una_u64 { __u64 x __attribute__((packed)); };
-struct __una_u32 { __u32 x __attribute__((packed)); };
-struct __una_u16 { __u16 x __attribute__((packed)); };
-
-/*
- * Elemental unaligned loads 
- */
-
-static inline __u64 __uldq(const __u64 *addr)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *) addr;
-	return ptr->x;
-}
-
-static inline __u32 __uldl(const __u32 *addr)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *) addr;
-	return ptr->x;
-}
-
-static inline __u16 __uldw(const __u16 *addr)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *) addr;
-	return ptr->x;
-}
-
-/*
- * Elemental unaligned stores 
- */
-
-static inline void __ustq(__u64 val, __u64 *addr)
-{
-	struct __una_u64 *ptr = (struct __una_u64 *) addr;
-	ptr->x = val;
-}
-
-static inline void __ustl(__u32 val, __u32 *addr)
-{
-	struct __una_u32 *ptr = (struct __una_u32 *) addr;
-	ptr->x = val;
-}
-
-static inline void __ustw(__u16 val, __u16 *addr)
-{
-	struct __una_u16 *ptr = (struct __una_u16 *) addr;
-	ptr->x = val;
-}
-
-#define __get_unaligned(ptr, size) ({		\
-	const void *__gu_p = ptr;		\
-	__u64 __val;				\
-	switch (size) {				\
-	case 1:					\
-		__val = *(const __u8 *)__gu_p;	\
-		break;				\
-	case 2:					\
-		__val = __uldw(__gu_p);		\
-		break;				\
-	case 4:					\
-		__val = __uldl(__gu_p);		\
-		break;				\
-	case 8:					\
-		__val = __uldq(__gu_p);		\
-		break;				\
-	default:				\
-		bad_unaligned_access_length();	\
-	};					\
-	(__force __typeof__(*(ptr)))__val;	\
-})
-
-#define __put_unaligned(val, ptr, size)		\
-({						\
-	void *__gu_p = ptr;			\
-	switch (size) {				\
-	case 1:					\
-		*(__u8 *)__gu_p = (__force __u8)val;		\
-	        break;				\
-	case 2:					\
-		__ustw((__force __u16)val, __gu_p);		\
-		break;				\
-	case 4:					\
-		__ustl((__force __u32)val, __gu_p);		\
-		break;				\
-	case 8:					\
-		__ustq(val, __gu_p);		\
-		break;				\
-	default:				\
-	    	bad_unaligned_access_length();	\
-	};					\
-	(void)0;				\
-})
-
-#endif /* _ASM_GENERIC_UNALIGNED_H */
diff --git a/include/asm-h8300/unaligned.h b/include/asm-h8300/unaligned.h
index ffb67f4..e8ff49d 100644
--- a/include/asm-h8300/unaligned.h
+++ b/include/asm-h8300/unaligned.h
@@ -1,15 +1,6 @@
 #ifndef __H8300_UNALIGNED_H
 #define __H8300_UNALIGNED_H
 
-
-/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
+#include <linux/unaligned/no_builtin_memcpy.h>
 
 #endif
diff --git a/include/asm-ia64/unaligned.h b/include/asm-ia64/unaligned.h
index bb85598..2134205 100644
--- a/include/asm-ia64/unaligned.h
+++ b/include/asm-ia64/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_IA64_UNALIGNED_H
 #define _ASM_IA64_UNALIGNED_H
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_le.h>
 
 #endif /* _ASM_IA64_UNALIGNED_H */
diff --git a/include/asm-m32r/unaligned.h b/include/asm-m32r/unaligned.h
index fccc180..5a4c931 100644
--- a/include/asm-m32r/unaligned.h
+++ b/include/asm-m32r/unaligned.h
@@ -1,19 +1,6 @@
 #ifndef _ASM_M32R_UNALIGNED_H
 #define _ASM_M32R_UNALIGNED_H
 
-/*
- * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents.
- */
-
-#include <asm/string.h>
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
+#include <linux/unaligned/no_builtin_memcpy.h>
 
 #endif /* _ASM_M32R_UNALIGNED_H */
diff --git a/include/asm-m68k/unaligned.h b/include/asm-m68k/unaligned.h
index 804cb3f..94b4a77 100644
--- a/include/asm-m68k/unaligned.h
+++ b/include/asm-m68k/unaligned.h
@@ -3,14 +3,7 @@
 
 /*
  * The m68k can do unaligned accesses itself.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif
diff --git a/include/asm-m68knommu/unaligned.h b/include/asm-m68knommu/unaligned.h
index 869e9dd..6b5c7a2 100644
--- a/include/asm-m68knommu/unaligned.h
+++ b/include/asm-m68knommu/unaligned.h
@@ -4,19 +4,13 @@
 
 #ifdef CONFIG_COLDFIRE
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #else
 /*
  * The m68k can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-#define get_unaligned(ptr) (*(ptr))
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif
 
diff --git a/include/asm-mips/unaligned.h b/include/asm-mips/unaligned.h
index 3249049..bddbbfb 100644
--- a/include/asm-mips/unaligned.h
+++ b/include/asm-mips/unaligned.h
@@ -5,25 +5,15 @@
  *
  * Copyright (C) 2007 Ralf Baechle (ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org)
  */
-#ifndef __ASM_GENERIC_UNALIGNED_H
-#define __ASM_GENERIC_UNALIGNED_H
+#ifndef __ASM_MIPS_UNALIGNED_H
+#define __ASM_MIPS_UNALIGNED_H
 
-#include <linux/compiler.h>
+#if defined(__MIPSEB__)
+#  include <linux/unaligned/generic_be.h>
+#elif defined(__MIPSEL__)
+#  include <linux/unaligned/generic_le.h>
+#else
+#  error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
+#endif
 
-#define get_unaligned(ptr)					\
-({								\
-	struct __packed {					\
-		typeof(*(ptr)) __v;				\
-	} *__p = (void *) (ptr);				\
-	__p->__v;						\
-})
-
-#define put_unaligned(val, ptr)					\
-do {								\
-	struct __packed {					\
-		typeof(*(ptr)) __v;				\
-	} *__p = (void *) (ptr);				\
-	__p->__v = (val);					\
-} while(0)
-
-#endif /* __ASM_GENERIC_UNALIGNED_H */
+#endif /* __ASM_MIPS_UNALIGNED_H */
diff --git a/include/asm-mn10300/unaligned.h b/include/asm-mn10300/unaligned.h
index cad3afb..c377ba0 100644
--- a/include/asm-mn10300/unaligned.h
+++ b/include/asm-mn10300/unaligned.h
@@ -8,129 +8,9 @@
  * as published by the Free Software Foundation; either version
  * 2 of the Licence, or (at your option) any later version.
  */
-#ifndef _ASM_UNALIGNED_H
-#define _ASM_UNALIGNED_H
+#ifndef _ASM_MN10300_UNALIGNED_H
+#define _ASM_MN10300_UNALIGNED_H
 
-#include <asm/types.h>
-
-#if 0
-extern int __bug_unaligned_x(void *ptr);
-
-/*
- * What is the most efficient way of loading/storing an unaligned value?
- *
- * That is the subject of this file.  Efficiency here is defined as
- * minimum code size with minimum register usage for the common cases.
- * It is currently not believed that long longs are common, so we
- * trade efficiency for the chars, shorts and longs against the long
- * longs.
- *
- * Current stats with gcc 2.7.2.2 for these functions:
- *
- *	ptrsize	get:	code	regs	put:	code	regs
- *	1		1	1		1	2
- *	2		3	2		3	2
- *	4		7	3		7	3
- *	8		20	6		16	6
- *
- * gcc 2.95.1 seems to code differently:
- *
- *	ptrsize	get:	code	regs	put:	code	regs
- *	1		1	1		1	2
- *	2		3	2		3	2
- *	4		7	4		7	4
- *	8		19	8		15	6
- *
- * which may or may not be more efficient (depending upon whether
- * you can afford the extra registers).  Hopefully the gcc 2.95
- * is inteligent enough to decide if it is better to use the
- * extra register, but evidence so far seems to suggest otherwise.
- *
- * Unfortunately, gcc is not able to optimise the high word
- * out of long long >> 32, or the low word from long long << 32
- */
-
-#define __get_unaligned_2(__p)					\
-	(__p[0] | __p[1] << 8)
-
-#define __get_unaligned_4(__p)					\
-	(__p[0] | __p[1] << 8 | __p[2] << 16 | __p[3] << 24)
-
-#define get_unaligned(ptr)					\
-({								\
-	unsigned int __v1, __v2;				\
-	__typeof__(*(ptr)) __v;					\
-	__u8 *__p = (__u8 *)(ptr);				\
-								\
-	switch (sizeof(*(ptr))) {				\
-	case 1:	__v = *(ptr);			break;		\
-	case 2: __v = __get_unaligned_2(__p);	break;		\
-	case 4: __v = __get_unaligned_4(__p);	break;		\
-	case 8:							\
-		__v2 = __get_unaligned_4((__p+4));		\
-		__v1 = __get_unaligned_4(__p);			\
-		__v = ((unsigned long long)__v2 << 32 | __v1);	\
-		break;						\
-	default: __v = __bug_unaligned_x(__p);	break;		\
-	}							\
-	__v;							\
-})
-
-
-static inline void __put_unaligned_2(__u32 __v, register __u8 *__p)
-{
-	*__p++ = __v;
-	*__p++ = __v >> 8;
-}
-
-static inline void __put_unaligned_4(__u32 __v, register __u8 *__p)
-{
-	__put_unaligned_2(__v >> 16, __p + 2);
-	__put_unaligned_2(__v, __p);
-}
-
-static inline void __put_unaligned_8(const unsigned long long __v, __u8 *__p)
-{
-	/*
-	 * tradeoff: 8 bytes of stack for all unaligned puts (2
-	 * instructions), or an extra register in the long long
-	 * case - go for the extra register.
-	 */
-	__put_unaligned_4(__v >> 32, __p + 4);
-	__put_unaligned_4(__v, __p);
-}
-
-/*
- * Try to store an unaligned value as efficiently as possible.
- */
-#define put_unaligned(val, ptr)						\
-	({								\
-		switch (sizeof(*(ptr))) {				\
-		case 1:							\
-			*(ptr) = (val);					\
-			break;						\
-		case 2:							\
-			__put_unaligned_2((val), (__u8 *)(ptr));	\
-			break;						\
-		case 4:							\
-			__put_unaligned_4((val), (__u8 *)(ptr));	\
-			break;						\
-		case 8:							\
-			__put_unaligned_8((val), (__u8 *)(ptr));	\
-			break;						\
-		default:						\
-			__bug_unaligned_x(ptr);				\
-			break;						\
-		}							\
-		(void) 0;						\
-	})
-
-
-#else
-
-#define get_unaligned(ptr) (*(ptr))
-#define put_unaligned(val, ptr) ({ *(ptr) = (val); (void) 0; })
-
-#endif
+#include <linux/unaligned/access_ok.h>
 
 #endif
diff --git a/include/asm-parisc/unaligned.h b/include/asm-parisc/unaligned.h
index 53c9058..865867c 100644
--- a/include/asm-parisc/unaligned.h
+++ b/include/asm-parisc/unaligned.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_PARISC_UNALIGNED_H_
 #define _ASM_PARISC_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #ifdef __KERNEL__
 struct pt_regs;
diff --git a/include/asm-powerpc/unaligned.h b/include/asm-powerpc/unaligned.h
index 6c95dfa..59bcc21 100644
--- a/include/asm-powerpc/unaligned.h
+++ b/include/asm-powerpc/unaligned.h
@@ -5,15 +5,8 @@
 
 /*
  * The PowerPC can do unaligned accesses itself in big endian mode.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_UNALIGNED_H */
diff --git a/include/asm-s390/unaligned.h b/include/asm-s390/unaligned.h
index 8ee86db..1d4a684 100644
--- a/include/asm-s390/unaligned.h
+++ b/include/asm-s390/unaligned.h
@@ -11,14 +11,7 @@
 
 /*
  * The S390 can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif
diff --git a/include/asm-sh/unaligned.h b/include/asm-sh/unaligned.h
index 5250e30..391da8d 100644
--- a/include/asm-sh/unaligned.h
+++ b/include/asm-sh/unaligned.h
@@ -2,6 +2,10 @@
 #define __ASM_SH_UNALIGNED_H
 
 /* SH can't handle unaligned accesses. */
-#include <asm-generic/unaligned.h>
+#ifdef __LITTLE_ENDIAN__
+#include <linux/unaligned/generic_le.h>
+#else
+#include <linux/unaligned/generic_be.h>
+#endif
 
 #endif /* __ASM_SH_UNALIGNED_H */
diff --git a/include/asm-sparc/unaligned.h b/include/asm-sparc/unaligned.h
index b6f8edd..9f1bb56 100644
--- a/include/asm-sparc/unaligned.h
+++ b/include/asm-sparc/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_SPARC_UNALIGNED_H_
 #define _ASM_SPARC_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #endif /* _ASM_SPARC_UNALIGNED_H */
diff --git a/include/asm-sparc64/unaligned.h b/include/asm-sparc64/unaligned.h
index 1ed3ba5..faa18cd 100644
--- a/include/asm-sparc64/unaligned.h
+++ b/include/asm-sparc64/unaligned.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_SPARC64_UNALIGNED_H_
 #define _ASM_SPARC64_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/generic_be.h>
 
 #endif /* _ASM_SPARC64_UNALIGNED_H */
diff --git a/include/asm-v850/unaligned.h b/include/asm-v850/unaligned.h
index e30b186..09fc37c 100644
--- a/include/asm-v850/unaligned.h
+++ b/include/asm-v850/unaligned.h
@@ -17,114 +17,9 @@
 #ifndef __V850_UNALIGNED_H__
 #define __V850_UNALIGNED_H__
 
-#include <asm/types.h>
-
-extern int __bug_unaligned_x(void *ptr);
-
-/*
- * What is the most efficient way of loading/storing an unaligned value?
- *
- * That is the subject of this file.  Efficiency here is defined as
- * minimum code size with minimum register usage for the common cases.
- * It is currently not believed that long longs are common, so we
- * trade efficiency for the chars, shorts and longs against the long
- * longs.
- *
- * Current stats with gcc 2.7.2.2 for these functions:
- *
- *	ptrsize	get:	code	regs	put:	code	regs
- *	1		1	1		1	2
- *	2		3	2		3	2
- *	4		7	3		7	3
- *	8		20	6		16	6
- *
- * gcc 2.95.1 seems to code differently:
- *
- *	ptrsize	get:	code	regs	put:	code	regs
- *	1		1	1		1	2
- *	2		3	2		3	2
- *	4		7	4		7	4
- *	8		19	8		15	6
- *
- * which may or may not be more efficient (depending upon whether
- * you can afford the extra registers).  Hopefully the gcc 2.95
- * is inteligent enough to decide if it is better to use the
- * extra register, but evidence so far seems to suggest otherwise.
- *
- * Unfortunately, gcc is not able to optimise the high word
- * out of long long >> 32, or the low word from long long << 32
- */
-
-#define __get_unaligned_2(__p)					\
-	(__p[0] | __p[1] << 8)
-
-#define __get_unaligned_4(__p)					\
-	(__p[0] | __p[1] << 8 | __p[2] << 16 | __p[3] << 24)
-
-#define get_unaligned(ptr)					\
-	({							\
-		__typeof__(*(ptr)) __v;				\
-		__u8 *__p = (__u8 *)(ptr);			\
-		switch (sizeof(*(ptr))) {			\
-		case 1:	__v = *(ptr);			break;	\
-		case 2: __v = __get_unaligned_2(__p);	break;	\
-		case 4: __v = __get_unaligned_4(__p);	break;	\
-		case 8: {					\
-				unsigned int __v1, __v2;	\
-				__v2 = __get_unaligned_4((__p+4)); \
-				__v1 = __get_unaligned_4(__p);	\
-				__v = ((unsigned long long)__v2 << 32 | __v1);	\
-			}					\
-			break;					\
-		default: __v = __bug_unaligned_x(__p);	break;	\
-		}						\
-		__v;						\
-	})
-
-
-static inline void __put_unaligned_2(__u32 __v, register __u8 *__p)
-{
-	*__p++ = __v;
-	*__p++ = __v >> 8;
-}
-
-static inline void __put_unaligned_4(__u32 __v, register __u8 *__p)
-{
-	__put_unaligned_2(__v >> 16, __p + 2);
-	__put_unaligned_2(__v, __p);
-}
-
-static inline void __put_unaligned_8(const unsigned long long __v, register __u8 *__p)
-{
-	/*
-	 * tradeoff: 8 bytes of stack for all unaligned puts (2
-	 * instructions), or an extra register in the long long
-	 * case - go for the extra register.
-	 */
-	__put_unaligned_4(__v >> 32, __p+4);
-	__put_unaligned_4(__v, __p);
-}
-
-/*
- * Try to store an unaligned value as efficiently as possible.
- */
-#define put_unaligned(val,ptr)					\
-	({							\
-		switch (sizeof(*(ptr))) {			\
-		case 1:						\
-			*(ptr) = (val);				\
-			break;					\
-		case 2: __put_unaligned_2((val),(__u8 *)(ptr));	\
-			break;					\
-		case 4:	__put_unaligned_4((val),(__u8 *)(ptr));	\
-			break;					\
-		case 8:	__put_unaligned_8((val),(__u8 *)(ptr)); \
-			break;					\
-		default: __bug_unaligned_x(ptr);		\
-			break;					\
-		}						\
-		(void) 0;					\
-	})
+#include <linux/unaligned/generic.h>
 
+#define get_unaligned	__get_unaligned_le
+#define put_unaligned	__put_unaligned_le
 
 #endif /* __V850_UNALIGNED_H__ */
diff --git a/include/asm-x86/unaligned.h b/include/asm-x86/unaligned.h
index 913598d..7ba2e1a 100644
--- a/include/asm-x86/unaligned.h
+++ b/include/asm-x86/unaligned.h
@@ -3,35 +3,7 @@
 
 /*
  * The x86 can do unaligned accesses itself.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-/**
- * get_unaligned - get value from possibly mis-aligned location
- * @ptr: pointer to value
- *
- * This macro should be used for accessing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. retrieving a u16 value from a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define get_unaligned(ptr) (*(ptr))
-
-/**
- * put_unaligned - put value to a possibly mis-aligned location
- * @val: value to place
- * @ptr: pointer to location
- *
- * This macro should be used for placing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. writing a u16 value to a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif /* _ASM_X86_UNALIGNED_H */
diff --git a/include/asm-xtensa/unaligned.h b/include/asm-xtensa/unaligned.h
index 2822089..45eb203 100644
--- a/include/asm-xtensa/unaligned.h
+++ b/include/asm-xtensa/unaligned.h
@@ -13,16 +13,6 @@
 #ifndef _XTENSA_UNALIGNED_H
 #define _XTENSA_UNALIGNED_H
 
-#include <linux/string.h>
-
-/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
+#include <linux/unaligned/no_builtin_memcpy.h>
 
 #endif	/* _XTENSA_UNALIGNED_H */
diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
index 8e7eff2..aa7c71c 100644
--- a/include/linux/reiserfs_fs.h
+++ b/include/linux/reiserfs_fs.h
@@ -526,7 +526,7 @@ struct item_head {
 ** p is the array of __u32, i is the index into the array, v is the value
 ** to store there.
 */
-#define get_block_num(p, i) le32_to_cpu(get_unaligned((p) + (i)))
+#define get_block_num(p, i) get_unaligned_le32((p) + (i))
 #define put_block_num(p, i, v) put_unaligned(cpu_to_le32(v), (p) + (i))
 
 //
diff --git a/include/linux/smb_fs.h b/include/linux/smb_fs.h
index 2c5cd55..2dd6789 100644
--- a/include/linux/smb_fs.h
+++ b/include/linux/smb_fs.h
@@ -43,12 +43,9 @@ static inline struct smb_inode_info *SMB_I(struct inode *inode)
 }
 
 /* macro names are short for word, double-word, long value (?) */
-#define WVAL(buf,pos) \
-	(le16_to_cpu(get_unaligned((__le16 *)((u8 *)(buf) + (pos)))))
-#define DVAL(buf,pos) \
-	(le32_to_cpu(get_unaligned((__le32 *)((u8 *)(buf) + (pos)))))
-#define LVAL(buf,pos) \
-	(le64_to_cpu(get_unaligned((__le64 *)((u8 *)(buf) + (pos)))))
+#define WVAL(buf,pos) (get_unaligned_le16((__le16 *)((u8 *)(buf) + (pos))))
+#define DVAL(buf,pos) (get_unaligned_le32((__le32 *)((u8 *)(buf) + (pos))))
+#define LVAL(buf,pos) (get_unaligned_le64((__le64 *)((u8 *)(buf) + (pos))))
 #define WSET(buf,pos,val) \
 	put_unaligned(cpu_to_le16((u16)(val)), (__le16 *)((u8 *)(buf) + (pos)))
 #define DSET(buf,pos,val) \
diff --git a/include/linux/unaligned/access_ok.h b/include/linux/unaligned/access_ok.h
new file mode 100644
index 0000000..e9d8ff4
--- /dev/null
+++ b/include/linux/unaligned/access_ok.h
@@ -0,0 +1,70 @@
+#ifndef _LINUX_UNALIGNED_ACCESS_OK_H_
+#define _LINUX_UNALIGNED_ACCESS_OK_H_
+
+#include <linux/kernel.h>
+#include <asm/byteorder.h>
+
+#define get_unaligned(ptr) (*(ptr))
+#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return le16_to_cpup(p);
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return le32_to_cpup(p);
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return le64_to_cpup(p);
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	return be16_to_cpup(p);
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return be32_to_cpup(p);
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return be64_to_cpup(p);
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	*((__le16 *)p) = cpu_to_le16(val);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	*((__le32 *)p) = cpu_to_le32(val);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	*((__le64 *)p) = cpu_to_le64(val);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	*((__be16 *)p) = cpu_to_be16(val);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	*((__be32 *)p) = cpu_to_be32(val);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	*((__be64 *)p) = cpu_to_be64(val);
+}
+
+#endif /* _LINUX_UNALIGNED_ACCESS_OK_H_ */
diff --git a/include/linux/unaligned/big_endian.h b/include/linux/unaligned/big_endian.h
new file mode 100644
index 0000000..b59fbbc
--- /dev/null
+++ b/include/linux/unaligned/big_endian.h
@@ -0,0 +1,82 @@
+#ifndef _LINUX_UNALIGNED_BIG_ENDIAN_H_
+#define _LINUX_UNALIGNED_BIG_ENDIAN_H_
+
+#include <linux/kernel.h>
+
+static inline u16 __get_unaligned_be16(const u8 *p)
+{
+	return (u16)(p[0] << 8 | p[1]);
+}
+
+static inline u32 __get_unaligned_be32(const u8 *p)
+{
+	return (u32)(p[0] << 24 | p[1] << 16 | p[2] << 8 | p[3]);
+}
+
+static inline u64 __get_unaligned_be64(const u8 *p)
+{
+	return ((u64)__get_unaligned_be32(p) << 32) |
+	       __get_unaligned_be32(p + 4);
+}
+
+#define __get_unaligned_be(ptr) ({					\
+	const void *__gu_p = (ptr);					\
+	u64 __val;							\
+	switch (sizeof(*(ptr)) {					\
+	case 1:								\
+		__val = *(const u8 *)__gu_p;				\
+		break;							\
+	case 2:								\
+		__val = __get_unaligned_be16((const u8 *)__gu_p);	\
+		break;							\
+	case 4:								\
+		__val = __get_unaligned_be32((const u8 *)__gu_p);	\
+		break;							\
+	case 8:								\
+		__val = __get_unaligned_be64((const u8 *)__gu_p);	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+	};								\
+	(__force __typeof__(*(ptr)))__val; })
+
+static inline void __put_unaligned_be16(u16 val, u8 *p)
+{
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
+static inline void __put_unaligned_be32(u32 val, u8 *p)
+{
+	__put_unaligned_be16(val >> 16, p);
+	__put_unaligned_be16(val, p + 2);
+}
+
+static inline void __put_unaligned_be64(u64 val, u8 *p)
+{
+	__put_unaligned_be32(val >> 32, p);
+	__put_unaligned_be32(val, p + 4);
+}
+
+#define __put_unaligned_be(val, ptr) ({					\
+	(void)sizeof(*(ptr) = (val));					\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		*(ptr) = (val);						\
+		break;							\
+	case 2:								\
+		__put_unaligned_be16((__force u16)(val), (u8 *)(ptr));	\
+		break;							\
+	case 4:								\
+		__put_unaligned_be32((__force u32)(val), (u8 *)(ptr));	\
+		break;							\
+	case 8:								\
+		__put_unaligned_be64((__force u64)(val), (u8 *)(ptr));	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+		break;							\
+	}								\
+	(void)0; })
+
+#endif /* _LINUX_UNALIGNED_BIG_ENDIAN_H_ */
diff --git a/include/linux/unaligned/cpu_endian.h b/include/linux/unaligned/cpu_endian.h
new file mode 100644
index 0000000..35fe430
--- /dev/null
+++ b/include/linux/unaligned/cpu_endian.h
@@ -0,0 +1,88 @@
+#ifndef _LINUX_UNALIGNED_CPU_ENDIAN_H_
+#define _LINUX_UNALIGNED_CPU_ENDIAN_H_
+
+#include <linux/kernel.h>
+
+struct __una_u16 { u16 x __attribute__((packed)); };
+struct __una_u32 { u32 x __attribute__((packed)); };
+struct __una_u64 { u64 x __attribute__((packed)); };
+
+static inline u16 __get_unaligned_cpu16(const u8 *p)
+{
+	const struct __una_u16 *ptr = (const struct __una_u16 *)p;
+	return ptr->x;
+}
+
+static inline u32 __get_unaligned_cpu32(const u8 *p)
+{
+	const struct __una_u32 *ptr = (const struct __una_u32 *)p;
+	return ptr->x;
+}
+
+static inline u64 __get_unaligned_cpu64(const u8 *p)
+{
+	const struct __una_u64 *ptr = (const struct __una_u64 *)p;
+	return ptr->x;
+}
+
+#define __get_unaligned_cpu(ptr) ({					\
+	const void *__gu_p = (ptr);					\
+	u64 __val;							\
+	switch (sizeof(*(ptr)) {					\
+	case 1:								\
+		__val = *(const u8 *)__gu_p;				\
+		break;							\
+	case 2:								\
+		__val = __get_unaligned_cpu16((const u8 *)__gu_p);	\
+		break;							\
+	case 4:								\
+		__val = __get_unaligned_cpu32((const u8 *)__gu_p);	\
+		break;							\
+	case 8:								\
+		__val = __get_unaligned_cpu64((const u8 *)__gu_p);	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+	};								\
+	(__force __typeof__(*(ptr)))__val; })
+
+static inline void __put_unaligned_cpu16(u16 val, u8 *p)
+{
+	struct __una_u16 *ptr = (struct __una_u16 *)p;
+	ptr->x = val;
+}
+
+static inline void __put_unaligned_cpu32(u32 val, u8 *p)
+{
+	struct __una_u32 *ptr = (struct __una_u32 *)p;
+	ptr->x = val;
+}
+
+static inline void __put_unaligned_cpu64(u64 val, u8 *p)
+{
+	struct __una_u64 *ptr = (struct __una_u64 *)p;
+	ptr->x = val;
+}
+
+#define __put_unaligned_cpu(val, ptr) ({				\
+	(void)sizeof(*(ptr) = (val));					\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		*(ptr) = (val);						\
+		break;							\
+	case 2:								\
+		__put_unaligned_cpu16((__force u16)(val), (u8 *)(ptr));	\
+		break;							\
+	case 4:								\
+		__put_unaligned_cpu32((__force u32)(val), (u8 *)(ptr));	\
+		break;							\
+	case 8:								\
+		__put_unaligned_cpu64((__force u64)(val), (u8 *)(ptr));	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+		break;							\
+	}								\
+	(void)0; })
+
+#endif /* _LINUX_UNALIGNED_CPU_ENDIAN_H_ */
diff --git a/include/linux/unaligned/generic.h b/include/linux/unaligned/generic.h
new file mode 100644
index 0000000..9cd3fab
--- /dev/null
+++ b/include/linux/unaligned/generic.h
@@ -0,0 +1,67 @@
+#ifndef _LINUX_UNALIGNED_GENERIC_H_
+#define _LINUX_UNALIGNED_GENERIC_H_
+
+#include <linux/unaligned/little_endian.h>
+#include <linux/unaligned/big_endian.h>
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return __get_unaligned_le16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return __get_unaligned_le32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return __get_unaligned_le64((const u8 *)p);
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	return __get_unaligned_be16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return __get_unaligned_be32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return __get_unaligned_be64((const u8 *)p);
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_le16(val, p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_le32(val, p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_le64(val, p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_be16(val, p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_be32(val, p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_be64(val, p);
+}
+
+#endif /* _LINUX_UNALIGNED_GENERIC_H_ */
diff --git a/include/linux/unaligned/generic_be.h b/include/linux/unaligned/generic_be.h
new file mode 100644
index 0000000..dd7e323
--- /dev/null
+++ b/include/linux/unaligned/generic_be.h
@@ -0,0 +1,70 @@
+#ifndef _LINUX_UNALIGNED_GENERIC_BE_H_
+#define _LINUX_UNALIGNED_GENERIC_BE_H_
+
+#include <linux/unaligned/cpu_endian.h>
+#include <linux/unaligned/little_endian.h>
+
+#define get_unaligned	__get_unaligned_cpu
+#define put_unaligned	__put_unaligned_cpu
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return __get_unaligned_le16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return __get_unaligned_le32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return __get_unaligned_le64((const u8 *)p);
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	return __get_unaligned_cpu16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return __get_unaligned_cpu32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return __get_unaligned_cpu64((const u8 *)p);
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_le16(val, p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_le32(val, p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_le64(val, p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_cpu16(val, p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_cpu32(val, p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_cpu64(val, p);
+}
+
+#endif /* _LINUX_UNALIGNED_GENERIC_BE_H_ */
diff --git a/include/linux/unaligned/generic_le.h b/include/linux/unaligned/generic_le.h
new file mode 100644
index 0000000..7b7de52
--- /dev/null
+++ b/include/linux/unaligned/generic_le.h
@@ -0,0 +1,70 @@
+#ifndef _LINUX_UNALIGNED_GENERIC_LE_H_
+#define _LINUX_UNALIGNED_GENERIC_LE_H_
+
+#include <linux/unaligned/cpu_endian.h>
+#include <linux/unaligned/big_endian.h>
+
+#define get_unaligned	__get_unaligned_cpu
+#define put_unaligned	__put_unaligned_cpu
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return __get_unaligned_cpu16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return __get_unaligned_cpu32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return __get_unaligned_cpu64((const u8 *)p);
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	return __get_unaligned_be16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return __get_unaligned_be32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return __get_unaligned_be64((const u8 *)p);
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_cpu16(val, p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_cpu32(val, p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_cpu64(val, p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_be16(val, p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_be32(val, p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_be64(val, p);
+}
+
+#endif /* _LINUX_UNALIGNED_GENERIC_LE_H_ */
diff --git a/include/linux/unaligned/little_endian.h b/include/linux/unaligned/little_endian.h
new file mode 100644
index 0000000..43f46c3
--- /dev/null
+++ b/include/linux/unaligned/little_endian.h
@@ -0,0 +1,82 @@
+#ifndef _LINUX_UNALIGNED_LITTLE_ENDIAN_H_
+#define _LINUX_UNALIGNED_LITTLE_ENDIAN_H_
+
+#include <linux/kernel.h>
+
+static inline u16 __get_unaligned_le16(const u8 *p)
+{
+	return (u16)(p[0] | p[1] << 8);
+}
+
+static inline u32 __get_unaligned_le32(const u8 *p)
+{
+	return (u32)(p[0] | p[1] << 8 | p[2] << 16 | p[3] << 24);
+}
+
+static inline u64 __get_unaligned_le64(const u8 *p)
+{
+	return ((u64)__get_unaligned_le32(p + 4) << 32) |
+	       __get_unaligned_le32(p);
+}
+
+#define __get_unaligned_le(ptr) ({					\
+	const void *__gu_p = (ptr);					\
+	u64 __val;							\
+	switch (sizeof(*(ptr)) {					\
+	case 1:								\
+		__val = *(const u8 *)__gu_p;				\
+		break;							\
+	case 2:								\
+		__val = __get_unaligned_le16((const u8 *)__gu_p);	\
+		break;							\
+	case 4:								\
+		__val = __get_unaligned_le32((const u8 *)__gu_p);	\
+		break;							\
+	case 8:								\
+		__val = __get_unaligned_le64((const u8 *)__gu_p);	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+	};								\
+	(__force __typeof__(*(ptr)))__val; })
+
+static inline void __put_unaligned_le16(u16 val, u8 *p)
+{
+	*p++ = val;
+	*p++ = val >> 8;
+}
+
+static inline void __put_unaligned_le32(u32 val, u8 *p)
+{
+	__put_unaligned_le16(val >> 16, p + 2);
+	__put_unaligned_le16(val, p);
+}
+
+static inline void __put_unaligned_le64(u64 val, u8 *p)
+{
+	__put_unaligned_le32(val >> 32, p + 4);
+	__put_unaligned_le32(val, p);
+}
+
+#define __put_unaligned_le(val, ptr) ({					\
+	(void)sizeof(*(ptr) = (val));					\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		*(ptr) = (val);						\
+		break;							\
+	case 2:								\
+		__put_unaligned_le16((__force u16)(val), (u8 *)(ptr));	\
+		break;							\
+	case 4:								\
+		__put_unaligned_le32((__force u32)(val), (u8 *)(ptr));	\
+		break;							\
+	case 8:								\
+		__put_unaligned_le64((__force u64)(val), (u8 *)(ptr));	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+		break;							\
+	}								\
+	(void)0; })
+
+#endif /* _LINUX_UNALIGNED_LITTLE_ENDIAN_H_ */
diff --git a/include/linux/unaligned/no_builtin_memcpy.h b/include/linux/unaligned/no_builtin_memcpy.h
new file mode 100644
index 0000000..c117e78
--- /dev/null
+++ b/include/linux/unaligned/no_builtin_memcpy.h
@@ -0,0 +1,80 @@
+#ifndef _LINUX_UNALIGNED_NO_BUILTIN_MEMCPY_H_
+#define _LINUX_UNALIGNED_NO_BUILTIN_MEMCPY_H_
+
+#include <linux/kernel.h>
+#include <asm/byteorder.h>
+#include <asm/string.h>
+
+/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
+
+#define get_unaligned(ptr) ({				\
+	__typeof__(*(ptr)) __tmp;			\
+	memmove(&__tmp, (ptr), sizeof(*(ptr)));		\
+	__tmp; })
+
+#define put_unaligned(val, ptr) ({			\
+	__typeof__(*(ptr)) __tmp = (val);		\
+	memmove((ptr), &__tmp, sizeof(*(ptr)));		\
+	(void)0; })
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return le16_to_cpu(get_unaligned(p));
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return le32_to_cpu(get_unaligned(p));
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return le64_to_cpu(get_unaligned(p));
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	return be16_to_cpu(get_unaligned(p));
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return be32_to_cpu(get_unaligned(p));
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return be64_to_cpu(get_unaligned(p));
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	return put_unaligned(cpu_to_le16(val), (__le16 *)p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	return put_unaligned(cpu_to_le32(val), (__le32 *)p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	return put_unaligned(cpu_to_le64(val), (__le64 *)p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	return put_unaligned(cpu_to_be16(val), (__be16 *)p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	return put_unaligned(cpu_to_be32(val), (__be32 *)p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	return put_unaligned(cpu_to_be64(val), (__be64 *)p);
+}
+
+#endif
diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index dfd8bf6..d364fd5 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -262,7 +262,7 @@ static inline int ieee80211_get_radiotap_len(unsigned char *data)
 	struct ieee80211_radiotap_header *hdr =
 		(struct ieee80211_radiotap_header *)data;
 
-	return le16_to_cpu(get_unaligned(&hdr->it_len));
+	return get_unaligned_le16(&hdr->it_len);
 }
 
 #endif				/* IEEE80211_RADIOTAP_H */
diff --git a/lib/lzo/lzo1x_decompress.c b/lib/lzo/lzo1x_decompress.c
index 9dc7056..122cd80 100644
--- a/lib/lzo/lzo1x_decompress.c
+++ b/lib/lzo/lzo1x_decompress.c
@@ -138,8 +138,7 @@ match:
 					t += 31 + *ip++;
 				}
 				m_pos = op - 1;
-				m_pos -= le16_to_cpu(get_unaligned(
-					(const unsigned short *)ip)) >> 2;
+				m_pos -= get_unaligned_le16((__le16 *)ip) >> 2;
 				ip += 2;
 			} else if (t >= 16) {
 				m_pos = op;
@@ -157,8 +156,7 @@ match:
 					}
 					t += 7 + *ip++;
 				}
-				m_pos -= le16_to_cpu(get_unaligned(
-					(const unsigned short *)ip) >> 2);
+				m_pos -= get_unaligned_le16((__le16 *)ip) >> 2;
 				ip += 2;
 				if (m_pos == op)
 					goto eof_found;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 46df2e4..719245f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -313,7 +313,7 @@ static void hci_cc_write_voice_setting(struct hci_dev *hdev, struct sk_buff *skb
 		return;
 
 	if (!status) {
-		__u16 setting = __le16_to_cpu(get_unaligned((__le16 *) sent));
+		__u16 setting = get_unaligned_le16((__le16 *)sent);
 
 		if (hdev->voice_setting != setting) {
 			hdev->voice_setting = setting;
@@ -1152,8 +1152,8 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 		struct hci_conn *conn;
 		__u16  handle, count;
 
-		handle = __le16_to_cpu(get_unaligned(ptr++));
-		count  = __le16_to_cpu(get_unaligned(ptr++));
+		handle = get_unaligned_le16(ptr++);
+		count  = get_unaligned_le16(ptr++);
 
 		conn = hci_conn_hash_lookup_handle(hdev, handle);
 		if (conn) {
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1d36c09..4b0db31 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -440,7 +440,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	skb->dev = (void *) hdev;
 
 	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
-		u16 opcode = __le16_to_cpu(get_unaligned((__le16 *) skb->data));
+		u16 opcode = get_unaligned_le16((__le16 *)skb->data);
 		u16 ogf = hci_opcode_ogf(opcode);
 		u16 ocf = hci_opcode_ocf(opcode);
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2957df4..b8cb739 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1827,7 +1827,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 	del_timer(&conn->info_timer);
 
 	if (type == L2CAP_IT_FEAT_MASK)
-		conn->feat_mask = __le32_to_cpu(get_unaligned((__le32 *) rsp->data));
+		conn->feat_mask = get_unaligned_le32((__le32 *)rsp->data);
 
 	l2cap_conn_start(conn);
 
diff --git a/net/irda/iriap.c b/net/irda/iriap.c
index 390a790..6a81174 100644
--- a/net/irda/iriap.c
+++ b/net/irda/iriap.c
@@ -451,12 +451,12 @@ static void iriap_getvaluebyclass_confirm(struct iriap_cb *self,
 	n = 2;
 
 	/* Get length, MSB first */
-	len = be16_to_cpu(get_unaligned((__be16 *)(fp+n))); n += 2;
+	len = get_unaligned_be16((__be16 *)(fp + n)); n += 2;
 
 	IRDA_DEBUG(4, "%s(), len=%d\n", __FUNCTION__, len);
 
 	/* Get object ID, MSB first */
-	obj_id = be16_to_cpu(get_unaligned((__be16 *)(fp+n))); n += 2;
+	obj_id = get_unaligned_be16((__be16 *)(fp + n)); n += 2;
 
 	type = fp[n++];
 	IRDA_DEBUG(4, "%s(), Value type = %d\n", __FUNCTION__, type);
@@ -506,7 +506,7 @@ static void iriap_getvaluebyclass_confirm(struct iriap_cb *self,
 		value = irias_new_string_value(fp+n);
 		break;
 	case IAS_OCT_SEQ:
-		value_len = be16_to_cpu(get_unaligned((__be16 *)(fp+n)));
+		value_len = get_unaligned_be16((__be16 *)(fp + n));
 		n += 2;
 
 		/* Will truncate to IAS_MAX_OCTET_STRING bytes */
diff --git a/net/wireless/radiotap.c b/net/wireless/radiotap.c
index 28fbd0b..a9371c2 100644
--- a/net/wireless/radiotap.c
+++ b/net/wireless/radiotap.c
@@ -63,18 +63,16 @@ int ieee80211_radiotap_iterator_init(
 		return -EINVAL;
 
 	iterator->rtheader = radiotap_header;
-	iterator->max_length = le16_to_cpu(get_unaligned(
-						&radiotap_header->it_len));
+	iterator->max_length = get_unaligned_le16(&radiotap_header->it_len);
 	iterator->arg_index = 0;
-	iterator->bitmap_shifter = le32_to_cpu(get_unaligned(
-						&radiotap_header->it_present));
+	iterator->bitmap_shifter = get_unaligned_le32(&radiotap_header->it_present);
 	iterator->arg = (u8 *)radiotap_header + sizeof(*radiotap_header);
 	iterator->this_arg = NULL;
 
 	/* find payload start allowing for extended bitmap(s) */
 
 	if (unlikely(iterator->bitmap_shifter & (1<<IEEE80211_RADIOTAP_EXT))) {
-		while (le32_to_cpu(get_unaligned((__le32 *)iterator->arg)) &
+		while (get_unaligned_le32((__le32 *)iterator->arg) &
 				   (1<<IEEE80211_RADIOTAP_EXT)) {
 			iterator->arg += sizeof(u32);
 
-- 
1.5.5.144.g3e42
