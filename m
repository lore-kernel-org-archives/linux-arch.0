Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:42754 "EHLO
	tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2FKMxh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jun 2012 08:53:37 -0400
Date: Mon, 11 Jun 2012 21:27:35 +0900
From: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Subject: [PATCH 0/4] Introduce generic set_bit_le()
Message-ID: <20120611212735.f92ea521.yoshikawa.takuya@oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bhutchings@solarflare.com, grundler@parisc-linux.org, arnd@arndb.de, avi@redhat.com, mtosatti@redhat.com
Cc: linux-net-drivers@solarflare.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, takuya.yoshikawa@gmail.com
Message-ID: <20120611122735.qPXi72uuYn9qBZW_dt7z4fSpgps0Fs6rs8g0QA5Wj-Y@z>

KVM is using test_and_set_bit_le() for this missing function; this patch
series corrects this usage.

As some drivers have their own definitions of set_bit_le(), which seem
to be incompatible with the generic one, renaming is also needed.

Note: the whole series is against linux-next.

Takuya Yoshikawa (4):
  drivers/net/ethernet/sfc: Add efx_ prefix to set_bit_le()
  drivers/net/ethernet/dec/tulip: Add tulip_ prefix to set_bit_le()
  bitops: Introduce generic set_bit_le()
  KVM: Replace test_and_set_bit_le() in mark_page_dirty_in_slot() with set_bit_le()

 drivers/net/ethernet/dec/tulip/de2104x.c    |    7 +++----
 drivers/net/ethernet/dec/tulip/tulip_core.c |    7 +++----
 drivers/net/ethernet/sfc/efx.c              |    4 ++--
 drivers/net/ethernet/sfc/net_driver.h       |    4 ++--
 drivers/net/ethernet/sfc/nic.c              |    4 ++--
 include/asm-generic/bitops/le.h             |    5 +++++
 virt/kvm/kvm_main.c                         |    3 +--
 7 files changed, 18 insertions(+), 16 deletions(-)

-- 
1.7.5.4

