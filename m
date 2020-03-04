From: Alex Belits <abelits@marvell.com>
Subject: [PATCH 11/12] task_isolation: kick_all_cpus_sync: don't kick isolated
 cpus
Date: Wed, 4 Mar 2020 16:15:24 +0000
Message-ID: <dfa5e0e9f34e6ff0ef048c81bc70496354f31300.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64310 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387969AbgCDQPt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:15:49 -0500
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Content-Language: en-US
Content-ID: <14B15D3A246B5A4FAE528257CD802742@namprd18.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpNYWtlIHN1cmUgdGhhdCBr
aWNrX2FsbF9jcHVzX3N5bmMoKSBkb2VzIG5vdCBjYWxsIENQVXMgdGhhdCBhcmUgcnVubmluZw0K
aXNvbGF0ZWQgdGFza3MuDQoNClNpZ25lZC1vZmYtYnk6IEFsZXggQmVsaXRzIDxhYmVsaXRzQG1h
cnZlbGwuY29tPg0KLS0tDQoga2VybmVsL3NtcC5jIHwgMTQgKysrKysrKysrKysrKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0
IGEva2VybmVsL3NtcC5jIGIva2VybmVsL3NtcC5jDQppbmRleCAzYThiY2JkZDRjZTYuLmQ5YjRi
MmZlZGZlZCAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zbXAuYw0KKysrIGIva2VybmVsL3NtcC5jDQpA
QCAtNzMxLDkgKzczMSwyMSBAQCBzdGF0aWMgdm9pZCBkb19ub3RoaW5nKHZvaWQgKnVudXNlZCkN
CiAgKi8NCiB2b2lkIGtpY2tfYWxsX2NwdXNfc3luYyh2b2lkKQ0KIHsNCisJc3RydWN0IGNwdW1h
c2sgbWFzazsNCisNCiAJLyogTWFrZSBzdXJlIHRoZSBjaGFuZ2UgaXMgdmlzaWJsZSBiZWZvcmUg
d2Uga2ljayB0aGUgY3B1cyAqLw0KIAlzbXBfbWIoKTsNCi0Jc21wX2NhbGxfZnVuY3Rpb24oZG9f
bm90aGluZywgTlVMTCwgMSk7DQorDQorCXByZWVtcHRfZGlzYWJsZSgpOw0KKyNpZmRlZiBDT05G
SUdfVEFTS19JU09MQVRJT04NCisJY3B1bWFza19jbGVhcigmbWFzayk7DQorCXRhc2tfaXNvbGF0
aW9uX2NwdW1hc2soJm1hc2spOw0KKwljcHVtYXNrX2NvbXBsZW1lbnQoJm1hc2ssICZtYXNrKTsN
CisjZWxzZQ0KKwljcHVtYXNrX3NldGFsbCgmbWFzayk7DQorI2VuZGlmDQorCXNtcF9jYWxsX2Z1
bmN0aW9uX21hbnkoJm1hc2ssIGRvX25vdGhpbmcsIE5VTEwsIDEpOw0KKwlwcmVlbXB0X2VuYWJs
ZSgpOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChraWNrX2FsbF9jcHVzX3N5bmMpOw0KIA0KLS0g
DQoyLjIwLjENCg0K
