From: Alex Belits <abelits@marvell.com>
Subject: [PATCH 02/13] task_isolation: vmstat: add vmstat_idle function
Date: Thu, 9 Apr 2020 15:16:42 +0000
Message-ID: <6b3631e4543e467b6261f7a4bf0792d6f86eafc7.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
         <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21720 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727986AbgDIPRL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 11:17:11 -0400
In-Reply-To: <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
Content-Language: en-US
Content-ID: <56A6499FF35C8548BB3097BDC4A1FF84@namprd18.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>

VGhpcyBmdW5jdGlvbiBjaGVja3MgdG8gc2VlIGlmIGEgdm1zdGF0IHdvcmtlciBpcyBub3QgcnVu
bmluZywNCmFuZCB0aGUgdm1zdGF0IGRpZmZzIGRvbid0IHJlcXVpcmUgYW4gdXBkYXRlLiAgVGhl
IGZ1bmN0aW9uIGlzDQpjYWxsZWQgZnJvbSB0aGUgdGFzay1pc29sYXRpb24gY29kZSB0byBzZWUg
aWYgd2UgbmVlZCB0bw0KYWN0dWFsbHkgZG8gc29tZSB3b3JrIHRvIHF1aWV0IHZtc3RhdC4NCg0K
U2lnbmVkLW9mZi1ieTogQ2hyaXMgTWV0Y2FsZiA8Y21ldGNhbGZAbWVsbGFub3guY29tPg0KU2ln
bmVkLW9mZi1ieTogQWxleCBCZWxpdHMgPGFiZWxpdHNAbWFydmVsbC5jb20+DQotLS0NCiBpbmNs
dWRlL2xpbnV4L3Ztc3RhdC5oIHwgIDIgKysNCiBtbS92bXN0YXQuYyAgICAgICAgICAgIHwgMTAg
KysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC92bXN0YXQuaCBiL2luY2x1ZGUvbGludXgvdm1zdGF0LmgNCmlu
ZGV4IDJiYzVlODVmMjUxNC4uNjZkOWFlMzJjZjA3IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51
eC92bXN0YXQuaA0KKysrIGIvaW5jbHVkZS9saW51eC92bXN0YXQuaA0KQEAgLTI3MSw2ICsyNzEs
NyBAQCBleHRlcm4gdm9pZCBfX2RlY19ub2RlX3N0YXRlKHN0cnVjdCBwZ2xpc3RfZGF0YSAqLCBl
bnVtIG5vZGVfc3RhdF9pdGVtKTsNCiANCiB2b2lkIHF1aWV0X3Ztc3RhdCh2b2lkKTsNCiB2b2lk
IHF1aWV0X3Ztc3RhdF9zeW5jKHZvaWQpOw0KK2Jvb2wgdm1zdGF0X2lkbGUodm9pZCk7DQogdm9p
ZCBjcHVfdm1fc3RhdHNfZm9sZChpbnQgY3B1KTsNCiB2b2lkIHJlZnJlc2hfem9uZV9zdGF0X3Ro
cmVzaG9sZHModm9pZCk7DQogDQpAQCAtMzc0LDYgKzM3NSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCByZWZyZXNoX3pvbmVfc3RhdF90aHJlc2hvbGRzKHZvaWQpIHsgfQ0KIHN0YXRpYyBpbmxpbmUg
dm9pZCBjcHVfdm1fc3RhdHNfZm9sZChpbnQgY3B1KSB7IH0NCiBzdGF0aWMgaW5saW5lIHZvaWQg
cXVpZXRfdm1zdGF0KHZvaWQpIHsgfQ0KIHN0YXRpYyBpbmxpbmUgdm9pZCBxdWlldF92bXN0YXRf
c3luYyh2b2lkKSB7IH0NCitzdGF0aWMgaW5saW5lIGJvb2wgdm1zdGF0X2lkbGUodm9pZCkgeyBy
ZXR1cm4gdHJ1ZTsgfQ0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZCBkcmFpbl96b25lc3RhdChzdHJ1
Y3Qgem9uZSAqem9uZSwNCiAJCQlzdHJ1Y3QgcGVyX2NwdV9wYWdlc2V0ICpwc2V0KSB7IH0NCmRp
ZmYgLS1naXQgYS9tbS92bXN0YXQuYyBiL21tL3Ztc3RhdC5jDQppbmRleCAxZmEwYjJkMDRhZmEu
LjVjNGFlYzY1MTA2MiAxMDA2NDQNCi0tLSBhL21tL3Ztc3RhdC5jDQorKysgYi9tbS92bXN0YXQu
Yw0KQEAgLTE4NzksNiArMTg3OSwxNiBAQCB2b2lkIHF1aWV0X3Ztc3RhdF9zeW5jKHZvaWQpDQog
CXJlZnJlc2hfY3B1X3ZtX3N0YXRzKGZhbHNlKTsNCiB9DQogDQorLyoNCisgKiBSZXBvcnQgb24g
d2hldGhlciB2bXN0YXQgcHJvY2Vzc2luZyBpcyBxdWllc2NlZCBvbiB0aGUgY29yZSBjdXJyZW50
bHk6DQorICogbm8gdm1zdGF0IHdvcmtlciBydW5uaW5nIGFuZCBubyB2bXN0YXQgdXBkYXRlcyB0
byBwZXJmb3JtLg0KKyAqLw0KK2Jvb2wgdm1zdGF0X2lkbGUodm9pZCkNCit7DQorCXJldHVybiAh
ZGVsYXllZF93b3JrX3BlbmRpbmcodGhpc19jcHVfcHRyKCZ2bXN0YXRfd29yaykpICYmDQorCQkh
bmVlZF91cGRhdGUoc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCit9DQorDQogLyoNCiAgKiBTaGVwaGVy
ZCB3b3JrZXIgdGhyZWFkIHRoYXQgY2hlY2tzIHRoZQ0KICAqIGRpZmZlcmVudGlhbHMgb2YgcHJv
Y2Vzc29ycyB0aGF0IGhhdmUgdGhlaXIgd29ya2VyDQotLSANCjIuMjAuMQ0KDQo=
