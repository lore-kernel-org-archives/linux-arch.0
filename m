Return-Path: <SRS0=yGje=5Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:17022 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727919AbgDIPSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 11:18:24 -0400
From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v3 03/13] task_isolation: add instruction synchronization
 memory barrier
Date: Thu, 9 Apr 2020 15:17:40 +0000
Message-ID: <d995795c731d6ecceb36bdf1c1df3d72fefd023d.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
         <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
In-Reply-To: <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C879A473818C5842AE8227975E64E5F0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <20200409151740.cG9ygbYar_Wn76ZbZ7pC5b372BVfHecSOn9f67z11Yg@z>

U29tZSBhcmNoaXRlY3R1cmVzIGltcGxlbWVudCBtZW1vcnkgc3luY2hyb25pemF0aW9uIGluc3Ry
dWN0aW9ucyBmb3IgaW5zdHJ1Y3Rpb24gY2FjaGUuIE1ha2UgYSBzZXBhcmF0ZSBraW5kIG9mIGJh
cnJpZXIgdGhhdCBjYWxscyB0aGVtLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbGl0cyA8YWJl
bGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2JhcnJpZXIuaCAg
IHwgMiArKw0KIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vYmFycmllci5oIHwgMiArKw0KIGluY2x1
ZGUvYXNtLWdlbmVyaWMvYmFycmllci5oICAgIHwgNCArKysrDQogMyBmaWxlcyBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2JhcnJp
ZXIuaCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2JhcnJpZXIuaA0KaW5kZXggODNhZTk3YzA0OWQ5
Li42ZGVmNjJjOTU5MzcgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9iYXJyaWVy
LmgNCisrKyBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2JhcnJpZXIuaA0KQEAgLTY0LDEyICs2NCwx
NCBAQCBleHRlcm4gdm9pZCBhcm1faGVhdnlfbWIodm9pZCk7DQogI2RlZmluZSBtYigpCQlfX2Fy
bV9oZWF2eV9tYigpDQogI2RlZmluZSBybWIoKQkJZHNiKCkNCiAjZGVmaW5lIHdtYigpCQlfX2Fy
bV9oZWF2eV9tYihzdCkNCisjZGVmaW5lIGltYigpCQlpc2IoKQ0KICNkZWZpbmUgZG1hX3JtYigp
CWRtYihvc2gpDQogI2RlZmluZSBkbWFfd21iKCkJZG1iKG9zaHN0KQ0KICNlbHNlDQogI2RlZmlu
ZSBtYigpCQliYXJyaWVyKCkNCiAjZGVmaW5lIHJtYigpCQliYXJyaWVyKCkNCiAjZGVmaW5lIHdt
YigpCQliYXJyaWVyKCkNCisjZGVmaW5lIGltYigpCQliYXJyaWVyKCkNCiAjZGVmaW5lIGRtYV9y
bWIoKQliYXJyaWVyKCkNCiAjZGVmaW5lIGRtYV93bWIoKQliYXJyaWVyKCkNCiAjZW5kaWYNCmRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2JhcnJpZXIuaCBiL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20vYmFycmllci5oDQppbmRleCA3ZDljYzVlYzQ5NzEuLjEyYTdkYmQ2OGJlZCAx
MDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vYmFycmllci5oDQorKysgYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL2JhcnJpZXIuaA0KQEAgLTQ1LDYgKzQ1LDggQEANCiAjZGVmaW5l
IHJtYigpCQlkc2IobGQpDQogI2RlZmluZSB3bWIoKQkJZHNiKHN0KQ0KIA0KKyNkZWZpbmUgaW1i
KCkJCWlzYigpDQorDQogI2RlZmluZSBkbWFfcm1iKCkJZG1iKG9zaGxkKQ0KICNkZWZpbmUgZG1h
X3dtYigpCWRtYihvc2hzdCkNCiANCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL2Jh
cnJpZXIuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvYmFycmllci5oDQppbmRleCA4NWIyOGViODBi
MTEuLmQ1YTgyMmZiM2U5MiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvYmFycmll
ci5oDQorKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL2JhcnJpZXIuaA0KQEAgLTQ2LDYgKzQ2LDEw
IEBADQogI2RlZmluZSBkbWFfd21iKCkJd21iKCkNCiAjZW5kaWYNCiANCisjaWZuZGVmIGltYg0K
KyNkZWZpbmUgaW1iCQliYXJyaWVyKCkNCisjZW5kaWYNCisNCiAjaWZuZGVmIHJlYWRfYmFycmll
cl9kZXBlbmRzDQogI2RlZmluZSByZWFkX2JhcnJpZXJfZGVwZW5kcygpCQlkbyB7IH0gd2hpbGUg
KDApDQogI2VuZGlmDQotLSANCjIuMjAuMQ0KDQo=
