Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1189 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBSOVI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 09:21:08 -0500
Date: Tue, 19 Feb 2019 20:48:43 +0800
From: kbuild test robot <lkp@intel.com>
Subject: [asm-generic:asm-generic 3/6] drivers/uio/uio_aec.c:62:49: sparse:
    expected void [noderef] <asn:2> *addr
Message-ID: <201902192036.JrMVd5ae%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: kbuild-all@01.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git asm-generic
head:   3c4fcc2648569c3fe573849f9254c8c3499ec648
commit: 8455ee4406a20caed2c3ef32b561c5773d4cfabf [3/6] iomap: add missing function args identifier names
reproduce:
        # apt-get install sparse
        git checkout 8455ee4406a20caed2c3ef32b561c5773d4cfabf
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   drivers/uio/uio_aec.c:56:49: sparse: warning: incorrect type in initializer (different address spaces)
   drivers/uio/uio_aec.c:56:49: sparse:    expected void [noderef] <asn:2> *int_flag
   drivers/uio/uio_aec.c:56:49: sparse:    got void *
   drivers/uio/uio_aec.c:62:49: sparse: warning: incorrect type in argument 1 (different address spaces)
>> drivers/uio/uio_aec.c:62:49: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:62:49: sparse:    got void *
   drivers/uio/uio_aec.c:71:9: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:71:9: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:71:9: sparse:    got void *
   drivers/uio/uio_aec.c:71:9: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:71:9: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:71:9: sparse:    got void *
   drivers/uio/uio_aec.c:71:9: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:71:9: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:71:9: sparse:    got void *
   drivers/uio/uio_aec.c:71:9: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:71:9: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:71:9: sparse:    got void *
   drivers/uio/uio_aec.c:71:9: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:71:9: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:71:9: sparse:    got void *
   drivers/uio/uio_aec.c:71:9: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:71:9: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:71:9: sparse:    got void *
   drivers/uio/uio_aec.c:100:20: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/uio/uio_aec.c:100:20: sparse:    expected void *priv
   drivers/uio/uio_aec.c:100:20: sparse:    got void [noderef] <asn:2> *
   drivers/uio/uio_aec.c:116:42: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/uio/uio_aec.c:116:42: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:116:42: sparse:    got void *
   drivers/uio/uio_aec.c:117:43: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/uio/uio_aec.c:117:43: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:117:43: sparse:    got void *
   drivers/uio/uio_aec.c:118:34: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:118:34: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:118:34: sparse:    got void *
   drivers/uio/uio_aec.c:127:31: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/uio/uio_aec.c:127:31: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:127:31: sparse:    got void *priv
   drivers/uio/uio_aec.c:142:42: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/uio/uio_aec.c:142:42: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:142:42: sparse:    got void *
   drivers/uio/uio_aec.c:143:43: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/uio/uio_aec.c:143:43: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:143:43: sparse:    got void *
   drivers/uio/uio_aec.c:145:28: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:145:28: sparse:    expected void [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:145:28: sparse:    got void *
   drivers/uio/uio_aec.c:150:21: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/uio/uio_aec.c:150:21: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/uio/uio_aec.c:150:21: sparse:    got void *priv
--
   drivers/mtd/devices/pmc551.c:750:29: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/mtd/devices/pmc551.c:750:29: sparse:    expected unsigned char [usertype] *start
   drivers/mtd/devices/pmc551.c:750:29: sparse:    got void [noderef] <asn:2> *
   drivers/mtd/devices/pmc551.c:790:53: sparse: warning: incorrect type in argument 2 (different address spaces)
>> drivers/mtd/devices/pmc551.c:790:53: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mtd/devices/pmc551.c:790:53: sparse:    got unsigned char [usertype] *start
   drivers/mtd/devices/pmc551.c:840:52: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mtd/devices/pmc551.c:840:52: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mtd/devices/pmc551.c:840:52: sparse:    got unsigned char [usertype] *start
--
   drivers/net/ethernet/dlink/dl2k.c:352:35: sparse: warning: restricted __le32 degrades to integer
   drivers/net/ethernet/dlink/dl2k.c:576:17: sparse: warning: incorrect type in argument 1 (different base types)
>> drivers/net/ethernet/dlink/dl2k.c:576:17: sparse:    expected unsigned short [usertype] value
   drivers/net/ethernet/dlink/dl2k.c:576:17: sparse:    got restricted __le16 [usertype]
--
   drivers/net/ethernet/realtek/8139too.c:2245:9: sparse: warning: incorrect type in argument 1 (different base types)
>> drivers/net/ethernet/realtek/8139too.c:2245:9: sparse:    expected unsigned int [usertype] value
   drivers/net/ethernet/realtek/8139too.c:2245:9: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/realtek/8139too.c:2246:9: sparse: warning: incorrect type in argument 1 (different base types)
   drivers/net/ethernet/realtek/8139too.c:2246:9: sparse:    expected unsigned int [usertype] value
   drivers/net/ethernet/realtek/8139too.c:2246:9: sparse:    got restricted __le32 [usertype]
--
   drivers/input/serio/apbps2.c:69:42: sparse: warning: incorrect type in argument 1 (different address spaces)
>> drivers/input/serio/apbps2.c:69:42: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:69:42: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:70:40: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/input/serio/apbps2.c:70:40: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:70:40: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:76:45: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/input/serio/apbps2.c:76:45: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:76:45: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:92:33: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/input/serio/apbps2.c:92:33: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:92:33: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:95:30: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/input/serio/apbps2.c:95:30: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:95:30: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:96:39: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/input/serio/apbps2.c:96:39: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:96:39: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:99:38: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/input/serio/apbps2.c:99:38: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:99:38: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:113:29: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/input/serio/apbps2.c:113:29: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:113:29: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:117:33: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/input/serio/apbps2.c:117:33: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:117:33: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:118:39: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/input/serio/apbps2.c:118:39: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:118:39: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:121:59: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/input/serio/apbps2.c:121:59: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:121:59: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:131:29: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/input/serio/apbps2.c:131:29: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:131:29: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:150:20: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/input/serio/apbps2.c:150:20: sparse:    expected struct apbps2_regs *regs
   drivers/input/serio/apbps2.c:150:20: sparse:    got void [noderef] <asn:2> *
   drivers/input/serio/apbps2.c:155:29: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/input/serio/apbps2.c:155:29: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:155:29: sparse:    got unsigned int [noderef] *
   drivers/input/serio/apbps2.c:173:43: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/input/serio/apbps2.c:173:43: sparse:    expected void [noderef] <asn:2> *addr
   drivers/input/serio/apbps2.c:173:43: sparse:    got unsigned int [noderef] *
--
   drivers/usb/gadget/udc/mv_u3d_core.c:47:33: sparse: warning: incorrect type in initializer (different base types)
   drivers/usb/gadget/udc/mv_u3d_core.c:47:33: sparse:    expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/mv_u3d_core.c:47:33: sparse:    got int
   drivers/usb/gadget/udc/mv_u3d_core.c:241:35: sparse: warning: incorrect type in assignment (different base types)
   drivers/usb/gadget/udc/mv_u3d_core.c:241:35: sparse:    expected unsigned int [usertype] rsvd0
   drivers/usb/gadget/udc/mv_u3d_core.c:241:35: sparse:    got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:247:41: sparse: warning: incorrect type in assignment (different base types)
   drivers/usb/gadget/udc/mv_u3d_core.c:247:41: sparse:    expected unsigned int [usertype] trb_addr_lo
   drivers/usb/gadget/udc/mv_u3d_core.c:247:41: sparse:    got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:305:29: sparse: warning: incorrect type in assignment (different base types)
   drivers/usb/gadget/udc/mv_u3d_core.c:305:29: sparse:    expected unsigned int [usertype] buf_addr_lo
   drivers/usb/gadget/udc/mv_u3d_core.c:305:29: sparse:    got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:307:25: sparse: warning: incorrect type in assignment (different base types)
   drivers/usb/gadget/udc/mv_u3d_core.c:307:25: sparse:    expected unsigned int [usertype] trb_len
   drivers/usb/gadget/udc/mv_u3d_core.c:307:25: sparse:    got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:351:34: sparse: warning: incorrect type in assignment (different base types)
   drivers/usb/gadget/udc/mv_u3d_core.c:351:34: sparse:    expected unsigned int [usertype] buf_addr_lo
   drivers/usb/gadget/udc/mv_u3d_core.c:351:34: sparse:    got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:353:30: sparse: warning: incorrect type in assignment (different base types)
   drivers/usb/gadget/udc/mv_u3d_core.c:353:30: sparse:    expected unsigned int [usertype] trb_len
   drivers/usb/gadget/udc/mv_u3d_core.c:353:30: sparse:    got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_u3d_core.c:889:42: sparse: warning: incorrect type in argument 2 (different address spaces)
>> drivers/usb/gadget/udc/mv_u3d_core.c:889:42: sparse:    expected void [noderef] <asn:2> *addr
   drivers/usb/gadget/udc/mv_u3d_core.c:889:42: sparse:    got unsigned int *
   drivers/usb/gadget/udc/mv_u3d_core.c:1478:26: sparse: warning: cast from restricted __le16
--
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse: warning: incorrect type in argument 2 (different address spaces)
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:    expected void [noderef] <asn:2> *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:    got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:    expected void [noderef] <asn:2> *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:    got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:    got void *[assigned] emap
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:    expected void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:    got void [noderef] <asn:2> *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse: warning: incorrect type in return expression (different address spaces)
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:    expected void [noderef] <asn:2> *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:    got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse: warning: incorrect type in return expression (different address spaces)
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:    expected void [noderef] <asn:2> *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:    got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:    expected void [noderef] <asn:2> *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:    got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:    got void *[assigned] map
--
   drivers/net/ethernet/renesas/sh_eth.c:940:37: sparse: warning: incorrect type in argument 1 (different address spaces)
>> drivers/net/ethernet/renesas/sh_eth.c:940:37: sparse:    expected void [noderef] <asn:2> *addr
   drivers/net/ethernet/renesas/sh_eth.c:940:37: sparse:    got void *
   drivers/net/ethernet/renesas/sh_eth.c:941:37: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/net/ethernet/renesas/sh_eth.c:941:37: sparse:    expected void [noderef] <asn:2> *addr
   drivers/net/ethernet/renesas/sh_eth.c:941:37: sparse:    got void *
   drivers/net/ethernet/renesas/sh_eth.c:948:37: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/net/ethernet/renesas/sh_eth.c:948:37: sparse:    expected void [noderef] <asn:2> *addr
   drivers/net/ethernet/renesas/sh_eth.c:948:37: sparse:    got void *
   drivers/net/ethernet/renesas/sh_eth.c:949:37: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/net/ethernet/renesas/sh_eth.c:949:37: sparse:    expected void [noderef] <asn:2> *addr
   drivers/net/ethernet/renesas/sh_eth.c:949:37: sparse:    got void *
   drivers/net/ethernet/renesas/sh_eth.c:1214:31: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/net/ethernet/renesas/sh_eth.c:1214:31: sparse:    expected void [noderef] <asn:2> *addr
   drivers/net/ethernet/renesas/sh_eth.c:1214:31: sparse:    got void *addr
   drivers/net/ethernet/renesas/sh_eth.c:1219:31: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/net/ethernet/renesas/sh_eth.c:1219:31: sparse:    expected void [noderef] <asn:2> *addr
   drivers/net/ethernet/renesas/sh_eth.c:1219:31: sparse:    got void *addr
   drivers/net/ethernet/renesas/sh_eth.c:1242:33: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/net/ethernet/renesas/sh_eth.c:1242:33: sparse:    expected void [noderef] <asn:2> *addr
   drivers/net/ethernet/renesas/sh_eth.c:1242:33: sparse:    got void *addr
   drivers/net/ethernet/renesas/sh_eth.c:1272:43: sparse: warning: restricted __le32 degrades to integer
   drivers/net/ethernet/renesas/sh_eth.c:1277:17: sparse: warning: cast to restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1282:25: sparse: warning: cast to restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1282:25: sparse: warning: cast to restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1290:32: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:1290:32: sparse:    expected unsigned int [usertype] status
   drivers/net/ethernet/renesas/sh_eth.c:1290:32: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:1292:40: sparse: warning: invalid assignment: |=
   drivers/net/ethernet/renesas/sh_eth.c:1292:40: sparse:    left side has type unsigned int
   drivers/net/ethernet/renesas/sh_eth.c:1292:40: sparse:    right side has type restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1296:49: sparse: warning: cast to restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1313:33: sparse: warning: cast to restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1389:29: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:1389:29: sparse:    expected unsigned int [usertype] len
   drivers/net/ethernet/renesas/sh_eth.c:1389:29: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:1390:30: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:1390:30: sparse:    expected unsigned int [usertype] addr
   drivers/net/ethernet/renesas/sh_eth.c:1390:30: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:1391:32: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:1391:32: sparse:    expected unsigned int [usertype] status
   drivers/net/ethernet/renesas/sh_eth.c:1391:32: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:1405:32: sparse: warning: invalid assignment: |=
   drivers/net/ethernet/renesas/sh_eth.c:1405:32: sparse:    left side has type unsigned int
   drivers/net/ethernet/renesas/sh_eth.c:1405:32: sparse:    right side has type restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1413:32: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:1413:32: sparse:    expected unsigned int [usertype] status
   drivers/net/ethernet/renesas/sh_eth.c:1413:32: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:1414:29: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:1414:29: sparse:    expected unsigned int [usertype] len
   drivers/net/ethernet/renesas/sh_eth.c:1414:29: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:1423:24: sparse: warning: invalid assignment: |=
   drivers/net/ethernet/renesas/sh_eth.c:1423:24: sparse:    left side has type unsigned int
   drivers/net/ethernet/renesas/sh_eth.c:1423:24: sparse:    right side has type restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1574:40: sparse: warning: invalid assignment: &=
   drivers/net/ethernet/renesas/sh_eth.c:1574:40: sparse:    left side has type unsigned int
   drivers/net/ethernet/renesas/sh_eth.c:1574:40: sparse:    right side has type restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1614:35: sparse: warning: restricted __le32 degrades to integer
   drivers/net/ethernet/renesas/sh_eth.c:1617:31: sparse: warning: cast to restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1618:27: sparse: warning: cast to restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1656:36: sparse: warning: cast to restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1685:29: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:1685:29: sparse:    expected unsigned int [usertype] len
   drivers/net/ethernet/renesas/sh_eth.c:1685:29: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:1701:38: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:1701:38: sparse:    expected unsigned int [usertype] addr
   drivers/net/ethernet/renesas/sh_eth.c:1701:38: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:1705:40: sparse: warning: invalid assignment: |=
   drivers/net/ethernet/renesas/sh_eth.c:1705:40: sparse:    left side has type unsigned int
   drivers/net/ethernet/renesas/sh_eth.c:1705:40: sparse:    right side has type restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:1708:40: sparse: warning: invalid assignment: |=
   drivers/net/ethernet/renesas/sh_eth.c:1708:40: sparse:    left side has type unsigned int
   drivers/net/ethernet/renesas/sh_eth.c:1708:40: sparse:    right side has type restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:2475:32: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:2475:32: sparse:    expected unsigned int [usertype] status
   drivers/net/ethernet/renesas/sh_eth.c:2475:32: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:2476:30: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:2476:30: sparse:    expected unsigned int [usertype] addr
   drivers/net/ethernet/renesas/sh_eth.c:2476:30: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:2526:22: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:2526:22: sparse:    expected unsigned int [usertype] addr
   drivers/net/ethernet/renesas/sh_eth.c:2526:22: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:2527:22: sparse: warning: incorrect type in assignment (different base types)
   drivers/net/ethernet/renesas/sh_eth.c:2527:22: sparse:    expected unsigned int [usertype] len
   drivers/net/ethernet/renesas/sh_eth.c:2527:22: sparse:    got restricted __le32 [usertype]
   drivers/net/ethernet/renesas/sh_eth.c:2531:32: sparse: warning: invalid assignment: |=
   drivers/net/ethernet/renesas/sh_eth.c:2531:32: sparse:    left side has type unsigned int
   drivers/net/ethernet/renesas/sh_eth.c:2531:32: sparse:    right side has type restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:2533:32: sparse: warning: invalid assignment: |=
   drivers/net/ethernet/renesas/sh_eth.c:2533:32: sparse:    left side has type unsigned int
   drivers/net/ethernet/renesas/sh_eth.c:2533:32: sparse:    right side has type restricted __le32
   drivers/net/ethernet/renesas/sh_eth.c:3039:23: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/net/ethernet/renesas/sh_eth.c:3039:23: sparse:    expected void *addr
   drivers/net/ethernet/renesas/sh_eth.c:3039:23: sparse:    got void [noderef] <asn:2> *
--
   drivers/scsi/mvumi.c:97:52: sparse: warning: incorrect type in argument 2 (different address spaces)
>> drivers/scsi/mvumi.c:97:52: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:97:52: sparse:    got void *
   drivers/scsi/mvumi.c:106:39: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/scsi/mvumi.c:106:39: sparse:    expected void *
   drivers/scsi/mvumi.c:106:39: sparse:    got void [noderef] <asn:2> *
   drivers/scsi/mvumi.c:226:34: sparse: warning: incorrect type in assignment (different base types)
   drivers/scsi/mvumi.c:226:34: sparse:    expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:226:34: sparse:    got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:227:34: sparse: warning: incorrect type in assignment (different base types)
   drivers/scsi/mvumi.c:227:34: sparse:    expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:227:34: sparse:    got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:229:17: sparse: warning: invalid assignment: |=
   drivers/scsi/mvumi.c:229:17: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:229:17: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:229:17: sparse: warning: incorrect type in assignment (different base types)
   drivers/scsi/mvumi.c:229:17: sparse:    expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:229:17: sparse:    got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:258:26: sparse: warning: incorrect type in assignment (different base types)
   drivers/scsi/mvumi.c:258:26: sparse:    expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:258:26: sparse:    got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:259:26: sparse: warning: incorrect type in assignment (different base types)
   drivers/scsi/mvumi.c:259:26: sparse:    expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:259:26: sparse:    got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:261:9: sparse: warning: invalid assignment: |=
   drivers/scsi/mvumi.c:261:9: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:261:9: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:261:9: sparse: warning: incorrect type in assignment (different base types)
   drivers/scsi/mvumi.c:261:9: sparse:    expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:261:9: sparse:    got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:423:40: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:423:40: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:423:40: sparse:    got void *inb_read_pointer
   drivers/scsi/mvumi.c:445:30: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:445:30: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:445:30: sparse:    got void *ib_shadow
   drivers/scsi/mvumi.c:474:31: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:474:31: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:474:31: sparse:    got void *ib_shadow
   drivers/scsi/mvumi.c:475:48: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:475:48: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:475:48: sparse:    got void *inb_write_pointer
   drivers/scsi/mvumi.c:512:41: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:512:41: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:512:41: sparse:    got void *outb_copy_pointer
   drivers/scsi/mvumi.c:513:48: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:513:48: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:513:48: sparse:    got void *ob_shadow
   drivers/scsi/mvumi.c:532:33: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:532:33: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:532:33: sparse:    got void *outb_read_pointer
   drivers/scsi/mvumi.c:533:33: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:533:33: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:533:33: sparse:    got void *outb_copy_pointer
   drivers/scsi/mvumi.c:594:42: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:594:42: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:594:42: sparse:    got void *outb_read_pointer
   drivers/scsi/mvumi.c:601:26: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:601:26: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:601:26: sparse:    got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:602:26: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:602:26: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:602:26: sparse:    got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:605:40: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:605:40: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:605:40: sparse:    got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1297:28: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:1297:28: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:1297:28: sparse:    got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1298:28: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:1298:28: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:1298:28: sparse:    got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1300:48: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:1300:48: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:1300:48: sparse:    got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1301:28: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:1301:28: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:1301:28: sparse:    got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1302:28: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:1302:28: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:1302:28: sparse:    got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:628:26: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:628:26: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:628:26: sparse:    got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:629:28: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:629:28: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:629:28: sparse:    got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:631:46: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:631:46: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:631:46: sparse:    got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:640:36: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/mvumi.c:640:36: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:640:36: sparse:    got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:686:32: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:686:32: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:686:32: sparse:    got void *reset_enable
   drivers/scsi/mvumi.c:687:34: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:687:34: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:687:34: sparse:    got void *reset_request
   drivers/scsi/mvumi.c:689:35: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/mvumi.c:689:35: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/mvumi.c:689:35: sparse:    got void *reset_enable
--
   drivers/scsi/vmw_pvscsi.c:212:39: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/scsi/vmw_pvscsi.c:212:39: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/scsi/vmw_pvscsi.c:212:39: sparse:    got char *
   drivers/scsi/vmw_pvscsi.c:217:40: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/scsi/vmw_pvscsi.c:217:40: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/scsi/vmw_pvscsi.c:217:40: sparse:    got char *
   drivers/scsi/vmw_pvscsi.c:1208:50: sparse: warning: incorrect type in argument 2 (different address spaces)
>> drivers/scsi/vmw_pvscsi.c:1208:50: sparse:    expected void [noderef] <asn:2> *addr
   drivers/scsi/vmw_pvscsi.c:1208:50: sparse:    got char *mmioBase
   drivers/scsi/vmw_pvscsi.c:1387:27: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/scsi/vmw_pvscsi.c:1387:27: sparse:    expected char *mmioBase
   drivers/scsi/vmw_pvscsi.c:1387:27: sparse:    got void [noderef] <asn:2> *
--
   drivers/mailbox/bcm-pdc-mailbox.c:696:28: sparse: warning: incorrect type in argument 1 (different address spaces)
>> drivers/mailbox/bcm-pdc-mailbox.c:696:28: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:696:28: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:572:22: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:572:22: sparse:    expected unsigned int [usertype] addrlow
   drivers/mailbox/bcm-pdc-mailbox.c:572:22: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:573:23: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:573:23: sparse:    expected unsigned int [usertype] addrhigh
   drivers/mailbox/bcm-pdc-mailbox.c:573:23: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:574:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:574:20: sparse:    expected unsigned int [usertype] ctrl1
   drivers/mailbox/bcm-pdc-mailbox.c:574:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:575:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:575:20: sparse:    expected unsigned int [usertype] ctrl2
   drivers/mailbox/bcm-pdc-mailbox.c:575:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:572:22: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:572:22: sparse:    expected unsigned int [usertype] addrlow
   drivers/mailbox/bcm-pdc-mailbox.c:572:22: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:573:23: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:573:23: sparse:    expected unsigned int [usertype] addrhigh
   drivers/mailbox/bcm-pdc-mailbox.c:573:23: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:574:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:574:20: sparse:    expected unsigned int [usertype] ctrl1
   drivers/mailbox/bcm-pdc-mailbox.c:574:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:575:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:575:20: sparse:    expected unsigned int [usertype] ctrl2
   drivers/mailbox/bcm-pdc-mailbox.c:575:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:806:42: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:806:42: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:806:42: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:807:42: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:807:42: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:807:42: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse:    expected unsigned int [usertype] addrlow
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse:    expected unsigned int [usertype] addrhigh
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse:    expected unsigned int [usertype] ctrl1
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse:    expected unsigned int [usertype] ctrl2
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse:    expected unsigned int [usertype] addrlow
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse:    expected unsigned int [usertype] addrhigh
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse:    expected unsigned int [usertype] ctrl1
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse:    expected unsigned int [usertype] ctrl2
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse:    expected unsigned int [usertype] addrlow
   drivers/mailbox/bcm-pdc-mailbox.c:544:22: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse:    expected unsigned int [usertype] addrhigh
   drivers/mailbox/bcm-pdc-mailbox.c:545:23: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse:    expected unsigned int [usertype] ctrl1
   drivers/mailbox/bcm-pdc-mailbox.c:546:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse: warning: incorrect type in assignment (different base types)
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse:    expected unsigned int [usertype] ctrl2
   drivers/mailbox/bcm-pdc-mailbox.c:547:20: sparse:    got restricted __le32 [usertype]
   drivers/mailbox/bcm-pdc-mailbox.c:1045:32: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1045:32: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1045:32: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1047:20: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1047:20: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1047:20: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1048:23: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1048:23: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1048:23: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1049:23: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1049:23: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1049:23: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1053:20: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1053:20: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1053:20: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1055:20: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1055:20: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1055:20: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1058:20: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1058:20: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1058:20: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1060:20: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1060:20: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1060:20: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1063:48: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1063:48: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1063:48: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1065:20: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1065:20: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1065:20: sparse:    got unsigned int *
   drivers/mailbox/bcm-pdc-mailbox.c:1072:48: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/bcm-pdc-mailbox.c:1072:48: sparse:    expected void [noderef] <asn:2> *addr
   drivers/mailbox/bcm-pdc-mailbox.c:1072:48: sparse:    got unsigned int *
--
   drivers/gpu/drm/ttm/ttm_bo_util.c:223:30: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:223:30: sparse:    expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:223:30: sparse:    got void [noderef] <asn:2> *
   drivers/gpu/drm/ttm/ttm_bo_util.c:225:30: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:225:30: sparse:    expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:225:30: sparse:    got void [noderef] <asn:2> *
   drivers/gpu/drm/ttm/ttm_bo_util.c:245:25: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:245:25: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:245:25: sparse:    got void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:260:40: sparse: warning: incorrect type in argument 1 (different address spaces)
>> drivers/gpu/drm/ttm/ttm_bo_util.c:260:40: sparse:    expected void [noderef] <asn:2> *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:260:40: sparse:    got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:260:49: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:260:49: sparse:    expected void [noderef] <asn:2> *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:260:49: sparse:    got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:327:28: sparse: warning: incorrect type in argument 2 (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:327:28: sparse:    expected void const volatile [noderef] <asn:2> *
   drivers/gpu/drm/ttm/ttm_bo_util.c:327:28: sparse:    got void *[assigned] src
   drivers/gpu/drm/ttm/ttm_bo_util.c:349:21: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:349:21: sparse:    expected void volatile [noderef] <asn:2> *
   drivers/gpu/drm/ttm/ttm_bo_util.c:349:21: sparse:    got void *[assigned] dst
   drivers/gpu/drm/ttm/ttm_bo_util.c:396:27: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:396:27: sparse:    expected void volatile [noderef] <asn:2> *
   drivers/gpu/drm/ttm/ttm_bo_util.c:396:27: sparse:    got void *[addressable] new_iomap
   drivers/gpu/drm/ttm/ttm_bo_util.c:568:38: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:568:38: sparse:    expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:568:38: sparse:    got void [noderef] <asn:2> *
   drivers/gpu/drm/ttm/ttm_bo_util.c:571:38: sparse: warning: incorrect type in assignment (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:571:38: sparse:    expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:571:38: sparse:    got void [noderef] <asn:2> *
   drivers/gpu/drm/ttm/ttm_bo_util.c:660:28: sparse: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/ttm/ttm_bo_util.c:660:28: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:660:28: sparse:    got void *virtual
   include/linux/reservation.h:220:20: sparse: warning: dereference of noderef expression
   include/linux/reservation.h:220:45: sparse: warning: dereference of noderef expression
   include/linux/reservation.h:220:20: sparse: warning: dereference of noderef expression
   include/linux/reservation.h:220:45: sparse: warning: dereference of noderef expression
   include/linux/reservation.h:220:20: sparse: warning: dereference of noderef expression
   include/linux/reservation.h:220:45: sparse: warning: dereference of noderef expression

vim +62 drivers/uio/uio_aec.c

1bafeb37 Brandon Philips 2009-01-27  53  
1bafeb37 Brandon Philips 2009-01-27  54  static irqreturn_t aectc_irq(int irq, struct uio_info *dev_info)
1bafeb37 Brandon Philips 2009-01-27  55  {
1bafeb37 Brandon Philips 2009-01-27 @56  	void __iomem *int_flag = dev_info->priv + INTA_DRVR_ADDR;
1bafeb37 Brandon Philips 2009-01-27  57  	unsigned char status = ioread8(int_flag);
1bafeb37 Brandon Philips 2009-01-27  58  
1bafeb37 Brandon Philips 2009-01-27  59  
1bafeb37 Brandon Philips 2009-01-27  60  	if ((status & INTA_ENABLED_FLAG) && (status & INTA_FLAG)) {
1bafeb37 Brandon Philips 2009-01-27  61  		/* application writes 0x00 to 0x2F to get next interrupt */
1bafeb37 Brandon Philips 2009-01-27 @62  		status = ioread8(dev_info->priv + MAILBOX);
1bafeb37 Brandon Philips 2009-01-27  63  		return IRQ_HANDLED;
1bafeb37 Brandon Philips 2009-01-27  64  	}
1bafeb37 Brandon Philips 2009-01-27  65  
1bafeb37 Brandon Philips 2009-01-27  66  	return IRQ_NONE;
1bafeb37 Brandon Philips 2009-01-27  67  }
1bafeb37 Brandon Philips 2009-01-27  68  

:::::: The code at line 62 was first introduced by commit
:::::: 1bafeb378e915f39b1bf44ee0871823d6f402ea5 uio: add the uio_aec driver

:::::: TO: Brandon Philips <brandon@ifup.org>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
