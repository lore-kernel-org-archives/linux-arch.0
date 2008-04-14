From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/10] wireless: Use get/put_unaligned_* helpers
Date: Mon, 14 Apr 2008 09:37:56 -0700
Message-ID: <1208191076.5721.29.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/net/wireless/airo.c             |    2 +-
 drivers/net/wireless/ath5k/base.c       |    8 +-----
 drivers/net/wireless/b43/main.c         |    2 +-
 drivers/net/wireless/b43legacy/main.c   |    2 +-
 drivers/net/wireless/iwlwifi/iwl-3945.c |   32 +++++++++++++-----------------
 drivers/net/wireless/libertas/scan.c    |    2 +-
 drivers/net/wireless/zd1211rw/zd_usb.c  |    4 +-
 7 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 932d6b1..1865260 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -3657,7 +3657,7 @@ void mpi_receive_802_11 (struct airo_info *ai)
 	ptr += hdrlen;
 	if (hdrlen == 24)
 		ptr += 6;
-	gap = le16_to_cpu(get_unaligned((__le16 *)ptr));
+	gap = get_unaligned_le16(ptr);
 	ptr += sizeof(__le16);
 	if (gap) {
 		if (gap <= 8)
diff --git a/drivers/net/wireless/ath5k/base.c b/drivers/net/wireless/ath5k/base.c
index bef967c..ea1aba1 100644
--- a/drivers/net/wireless/ath5k/base.c
+++ b/drivers/net/wireless/ath5k/base.c
@@ -58,10 +58,6 @@
 #include "reg.h"
 #include "debug.h"
 
-/* unaligned little endian access */
-#define LE_READ_2(_p) (le16_to_cpu(get_unaligned((__le16 *)(_p))))
-#define LE_READ_4(_p) (le32_to_cpu(get_unaligned((__le32 *)(_p))))
-
 enum {
 	ATH_LED_TX,
 	ATH_LED_RX,
@@ -2800,9 +2796,9 @@ static void ath5k_configure_filter(struct ieee80211_hw *hw,
 			if (!mclist)
 				break;
 			/* calculate XOR of eight 6-bit values */
-			val = LE_READ_4(mclist->dmi_addr + 0);
+			val = get_unaligned_le32(mclist->dmi_addr + 0);
 			pos = (val >> 18) ^ (val >> 12) ^ (val >> 6) ^ val;
-			val = LE_READ_4(mclist->dmi_addr + 3);
+			val = get_unaligned_le32(mclist->dmi_addr + 3);
 			pos ^= (val >> 18) ^ (val >> 12) ^ (val >> 6) ^ val;
 			pos &= 0x3f;
 			mfilt[pos / 32] |= (1 << (pos % 32));
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
index 8d4d91d..cd7cb2f 100644
--- a/drivers/net/wireless/iwlwifi/iwl-3945.c
+++ b/drivers/net/wireless/iwlwifi/iwl-3945.c
@@ -279,40 +279,36 @@ static void iwl3945_add_radiotap(struct iwl3945_priv *priv,
 	iwl3945_rt->rt_hdr.it_pad = 0;
 
 	/* total header + data */
-	put_unaligned(cpu_to_le16(sizeof(*iwl3945_rt)),
-		      &iwl3945_rt->rt_hdr.it_len);
+	put_unaligned_le16(sizeof(*iwl3945_rt), &iwl3945_rt->rt_hdr.it_len);
 
 	/* Indicate all the fields we add to the radiotap header */
-	put_unaligned(cpu_to_le32((1 << IEEE80211_RADIOTAP_TSFT) |
-				  (1 << IEEE80211_RADIOTAP_FLAGS) |
-				  (1 << IEEE80211_RADIOTAP_RATE) |
-				  (1 << IEEE80211_RADIOTAP_CHANNEL) |
-				  (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL) |
-				  (1 << IEEE80211_RADIOTAP_DBM_ANTNOISE) |
-				  (1 << IEEE80211_RADIOTAP_ANTENNA)),
-		      &iwl3945_rt->rt_hdr.it_present);
+	put_unaligned_le32((1 << IEEE80211_RADIOTAP_TSFT) |
+			   (1 << IEEE80211_RADIOTAP_FLAGS) |
+			   (1 << IEEE80211_RADIOTAP_RATE) |
+			   (1 << IEEE80211_RADIOTAP_CHANNEL) |
+			   (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL) |
+			   (1 << IEEE80211_RADIOTAP_DBM_ANTNOISE) |
+			   (1 << IEEE80211_RADIOTAP_ANTENNA)),
+			&iwl3945_rt->rt_hdr.it_present);
 
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
+		put_unaligned_le16(IEEE80211_CHAN_OFDM | IEEE80211_CHAN_5GHZ,
 			      &iwl3945_rt->rt_chbitmask);
 	else if (phy_flags_hw & RX_RES_PHY_FLAGS_MOD_CCK_MSK)
-		put_unaligned(cpu_to_le16(IEEE80211_CHAN_CCK |
-					  IEEE80211_CHAN_2GHZ),
+		put_unaligned_le16(IEEE80211_CHAN_CCK | IEEE80211_CHAN_2GHZ,
 			      &iwl3945_rt->rt_chbitmask);
 	else	/* 802.11g */
-		put_unaligned(cpu_to_le16(IEEE80211_CHAN_OFDM |
-					  IEEE80211_CHAN_2GHZ),
+		put_unaligned_le16(IEEE80211_CHAN_OFDM | IEEE80211_CHAN_2GHZ,
 			      &iwl3945_rt->rt_chbitmask);
 
 	rate = iwl3945_rate_index_from_plcp(rate);
diff --git a/drivers/net/wireless/libertas/scan.c b/drivers/net/wireless/libertas/scan.c
index 69f94c9..02b4da2 100644
--- a/drivers/net/wireless/libertas/scan.c
+++ b/drivers/net/wireless/libertas/scan.c
@@ -711,7 +711,7 @@ static int lbs_process_bss(struct bss_descriptor *bss,
 
 	if (*bytesleft >= sizeof(beaconsize)) {
 		/* Extract & convert beacon size from the command buffer */
-		beaconsize = le16_to_cpu(get_unaligned((__le16 *)*pbeaconinfo));
+		beaconsize = get_unaligned_le16(*pbeaconinfo);
 		*bytesleft -= sizeof(beaconsize);
 		*pbeaconinfo += sizeof(beaconsize);
 	}
diff --git a/drivers/net/wireless/zd1211rw/zd_usb.c b/drivers/net/wireless/zd1211rw/zd_usb.c
index 7942b15..b48a3ad 100644
--- a/drivers/net/wireless/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zd1211rw/zd_usb.c
@@ -538,11 +538,11 @@ static void handle_rx_packet(struct zd_usb *usb, const u8 *buffer,
 	 * be padded. Unaligned access might also happen if the length_info
 	 * structure is not present.
 	 */
-	if (get_unaligned(&length_info->tag) == cpu_to_le16(RX_LENGTH_INFO_TAG))
+	if (get_unaligned_le16(&length_info->tag) == RX_LENGTH_INFO_TAG)
 	{
 		unsigned int l, k, n;
 		for (i = 0, l = 0;; i++) {
-			k = le16_to_cpu(get_unaligned(&length_info->length[i]));
+			k = get_unaligned_le16(&length_info->length[i]);
 			if (k == 0)
 				return;
 			n = l+k;
-- 
1.5.5.144.g3e42
