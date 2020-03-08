Return-Path: <SRS0=iRyw=4Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:55008 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726138AbgCHDyF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Mar 2020 22:54:05 -0500
From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v2 08/12] task_isolation: don't interrupt CPUs with
 tick_nohz_full_kick_cpu()
Date: Sun, 8 Mar 2020 03:53:35 +0000
Message-ID: <0b4615be96008d1031efd3ed309437c05d564019.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
In-Reply-To: <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <12BFA578C199064E880E6064C4B51C83@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Message-ID: <20200308035335.KeJC_jQoUwqxJaGl-GHGJP6kprgCRksFqQWfwkolZuM@z>

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpGb3Igbm9oel9mdWxsIENQ
VXMgdGhlIGRlc2lyYWJsZSBiZWhhdmlvciBpcyB0byByZWNlaXZlIGludGVycnVwdHMNCmdlbmVy
YXRlZCBieSB0aWNrX25vaHpfZnVsbF9raWNrX2NwdSgpLiBCdXQgZm9yIGhhcmQgaXNvbGF0aW9u
IGl0J3MNCm9idmlvdXNseSBub3QgZGVzaXJhYmxlIGJlY2F1c2UgaXQgYnJlYWtzIGlzb2xhdGlv
bi4NCg0KVGhpcyBwYXRjaCBhZGRzIGNoZWNrIGZvciBpdC4NCg0KU2lnbmVkLW9mZi1ieTogWXVy
aSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KW2FiZWxpdHNAbWFydmVsbC5jb206IHVwZGF0
ZWQsIG9ubHkgZXhjbHVkZSBDUFVzIHJ1bm5pbmcgaXNvbGF0ZWQgdGFza3NdDQpTaWduZWQtb2Zm
LWJ5OiBBbGV4IEJlbGl0cyA8YWJlbGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGtlcm5lbC90aW1l
L3RpY2stc2NoZWQuYyB8IDMgKystDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL3RpbWUvdGljay1zY2hlZC5jIGIv
a2VybmVsL3RpbWUvdGljay1zY2hlZC5jDQppbmRleCAxZDRkZWM5ZDNlZTcuLmZlNDUwM2JhMTMx
NiAxMDA2NDQNCi0tLSBhL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYw0KKysrIGIva2VybmVsL3Rp
bWUvdGljay1zY2hlZC5jDQpAQCAtMjAsNiArMjAsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9zY2hl
ZC9jbG9jay5oPg0KICNpbmNsdWRlIDxsaW51eC9zY2hlZC9zdGF0Lmg+DQogI2luY2x1ZGUgPGxp
bnV4L3NjaGVkL25vaHouaD4NCisjaW5jbHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQogI2luY2x1
ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51eC9pcnFfd29yay5oPg0KICNpbmNs
dWRlIDxsaW51eC9wb3NpeC10aW1lcnMuaD4NCkBAIC0yNjIsNyArMjYzLDcgQEAgc3RhdGljIHZv
aWQgdGlja19ub2h6X2Z1bGxfa2ljayh2b2lkKQ0KICAqLw0KIHZvaWQgdGlja19ub2h6X2Z1bGxf
a2lja19jcHUoaW50IGNwdSkNCiB7DQotCWlmICghdGlja19ub2h6X2Z1bGxfY3B1KGNwdSkpDQor
CWlmICghdGlja19ub2h6X2Z1bGxfY3B1KGNwdSkgfHwgdGFza19pc29sYXRpb25fb25fY3B1KGNw
dSkpDQogCQlyZXR1cm47DQogDQogCWlycV93b3JrX3F1ZXVlX29uKCZwZXJfY3B1KG5vaHpfZnVs
bF9raWNrX3dvcmssIGNwdSksIGNwdSk7DQotLSANCjIuMjAuMQ0KDQo=
