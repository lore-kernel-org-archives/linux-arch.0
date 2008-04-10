From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 8/8] kernel: use new unaligned helpers in code
Date: Thu, 10 Apr 2008 12:44:10 -0700
Message-ID: <1207856650.22001.33.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

get_unaligned_{le16|le32|le64|be16|be32|be64}(p) which is meant to replace
code of the form:
le16_to_cpu(get_unaligned((__le16 *)p));

put_unaligned_{le16|le32|le64|be16|be32|be64}(val, pointer) which is meant to
replace code of the form:
put_unaligned(cpu_to_le16(val), (__le16 *)p);

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/block/aoe/aoecmd.c              |   26 ++++++++++----------
 drivers/block/aoe/aoenet.c              |    4 +-
 drivers/char/rocket_int.h               |    2 +-
 drivers/hid/hid-core.c                  |    6 ++--
 drivers/ide/ide-cd.c                    |    2 +-
 drivers/ide/ide-floppy.c                |   12 ++++----
 drivers/ide/ide-tape.c                  |   14 +++++-----
 drivers/input/tablet/aiptek.c           |   16 ++++++------
 drivers/input/tablet/gtco.c             |   14 +++++-----
 drivers/input/tablet/kbtab.c            |    4 +-
 drivers/media/radio/radio-si470x.c      |   16 ++++-------
 drivers/mmc/host/mmc_spi.c              |    2 +-
 drivers/net/e100.c                      |    2 +-
 drivers/net/hamachi.c                   |    2 +-
 drivers/net/irda/mcs7780.c              |    2 +-
 drivers/net/irda/stir4200.c             |    2 +-
 drivers/net/tulip/de4x5.c               |    2 +-
 drivers/net/tulip/de4x5.h               |    2 +-
 drivers/net/tulip/tulip_core.c          |   10 ++++----
 drivers/net/wireless/airo.c             |    2 +-
 drivers/net/wireless/ath5k/base.c       |    4 +-
 drivers/net/wireless/b43/main.c         |    2 +-
 drivers/net/wireless/b43legacy/main.c   |    2 +-
 drivers/net/wireless/iwlwifi/iwl-3945.c |   26 ++++++++-----------
 drivers/net/wireless/iwlwifi/iwl-4965.c |   36 ++++++++++++---------------
 drivers/net/wireless/libertas/scan.c    |    2 +-
 drivers/net/wireless/zd1211rw/zd_usb.c  |    2 +-
 drivers/net/yellowfin.c                 |    2 +-
 drivers/pcmcia/cistpl.c                 |    4 +-
 drivers/scsi/libiscsi.c                 |    2 +-
 drivers/usb/atm/ueagle-atm.c            |   14 +++++-----
 drivers/usb/class/cdc-acm.c             |    2 +-
 drivers/usb/gadget/goku_udc.c           |    2 +-
 drivers/usb/gadget/rndis.c              |   40 +++++++++++-------------------
 drivers/usb/gadget/usbstring.c          |    2 +-
 drivers/usb/host/ehci-hub.c             |    2 +-
 drivers/usb/host/ohci-hub.c             |    4 +-
 drivers/video/matrox/matroxfb_misc.c    |    4 +-
 drivers/video/metronomefb.c             |    6 ++--
 fs/fat/inode.c                          |    8 ++----
 fs/hfsplus/wrapper.c                    |    2 +-
 fs/isofs/isofs.h                        |   12 ++++----
 fs/ncpfs/ncplib_kernel.c                |   16 ++++++------
 fs/partitions/ldm.h                     |    6 ++--
 fs/xfs/xfs_inode.c                      |    8 +++---
 include/linux/reiserfs_fs.h             |    4 +-
 include/linux/smb_fs.h                  |   18 ++++---------
 include/net/ieee80211_radiotap.h        |    2 +-
 lib/lzo/lzo1x_decompress.c              |    6 +---
 net/bluetooth/hci_event.c               |    6 ++--
 net/bluetooth/hci_sock.c                |    2 +-
 net/bluetooth/l2cap.c                   |    4 +-
 net/irda/iriap.c                        |    6 ++--
 net/irda/irttp.c                        |    6 +---
 net/wireless/radiotap.c                 |    8 ++----
 55 files changed, 189 insertions(+), 225 deletions(-)

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
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index c8d0e87..43ab45f 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -881,7 +881,7 @@ static ide_startstop_t cdrom_start_seek_continuation (ide_drive_t *drive)
 
 	memset(rq->cmd, 0, sizeof(rq->cmd));
 	rq->cmd[0] = GPCMD_SEEK;
-	put_unaligned(cpu_to_be32(frame), (unsigned int *) &rq->cmd[2]);
+	put_unaligned_be32(frame, &rq->cmd[2]);
 
 	rq->timeout = ATAPI_WAIT_PC;
 	return cdrom_transfer_packet_command(drive, rq, &cdrom_seek_intr);
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index faf22d7..ec922e7 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1,4 +1,4 @@
-/*
+put/*
  * IDE ATAPI floppy driver.
  *
  * Copyright (C) 1996-1999  Gadi Oxman <gadio-KndQ6Ac43bDc3gOQVGmKjw@public.gmane.org>
@@ -813,8 +813,8 @@ static void idefloppy_create_format_unit_cmd(idefloppy_pc_t *pc, int b, int l,
 		pc->buffer[1] ^= 0x20;		/* ... turn off DCRT bit */
 	pc->buffer[3] = 8;
 
-	put_unaligned(cpu_to_be32(b), (unsigned int *)(&pc->buffer[4]));
-	put_unaligned(cpu_to_be32(l), (unsigned int *)(&pc->buffer[8]));
+	put_unaligned_be32(b, &pc->buffer[4]);
+	put_unaligned_be32(l, &pc->buffer[8]);
 	pc->buffer_size = 12;
 	pc->flags |= PC_FLAG_WRITING;
 }
@@ -841,7 +841,7 @@ static void idefloppy_create_mode_sense_cmd(idefloppy_pc_t *pc, u8 page_code,
 		printk(KERN_ERR "ide-floppy: unsupported page code "
 				"in create_mode_sense_cmd\n");
 	}
-	put_unaligned(cpu_to_be16(length), (u16 *) &pc->c[7]);
+	put_unaligned_be16(length, &pc->c[7]);
 	pc->request_transfer = length;
 }
 
@@ -871,8 +871,8 @@ static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy,
 
 	idefloppy_init_pc(pc);
 	pc->c[0] = cmd == READ ? GPCMD_READ_10 : GPCMD_WRITE_10;
-	put_unaligned(cpu_to_be16(blocks), (unsigned short *)&pc->c[7]);
-	put_unaligned(cpu_to_be32(block), (unsigned int *) &pc->c[2]);
+	put_unaligned_be16(blocks, &pc->c[7]);
+	put_unaligned_be32(block, &pc->c[2]);
 
 	pc->callback = &idefloppy_rw_callback;
 	pc->rq = rq;
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 0598ecf..10e918e 100644
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
 
@@ -1507,7 +1507,7 @@ static void idetape_create_read_cmd(idetape_tape_t *tape, idetape_pc_t *pc,
 {
 	idetape_init_pc(pc);
 	pc->c[0] = READ_6;
-	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
+	put_unaligned_be32(length, &pc->c[1]);
 	pc->c[1] = 1;
 	pc->callback = &idetape_rw_callback;
 	pc->bh = bh;
@@ -1524,7 +1524,7 @@ static void idetape_create_write_cmd(idetape_tape_t *tape, idetape_pc_t *pc,
 {
 	idetape_init_pc(pc);
 	pc->c[0] = WRITE_6;
-	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
+	put_unaligned_be32(length, &pc->c[1]);
 	pc->c[1] = 1;
 	pc->callback = &idetape_rw_callback;
 	set_bit(PC_WRITING, &pc->flags);
@@ -2045,7 +2045,7 @@ static void idetape_create_locate_cmd(ide_drive_t *drive, idetape_pc_t *pc,
 	idetape_init_pc(pc);
 	pc->c[0] = POSITION_TO_ELEMENT;
 	pc->c[1] = 2;
-	put_unaligned(cpu_to_be32(block), (unsigned int *) &pc->c[3]);
+	put_unaligned_be32(block, &pc->c[3]);
 	pc->c[8] = partition;
 	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
 	pc->callback = &idetape_pc_callback;
@@ -2237,7 +2237,7 @@ static void idetape_create_space_cmd(idetape_pc_t *pc, int count, u8 cmd)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = SPACE;
-	put_unaligned(cpu_to_be32(count), (unsigned int *) &pc->c[1]);
+	put_unaligned_be32(count, &pc->c[1]);
 	pc->c[1] = cmd;
 	set_bit(PC_WAIT_FOR_DSC, &pc->flags);
 	pc->callback = &idetape_pc_callback;
@@ -3399,9 +3399,9 @@ static void idetape_get_mode_sense_results(ide_drive_t *drive)
 	max_speed = be16_to_cpu(*(u16 *)&caps[8]);
 
 	put_unaligned(max_speed, (u16 *)&caps[8]);
-	put_unaligned(be16_to_cpu(*(u16 *)&caps[12]), (u16 *)&caps[12]);
+	put_unaligned_be16(*(u16 *)&caps[12], &caps[12]);
 	put_unaligned(speed, (u16 *)&caps[14]);
-	put_unaligned(be16_to_cpu(*(u16 *)&caps[16]), (u16 *)&caps[16]);
+	put_unaligned_be16(*(u16 *)&caps[16], &caps[16]);
 
 	if (!speed) {
 		printk(KERN_INFO "ide-tape: %s: invalid tape speed "
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
index 649f14d..20ab087 100644
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
@@ -529,8 +528,7 @@ static int si470x_set_register(struct si470x_device *radio, int regnr)
 	int retval;
 
 	buf[0] = REGISTER_REPORT(regnr);
-	put_unaligned(cpu_to_be16(radio->registers[regnr]),
-		(unsigned short *) &buf[1]);
+	put_unaligned_be16(radio->registers[regnr], &buf[1]);
 
 	retval = si470x_set_report(radio, (void *) &buf, sizeof(buf));
 
@@ -553,9 +551,8 @@ static int si470x_get_all_registers(struct si470x_device *radio)
 
 	if (retval >= 0)
 		for (regnr = 0; regnr < RADIO_REGISTER_NUM; regnr++)
-			radio->registers[regnr] = be16_to_cpu(get_unaligned(
-				(unsigned short *)
-				&buf[regnr * RADIO_REGISTER_SIZE + 1]));
+			radio->registers[regnr] =
+				get_unaligned_be16((__be16 *)&buf[regnr * RADIO_REGISTER_SIZE + 1]);
 
 	return (retval < 0) ? -EINVAL : 0;
 }
@@ -586,8 +583,7 @@ static int si470x_get_rds_registers(struct si470x_device *radio)
 	if (retval >= 0)
 		for (regnr = 0; regnr < RDS_REGISTER_NUM; regnr++)
 			radio->registers[STATUSRSSI + regnr] =
-				be16_to_cpu(get_unaligned((unsigned short *)
-				&buf[regnr * RADIO_REGISTER_SIZE + 1]));
+				get_unaligned_be16((__be16 *)&buf[regnr * RADIO_REGISTER_SIZE + 1]);
 
 	return (retval < 0) ? -EINVAL : 0;
 }
@@ -835,7 +831,7 @@ static void si470x_rds(struct si470x_device *radio)
 		};
 
 		/* Fill the V4L2 RDS buffer */
-		put_unaligned(cpu_to_le16(rds), (unsigned short *) &tmpbuf);
+		put_unaligned_le16(rds, &tmpbuf);
 		tmpbuf[2] = blocknum;		/* offset name */
 		tmpbuf[2] |= blocknum << 3;	/* received offset */
 		if (bler > max_rds_errors)
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
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index 2d139ec..f3cba5e 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -1802,7 +1802,7 @@ static int e100_rx_alloc_skb(struct nic *nic, struct rx *rx)
 	 * it is protected by the before last buffer's el bit being set */
 	if (rx->prev->skb) {
 		struct rfd *prev_rfd = (struct rfd *)rx->prev->skb->data;
-		put_unaligned(cpu_to_le32(rx->dma_addr), &prev_rfd->link);
+		put_unaligned_le32(rx->dma_addr, &prev_rfd->link);
 	}
 
 	return 0;
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
index 82f404b..652f6e6 100644
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
@@ -1446,13 +1446,13 @@ static int __devinit tulip_init_one (struct pci_dev *pdev,
 			do
 				value = ioread32(ioaddr + CSR9);
 			while (value < 0  && --boguscnt > 0);
-			put_unaligned(cpu_to_le16(value), ((__le16*)dev->dev_addr) + i);
+			put_unaligned_le16(value, ((__le16*)dev->dev_addr) + i);
 			sum += value & 0xffff;
 		}
 	} else if (chip_idx == COMET) {
 		/* No need to read the EEPROM. */
-		put_unaligned(cpu_to_le32(ioread32(ioaddr + 0xA4)), (__le32 *)dev->dev_addr);
-		put_unaligned(cpu_to_le16(ioread32(ioaddr + 0xA8)), (__le16 *)(dev->dev_addr + 4));
+		put_unaligned_le32(ioread32(ioaddr + 0xA4), dev->dev_addr);
+		put_unaligned_le16(ioread32(ioaddr + 0xA8), dev->dev_addr + 4);
 		for (i = 0; i < 6; i ++)
 			sum += dev->dev_addr[i];
 	} else {
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
diff --git a/drivers/net/wireless/iwlwifi/iwl-3945.c b/drivers/net/wireless/iwlwifi/iwl-3945.c
index 8d4d91d..69e434e 100644
--- a/drivers/net/wireless/iwlwifi/iwl-3945.c
+++ b/drivers/net/wireless/iwlwifi/iwl-3945.c
@@ -279,41 +279,37 @@ static void iwl3945_add_radiotap(struct iwl3945_priv *priv,
 	iwl3945_rt->rt_hdr.it_pad = 0;
 
 	/* total header + data */
-	put_unaligned(cpu_to_le16(sizeof(*iwl3945_rt)),
-		      &iwl3945_rt->rt_hdr.it_len);
+	put_unaligned_le16(sizeof(*iwl3945_rt), &iwl3945_rt->rt_hdr.it_len);
 
 	/* Indicate all the fields we add to the radiotap header */
-	put_unaligned(cpu_to_le32((1 << IEEE80211_RADIOTAP_TSFT) |
+	put_unaligned_le32((1 << IEEE80211_RADIOTAP_TSFT) |
 				  (1 << IEEE80211_RADIOTAP_FLAGS) |
 				  (1 << IEEE80211_RADIOTAP_RATE) |
 				  (1 << IEEE80211_RADIOTAP_CHANNEL) |
 				  (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL) |
 				  (1 << IEEE80211_RADIOTAP_DBM_ANTNOISE) |
-				  (1 << IEEE80211_RADIOTAP_ANTENNA)),
+				  (1 << IEEE80211_RADIOTAP_ANTENNA),
 		      &iwl3945_rt->rt_hdr.it_present);
 
 	/* Zero the flags, we'll add to them as we go */
 	iwl3945_rt->rt_flags = 0;
 
-	put_unaligned(cpu_to_le64(tsf), &iwl3945_rt->rt_tsf);
+	put_unaligned_le64(tsf, &iwl3945_rt->rt_tsf);
 
 	iwl3945_rt->rt_dbmsignal = signal;
 	iwl3945_rt->rt_dbmnoise = noise;
 
 	/* Convert the channel frequency and set the flags */
-	put_unaligned(cpu_to_le16(stats->freq), &iwl3945_rt->rt_channelMHz);
+	put_unaligned_le16(stats->freq, &iwl3945_rt->rt_channelMHz);
 	if (!(phy_flags_hw & RX_RES_PHY_FLAGS_BAND_24_MSK))
-		put_unaligned(cpu_to_le16(IEEE80211_CHAN_OFDM |
-					  IEEE80211_CHAN_5GHZ),
-			      &iwl3945_rt->rt_chbitmask);
+		put_unaligned_le16(IEEE80211_CHAN_OFDM | IEEE80211_CHAN_5GHZ,
+				   &iwl3945_rt->rt_chbitmask);
 	else if (phy_flags_hw & RX_RES_PHY_FLAGS_MOD_CCK_MSK)
-		put_unaligned(cpu_to_le16(IEEE80211_CHAN_CCK |
-					  IEEE80211_CHAN_2GHZ),
-			      &iwl3945_rt->rt_chbitmask);
+		put_unaligned_le16(IEEE80211_CHAN_CCK | IEEE80211_CHAN_2GHZ,
+				   &iwl3945_rt->rt_chbitmask);
 	else	/* 802.11g */
-		put_unaligned(cpu_to_le16(IEEE80211_CHAN_OFDM |
-					  IEEE80211_CHAN_2GHZ),
-			      &iwl3945_rt->rt_chbitmask);
+		put_unaligned_le16(IEEE80211_CHAN_OFDM | IEEE80211_CHAN_2GHZ,
+				   &iwl3945_rt->rt_chbitmask);
 
 	rate = iwl3945_rate_index_from_plcp(rate);
 	if (rate == -1)
diff --git a/drivers/net/wireless/iwlwifi/iwl-4965.c b/drivers/net/wireless/iwlwifi/iwl-4965.c
index 6576757..18d2dc6 100644
--- a/drivers/net/wireless/iwlwifi/iwl-4965.c
+++ b/drivers/net/wireless/iwlwifi/iwl-4965.c
@@ -3558,41 +3558,37 @@ static void iwl4965_add_radiotap(struct iwl4965_priv *priv,
 	iwl4965_rt->rt_hdr.it_pad = 0;
 
 	/* total header + data */
-	put_unaligned(cpu_to_le16(sizeof(*iwl4965_rt)),
-		      &iwl4965_rt->rt_hdr.it_len);
+	put_unaligned_le16(sizeof(*iwl4965_rt), &iwl4965_rt->rt_hdr.it_len);
 
 	/* Indicate all the fields we add to the radiotap header */
-	put_unaligned(cpu_to_le32((1 << IEEE80211_RADIOTAP_TSFT) |
-				  (1 << IEEE80211_RADIOTAP_FLAGS) |
-				  (1 << IEEE80211_RADIOTAP_RATE) |
-				  (1 << IEEE80211_RADIOTAP_CHANNEL) |
-				  (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL) |
-				  (1 << IEEE80211_RADIOTAP_DBM_ANTNOISE) |
-				  (1 << IEEE80211_RADIOTAP_ANTENNA)),
+	put_unaligned_le32((1 << IEEE80211_RADIOTAP_TSFT) |
+			   (1 << IEEE80211_RADIOTAP_FLAGS) |
+			   (1 << IEEE80211_RADIOTAP_RATE) |
+			   (1 << IEEE80211_RADIOTAP_CHANNEL) |
+			   (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL) |
+			   (1 << IEEE80211_RADIOTAP_DBM_ANTNOISE) |
+			   (1 << IEEE80211_RADIOTAP_ANTENNA),
 		      &iwl4965_rt->rt_hdr.it_present);
 
 	/* Zero the flags, we'll add to them as we go */
 	iwl4965_rt->rt_flags = 0;
 
-	put_unaligned(cpu_to_le64(tsf), &iwl4965_rt->rt_tsf);
+	put_unaligned_le64(tsf, &iwl4965_rt->rt_tsf);
 
 	iwl4965_rt->rt_dbmsignal = signal;
 	iwl4965_rt->rt_dbmnoise = noise;
 
 	/* Convert the channel frequency and set the flags */
-	put_unaligned(cpu_to_le16(stats->freq), &iwl4965_rt->rt_channelMHz);
+	put_unaligned_le16(stats->freq, &iwl4965_rt->rt_channelMHz);
 	if (!(phy_flags_hw & RX_RES_PHY_FLAGS_BAND_24_MSK))
-		put_unaligned(cpu_to_le16(IEEE80211_CHAN_OFDM |
-					  IEEE80211_CHAN_5GHZ),
-			      &iwl4965_rt->rt_chbitmask);
+		put_unaligned_le16(IEEE80211_CHAN_OFDM | IEEE80211_CHAN_5GHZ,
+				   &iwl4965_rt->rt_chbitmask);
 	else if (phy_flags_hw & RX_RES_PHY_FLAGS_MOD_CCK_MSK)
-		put_unaligned(cpu_to_le16(IEEE80211_CHAN_CCK |
-					  IEEE80211_CHAN_2GHZ),
-			      &iwl4965_rt->rt_chbitmask);
+		put_unaligned_le16(IEEE80211_CHAN_CCK | IEEE80211_CHAN_2GHZ,
+				   &iwl4965_rt->rt_chbitmask);
 	else	/* 802.11g */
-		put_unaligned(cpu_to_le16(IEEE80211_CHAN_OFDM |
-					  IEEE80211_CHAN_2GHZ),
-			      &iwl4965_rt->rt_chbitmask);
+		put_unaligned_le16(IEEE80211_CHAN_OFDM | IEEE80211_CHAN_2GHZ,
+				   &iwl4965_rt->rt_chbitmask);
 
 	rate = iwl4965_rate_index_from_plcp(rate);
 	if (rate == -1)
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
index c5ec1a5..c65f6ba 100644
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
@@ -1152,9 +1152,9 @@ static int uea_cmv_e1(struct uea_softc *sc,
 	cmv.bDirection = E1_HOSTTOMODEM;
 	cmv.bFunction = function;
 	cmv.wIndex = cpu_to_le16(sc->cmv_dsc.e1.idx);
-	put_unaligned(cpu_to_le32(address), &cmv.dwSymbolicAddress);
+	put_unaligned_le32(address, &cmv.dwSymbolicAddress);
 	cmv.wOffsetAddress = cpu_to_le16(offset);
-	put_unaligned(cpu_to_le32(data >> 16 | data << 16), &cmv.dwData);
+	put_unaligned_le32(data >> 16 | data << 16, &cmv.dwData);
 
 	ret = uea_request(sc, UEA_E1_SET_BLOCK, UEA_MPTX_START, sizeof(cmv), &cmv);
 	if (ret < 0)
@@ -1964,7 +1964,7 @@ static void uea_dispatch_cmv_e1(struct uea_softc *sc, struct intr_pkt *intr)
 		if (UEA_CHIP_VERSION(sc) == ADI930
 				&& cmv->bFunction ==  E1_MAKEFUNCTION(2, 2)) {
 			cmv->wIndex = cpu_to_le16(dsc->idx);
-			put_unaligned(cpu_to_le32(dsc->address), &cmv->dwSymbolicAddress);
+			put_unaligned_le32(dsc->address, &cmv->dwSymbolicAddress);
 			cmv->wOffsetAddress = cpu_to_le16(dsc->offset);
 		} else
 			goto bad2;
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
diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
index 878e428..4154be3 100644
--- a/drivers/usb/gadget/usbstring.c
+++ b/drivers/usb/gadget/usbstring.c
@@ -74,7 +74,7 @@ static int utf8_to_utf16le(const char *s, __le16 *cp, unsigned len)
 				goto fail;
 		} else
 			uchar = c;
-		put_unaligned (cpu_to_le16 (uchar), cp++);
+		put_unaligned_le16(uchar, cp++);
 		count++;
 		len--;
 	}
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index 4e065e5..85f7c6e 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -782,7 +782,7 @@ static int ehci_hub_control (
 	if (status & ~0xffff)	/* only if wPortChange is interesting */
 #endif
 		dbg_port (ehci, "GetStatus", wIndex + 1, temp);
-		put_unaligned(cpu_to_le32 (status), (__le32 *) buf);
+		put_unaligned_le32(status, buf);
 		break;
 	case SetHubFeature:
 		switch (wValue) {
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index 48e4b11..7c84a9e 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -666,14 +666,14 @@ static int ohci_hub_control (
 		break;
 	case GetHubStatus:
 		temp = roothub_status (ohci) & ~(RH_HS_CRWE | RH_HS_DRWE);
-		put_unaligned(cpu_to_le32 (temp), (__le32 *) buf);
+		put_unaligned_le32(temp, buf);
 		break;
 	case GetPortStatus:
 		if (!wIndex || wIndex > ports)
 			goto error;
 		wIndex--;
 		temp = roothub_portstatus (ohci, wIndex);
-		put_unaligned(cpu_to_le32 (temp), (__le32 *) buf);
+		put_unaligned_le32(temp, buf);
 
 #ifndef	OHCI_VERBOSE_DEBUG
 	if (*(u16*)(buf+2))	/* only if wPortChange is interesting */
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
index df6d60b..4c9cb55 100644
--- a/fs/ncpfs/ncplib_kernel.c
+++ b/fs/ncpfs/ncplib_kernel.c
@@ -39,7 +39,7 @@ static void ncp_add_word(struct ncp_server *server, __le16 x)
 static void ncp_add_be16(struct ncp_server *server, __u16 x)
 {
 	assert_server_locked(server);
-	put_unaligned(cpu_to_be16(x), (__be16 *) (&(server->packet[server->current_size])));
+	put_unaligned_be16(x, &server->packet[server->current_size]);
 	server->current_size += 2;
 }
 
@@ -54,7 +54,7 @@ static void ncp_add_dword(struct ncp_server *server, __le32 x)
 static void ncp_add_be32(struct ncp_server *server, __u32 x)
 {
 	assert_server_locked(server);
-	put_unaligned(cpu_to_be32(x), (__be32 *)(&(server->packet[server->current_size])));
+	put_unaligned_be32(x, &server->packet[server->current_size]);
 	server->current_size += 4;
 }
 
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
index a550546..7472103 100644
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
@@ -2910,8 +2910,8 @@ xfs_iextents_copy(
 		}
 
 		/* Translate to on disk format */
-		put_unaligned(cpu_to_be64(ep->l0), &dp->l0);
-		put_unaligned(cpu_to_be64(ep->l1), &dp->l1);
+		put_unaligned_be64(ep->l0, &dp->l0);
+		put_unaligned_be64(ep->l1, &dp->l1);
 		dp++;
 		copied++;
 	}
diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
index 8e7eff2..10c700a 100644
--- a/include/linux/reiserfs_fs.h
+++ b/include/linux/reiserfs_fs.h
@@ -526,8 +526,8 @@ struct item_head {
 ** p is the array of __u32, i is the index into the array, v is the value
 ** to store there.
 */
-#define get_block_num(p, i) le32_to_cpu(get_unaligned((p) + (i)))
-#define put_block_num(p, i, v) put_unaligned(cpu_to_le32(v), (p) + (i))
+#define get_block_num(p, i) get_unaligned_le32((p) + (i))
+#define put_block_num(p, i, v) put_unaligned_le32((v), (p) + (i))
 
 //
 // in old version uniqueness field shows key type
diff --git a/include/linux/smb_fs.h b/include/linux/smb_fs.h
index 2c5cd55..0a3e93d 100644
--- a/include/linux/smb_fs.h
+++ b/include/linux/smb_fs.h
@@ -43,18 +43,12 @@ static inline struct smb_inode_info *SMB_I(struct inode *inode)
 }
 
 /* macro names are short for word, double-word, long value (?) */
-#define WVAL(buf,pos) \
-	(le16_to_cpu(get_unaligned((__le16 *)((u8 *)(buf) + (pos)))))
-#define DVAL(buf,pos) \
-	(le32_to_cpu(get_unaligned((__le32 *)((u8 *)(buf) + (pos)))))
-#define LVAL(buf,pos) \
-	(le64_to_cpu(get_unaligned((__le64 *)((u8 *)(buf) + (pos)))))
-#define WSET(buf,pos,val) \
-	put_unaligned(cpu_to_le16((u16)(val)), (__le16 *)((u8 *)(buf) + (pos)))
-#define DSET(buf,pos,val) \
-	put_unaligned(cpu_to_le32((u32)(val)), (__le32 *)((u8 *)(buf) + (pos)))
-#define LSET(buf,pos,val) \
-	put_unaligned(cpu_to_le64((u64)(val)), (__le64 *)((u8 *)(buf) + (pos)))
+#define WVAL(buf,pos) (get_unaligned_le16((__le16 *)((u8 *)(buf) + (pos))))
+#define DVAL(buf,pos) (get_unaligned_le32((__le32 *)((u8 *)(buf) + (pos))))
+#define LVAL(buf,pos) (get_unaligned_le64((__le64 *)((u8 *)(buf) + (pos))))
+#define WSET(buf,pos,val) put_unaligned_le16((val), (u8 *)(buf) + (pos))
+#define DSET(buf,pos,val) put_unaligned_le32((val), (u8 *)(buf) + (pos))
+#define LSET(buf,pos,val) put_unaligned_le64((val), (u8 *)(buf) + (pos))
 
 /* where to find the base of the SMB packet proper */
 #define smb_base(buf) ((u8 *)(((u8 *)(buf))+4))
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
index 2957df4..20d6da4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1798,7 +1798,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
 		rsp->type   = cpu_to_le16(L2CAP_IT_FEAT_MASK);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
-		put_unaligned(cpu_to_le32(l2cap_feat_mask), (__le32 *) rsp->data);
+		put_unaligned_le32(l2cap_feat_mask, rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
 	} else {
@@ -1827,7 +1827,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 	del_timer(&conn->info_timer);
 
 	if (type == L2CAP_IT_FEAT_MASK)
-		conn->feat_mask = __le32_to_cpu(get_unaligned((__le32 *) rsp->data));
+		conn->feat_mask = putget_unaligned_le32((__le32 *)rsp->data);
 
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
diff --git a/net/irda/irttp.c b/net/irda/irttp.c
index 97db158..700b8fc 100644
--- a/net/irda/irttp.c
+++ b/net/irda/irttp.c
@@ -1159,8 +1159,7 @@ int irttp_connect_request(struct tsap_cb *self, __u8 dtsap_sel,
 		frame[2] = 0x01; /* MaxSduSize */
 		frame[3] = 0x02; /* Value length */
 
-		put_unaligned(cpu_to_be16((__u16) max_sdu_size),
-			      (__be16 *)(frame+4));
+		put_unaligned_be16(max_sdu_size, frame + 4);
 	} else {
 		/* Insert plain TTP header */
 		frame = skb_push(tx_skb, TTP_HEADER);
@@ -1406,8 +1405,7 @@ int irttp_connect_response(struct tsap_cb *self, __u32 max_sdu_size,
 		frame[2] = 0x01; /* MaxSduSize */
 		frame[3] = 0x02; /* Value length */
 
-		put_unaligned(cpu_to_be16((__u16) max_sdu_size),
-			      (__be16 *)(frame+4));
+		put_unaligned_be16(max_sdu_size, frame + 4);
 	} else {
 		/* Insert TTP header */
 		frame = skb_push(tx_skb, TTP_HEADER);
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
