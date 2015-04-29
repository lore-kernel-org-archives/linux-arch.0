From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/13] input: Use bool and don't use !! on test_bit
Date: Wed, 29 Apr 2015 20:22:28 +0100
Message-ID: <20150429192228.24909.7027.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make is_event_supported() return a bool as it returns a boolean value.  This
will allow gcc to make better decisions.

Don't use '!!' on test_bit() as test_bit() now returns a bool.  This avoids
gcc-5 warnings about using '!' operators on the LHS of a comparison.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/hid/hid-input.c |    4 ++--
 drivers/input/input.c   |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 008e89bf6f3c..b470913fdedb 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1157,7 +1157,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	/* report the usage code as scancode if the key status has changed */
-	if (usage->type == EV_KEY && !!test_bit(usage->code, input->key) != value)
+	if (usage->type == EV_KEY && test_bit(usage->code, input->key) != value)
 		input_event(input, EV_MSC, MSC_SCAN, usage->hid);
 
 	input_event(input, usage->type, usage->code, value);
@@ -1411,7 +1411,7 @@ static bool hidinput_has_been_populated(struct hid_input *hidinput)
 	for (i = 0; i < BITS_TO_LONGS(SW_CNT); i++)
 		r |= hidinput->input->swbit[i];
 
-	return !!r;
+	return r != 0;
 }
 
 static void hidinput_cleanup_hidinput(struct hid_device *hid,
diff --git a/drivers/input/input.c b/drivers/input/input.c
index cc357f1516a7..49bf0cadcc6b 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -50,8 +50,8 @@ static DEFINE_MUTEX(input_mutex);
 
 static const struct input_value input_value_sync = { EV_SYN, SYN_REPORT, 1 };
 
-static inline int is_event_supported(unsigned int code,
-				     unsigned long *bm, unsigned int max)
+static inline bool is_event_supported(unsigned int code,
+				      unsigned long *bm, unsigned int max)
 {
 	return code <= max && test_bit(code, bm);
 }
@@ -294,7 +294,7 @@ static int input_get_disposition(struct input_dev *dev,
 				break;
 			}
 
-			if (!!test_bit(code, dev->key) != !!value) {
+			if (test_bit(code, dev->key) != !!value) {
 
 				__change_bit(code, dev->key);
 				disposition = INPUT_PASS_TO_HANDLERS;
@@ -304,7 +304,7 @@ static int input_get_disposition(struct input_dev *dev,
 
 	case EV_SW:
 		if (is_event_supported(code, dev->swbit, SW_MAX) &&
-		    !!test_bit(code, dev->sw) != !!value) {
+		    test_bit(code, dev->sw) != !!value) {
 
 			__change_bit(code, dev->sw);
 			disposition = INPUT_PASS_TO_HANDLERS;
@@ -331,7 +331,7 @@ static int input_get_disposition(struct input_dev *dev,
 
 	case EV_LED:
 		if (is_event_supported(code, dev->ledbit, LED_MAX) &&
-		    !!test_bit(code, dev->led) != !!value) {
+		    test_bit(code, dev->led) != !!value) {
 
 			__change_bit(code, dev->led);
 			disposition = INPUT_PASS_TO_ALL;
@@ -341,7 +341,7 @@ static int input_get_disposition(struct input_dev *dev,
 	case EV_SND:
 		if (is_event_supported(code, dev->sndbit, SND_MAX)) {
 
-			if (!!test_bit(code, dev->snd) != !!value)
+			if (test_bit(code, dev->snd) != !!value)
 				__change_bit(code, dev->snd);
 			disposition = INPUT_PASS_TO_ALL;
 		}
