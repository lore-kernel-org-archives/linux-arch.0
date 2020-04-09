From: Alex Belits <abelits@marvell.com>
Subject: [PATCH v3 09/13] task_isolation: don't interrupt CPUs with
 tick_nohz_full_kick_cpu()
Date: Thu, 9 Apr 2020 15:25:37 +0000
Message-ID: <eb1f4ecbda4aa49a23bc459a37b8f160828f2919.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
         <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
Content-Language: en-US
Content-ID: <75515075B8A98845BEB0DA9CF39FEF36@namprd18.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: Prasun Kapoor <pkapoor@marvell.com>, "mingo@kernel.org" <mingo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpGb3Igbm9oel9mdWxsIENQ
VXMgdGhlIGRlc2lyYWJsZSBiZWhhdmlvciBpcyB0byByZWNlaXZlIGludGVycnVwdHMNCmdlbmVy
YXRlZCBieSB0aWNrX25vaHpfZnVsbF9raWNrX2NwdSgpLiBCdXQgZm9yIGhhcmQgaXNvbGF0aW9u
IGl0J3MNCm9idmlvdXNseSBub3QgZGVzaXJhYmxlIGJlY2F1c2UgaXQgYnJlYWtzIGlzb2xhdGlv
bi4NCg0KVGhpcyBwYXRjaCBhZGRzIGNoZWNrIGZvciBpdC4NCg0KU2lnbmVkLW9mZi1ieTogWXVy
aSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KW2FiZWxpdHNAbWFydmVsbC5jb206IHVwZGF0
ZWQsIG9ubHkgZXhjbHVkZSBDUFVzIHJ1bm5pbmcgaXNvbGF0ZWQgdGFza3NdDQpTaWduZWQtb2Zm
LWJ5OiBBbGV4IEJlbGl0cyA8YWJlbGl0c0BtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGtlcm5lbC90aW1l
L3RpY2stc2NoZWQuYyB8IDQgKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYyBi
L2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYw0KaW5kZXggMWQ0ZGVjOWQzZWU3Li44NDg4YzI4MjVh
NDUgMTAwNjQ0DQotLS0gYS9rZXJuZWwvdGltZS90aWNrLXNjaGVkLmMNCisrKyBiL2tlcm5lbC90
aW1lL3RpY2stc2NoZWQuYw0KQEAgLTIwLDYgKzIwLDcgQEANCiAjaW5jbHVkZSA8bGludXgvc2No
ZWQvY2xvY2suaD4NCiAjaW5jbHVkZSA8bGludXgvc2NoZWQvc3RhdC5oPg0KICNpbmNsdWRlIDxs
aW51eC9zY2hlZC9ub2h6Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2lzb2xhdGlvbi5oPg0KICNpbmNs
dWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvaXJxX3dvcmsuaD4NCiAjaW5j
bHVkZSA8bGludXgvcG9zaXgtdGltZXJzLmg+DQpAQCAtMjYyLDcgKzI2Myw4IEBAIHN0YXRpYyB2
b2lkIHRpY2tfbm9oel9mdWxsX2tpY2sodm9pZCkNCiAgKi8NCiB2b2lkIHRpY2tfbm9oel9mdWxs
X2tpY2tfY3B1KGludCBjcHUpDQogew0KLQlpZiAoIXRpY2tfbm9oel9mdWxsX2NwdShjcHUpKQ0K
KwlzbXBfcm1iKCk7DQorCWlmICghdGlja19ub2h6X2Z1bGxfY3B1KGNwdSkgfHwgdGFza19pc29s
YXRpb25fb25fY3B1KGNwdSkpDQogCQlyZXR1cm47DQogDQogCWlycV93b3JrX3F1ZXVlX29uKCZw
ZXJfY3B1KG5vaHpfZnVsbF9raWNrX3dvcmssIGNwdSksIGNwdSk7DQotLSANCjIuMjAuMQ0KDQo=
