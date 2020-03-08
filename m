From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v2 11/12] task_isolation: kick_all_cpus_sync: don't kick
 isolated cpus
Date: Sun, 8 Mar 2020 03:56:13 +0000
Message-ID: <dfe656e79c4f19d037f788748d47b2e2802988b2.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:18590 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgCHD4z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Mar 2020 22:56:55 -0500
In-Reply-To: <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Content-Language: en-US
Content-ID: <0CF0F9A752365D499FA079925E0AB4FC@namprd18.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpNYWtlIHN1cmUgdGhhdCBr
aWNrX2FsbF9jcHVzX3N5bmMoKSBkb2VzIG5vdCBjYWxsIENQVXMgdGhhdCBhcmUgcnVubmluZw0K
aXNvbGF0ZWQgdGFza3MuDQoNClNpZ25lZC1vZmYtYnk6IFl1cmkgTm9yb3YgPHlub3JvdkBtYXJ2
ZWxsLmNvbT4NClthYmVsaXRzQG1hcnZlbGwuY29tOiB1c2Ugc2FmZSB0YXNrX2lzb2xhdGlvbl9j
cHVtYXNrKCkgaW1wbGVtZW50YXRpb25dDQpTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbGl0cyA8YWJl
bGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGtlcm5lbC9zbXAuYyB8IDE0ICsrKysrKysrKysrKyst
DQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zbXAuYyBiL2tlcm5lbC9zbXAuYw0KaW5kZXggM2E4YmNiZGQ0Y2U2
Li5kOWI0YjJmZWRmZWQgMTAwNjQ0DQotLS0gYS9rZXJuZWwvc21wLmMNCisrKyBiL2tlcm5lbC9z
bXAuYw0KQEAgLTczMSw5ICs3MzEsMjEgQEAgc3RhdGljIHZvaWQgZG9fbm90aGluZyh2b2lkICp1
bnVzZWQpDQogICovDQogdm9pZCBraWNrX2FsbF9jcHVzX3N5bmModm9pZCkNCiB7DQorCXN0cnVj
dCBjcHVtYXNrIG1hc2s7DQorDQogCS8qIE1ha2Ugc3VyZSB0aGUgY2hhbmdlIGlzIHZpc2libGUg
YmVmb3JlIHdlIGtpY2sgdGhlIGNwdXMgKi8NCiAJc21wX21iKCk7DQotCXNtcF9jYWxsX2Z1bmN0
aW9uKGRvX25vdGhpbmcsIE5VTEwsIDEpOw0KKw0KKwlwcmVlbXB0X2Rpc2FibGUoKTsNCisjaWZk
ZWYgQ09ORklHX1RBU0tfSVNPTEFUSU9ODQorCWNwdW1hc2tfY2xlYXIoJm1hc2spOw0KKwl0YXNr
X2lzb2xhdGlvbl9jcHVtYXNrKCZtYXNrKTsNCisJY3B1bWFza19jb21wbGVtZW50KCZtYXNrLCAm
bWFzayk7DQorI2Vsc2UNCisJY3B1bWFza19zZXRhbGwoJm1hc2spOw0KKyNlbmRpZg0KKwlzbXBf
Y2FsbF9mdW5jdGlvbl9tYW55KCZtYXNrLCBkb19ub3RoaW5nLCBOVUxMLCAxKTsNCisJcHJlZW1w
dF9lbmFibGUoKTsNCiB9DQogRVhQT1JUX1NZTUJPTF9HUEwoa2lja19hbGxfY3B1c19zeW5jKTsN
CiANCi0tIA0KMi4yMC4xDQoNCg==
