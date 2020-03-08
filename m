From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v2 02/12] task_isolation: vmstat: add vmstat_idle function
Date: Sun, 8 Mar 2020 03:46:07 +0000
Message-ID: <3443bdf4ff557331c39a99b133defee56452be48.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24666 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgCHDqx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Mar 2020 22:46:53 -0500
In-Reply-To: <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Content-Language: en-US
Content-ID: <31B867DD531EED43ABA359B8014CD8B7@namprd18.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>

RnJvbTogQ2hyaXMgTWV0Y2FsZiA8Y21ldGNhbGZAbWVsbGFub3guY29tPg0KDQpUaGlzIGZ1bmN0
aW9uIGNoZWNrcyB0byBzZWUgaWYgYSB2bXN0YXQgd29ya2VyIGlzIG5vdCBydW5uaW5nLA0KYW5k
IHRoZSB2bXN0YXQgZGlmZnMgZG9uJ3QgcmVxdWlyZSBhbiB1cGRhdGUuICBUaGUgZnVuY3Rpb24g
aXMNCmNhbGxlZCBmcm9tIHRoZSB0YXNrLWlzb2xhdGlvbiBjb2RlIHRvIHNlZSBpZiB3ZSBuZWVk
IHRvDQphY3R1YWxseSBkbyBzb21lIHdvcmsgdG8gcXVpZXQgdm1zdGF0Lg0KDQpTaWduZWQtb2Zm
LWJ5OiBDaHJpcyBNZXRjYWxmIDxjbWV0Y2FsZkBtZWxsYW5veC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBBbGV4IEJlbGl0cyA8YWJlbGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGluY2x1ZGUvbGludXgv
dm1zdGF0LmggfCAgMiArKw0KIG1tL3Ztc3RhdC5jICAgICAgICAgICAgfCAxMCArKysrKysrKysr
DQogMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3Ztc3RhdC5oIGIvaW5jbHVkZS9saW51eC92bXN0YXQuaA0KaW5kZXggMmJjNWU4
NWYyNTE0Li42NmQ5YWUzMmNmMDcgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3Ztc3RhdC5o
DQorKysgYi9pbmNsdWRlL2xpbnV4L3Ztc3RhdC5oDQpAQCAtMjcxLDYgKzI3MSw3IEBAIGV4dGVy
biB2b2lkIF9fZGVjX25vZGVfc3RhdGUoc3RydWN0IHBnbGlzdF9kYXRhICosDQplbnVtIG5vZGVf
c3RhdF9pdGVtKTsNCiANCiB2b2lkIHF1aWV0X3Ztc3RhdCh2b2lkKTsNCiB2b2lkIHF1aWV0X3Zt
c3RhdF9zeW5jKHZvaWQpOw0KK2Jvb2wgdm1zdGF0X2lkbGUodm9pZCk7DQogdm9pZCBjcHVfdm1f
c3RhdHNfZm9sZChpbnQgY3B1KTsNCiB2b2lkIHJlZnJlc2hfem9uZV9zdGF0X3RocmVzaG9sZHMo
dm9pZCk7DQogDQpAQCAtMzc0LDYgKzM3NSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZA0KcmVmcmVz
aF96b25lX3N0YXRfdGhyZXNob2xkcyh2b2lkKSB7IH0NCiBzdGF0aWMgaW5saW5lIHZvaWQgY3B1
X3ZtX3N0YXRzX2ZvbGQoaW50IGNwdSkgeyB9DQogc3RhdGljIGlubGluZSB2b2lkIHF1aWV0X3Zt
c3RhdCh2b2lkKSB7IH0NCiBzdGF0aWMgaW5saW5lIHZvaWQgcXVpZXRfdm1zdGF0X3N5bmModm9p
ZCkgeyB9DQorc3RhdGljIGlubGluZSBib29sIHZtc3RhdF9pZGxlKHZvaWQpIHsgcmV0dXJuIHRy
dWU7IH0NCiANCiBzdGF0aWMgaW5saW5lIHZvaWQgZHJhaW5fem9uZXN0YXQoc3RydWN0IHpvbmUg
KnpvbmUsDQogCQkJc3RydWN0IHBlcl9jcHVfcGFnZXNldCAqcHNldCkgeyB9DQpkaWZmIC0tZ2l0
IGEvbW0vdm1zdGF0LmMgYi9tbS92bXN0YXQuYw0KaW5kZXggMWZhMGIyZDA0YWZhLi41YzRhZWM2
NTEwNjIgMTAwNjQ0DQotLS0gYS9tbS92bXN0YXQuYw0KKysrIGIvbW0vdm1zdGF0LmMNCkBAIC0x
ODc5LDYgKzE4NzksMTYgQEAgdm9pZCBxdWlldF92bXN0YXRfc3luYyh2b2lkKQ0KIAlyZWZyZXNo
X2NwdV92bV9zdGF0cyhmYWxzZSk7DQogfQ0KIA0KKy8qDQorICogUmVwb3J0IG9uIHdoZXRoZXIg
dm1zdGF0IHByb2Nlc3NpbmcgaXMgcXVpZXNjZWQgb24gdGhlIGNvcmUNCmN1cnJlbnRseToNCisg
KiBubyB2bXN0YXQgd29ya2VyIHJ1bm5pbmcgYW5kIG5vIHZtc3RhdCB1cGRhdGVzIHRvIHBlcmZv
cm0uDQorICovDQorYm9vbCB2bXN0YXRfaWRsZSh2b2lkKQ0KK3sNCisJcmV0dXJuICFkZWxheWVk
X3dvcmtfcGVuZGluZyh0aGlzX2NwdV9wdHIoJnZtc3RhdF93b3JrKSkgJiYNCisJCSFuZWVkX3Vw
ZGF0ZShzbXBfcHJvY2Vzc29yX2lkKCkpOw0KK30NCisNCiAvKg0KICAqIFNoZXBoZXJkIHdvcmtl
ciB0aHJlYWQgdGhhdCBjaGVja3MgdGhlDQogICogZGlmZmVyZW50aWFscyBvZiBwcm9jZXNzb3Jz
IHRoYXQgaGF2ZSB0aGVpciB3b3JrZXINCi0tIA0KMi4yMC4xDQoNCg==
