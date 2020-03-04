Return-Path: <SRS0=Zkb6=4V=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16520 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgCDQNF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Mar 2020 11:13:05 -0500
From: Alex Belits <abelits@marvell.com>
Subject: [PATCH 08/12] task_isolation: don't interrupt CPUs with
 tick_nohz_full_kick_cpu()
Date: Wed, 4 Mar 2020 16:12:40 +0000
Message-ID: <d7ce01e57d4a35b126e1cb96a63109eaa9781cb6.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
In-Reply-To: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8565AD33C6E2A4469EBC5A691FE0CC5A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20200304161240.gs2e_jOYcM7CezfDHIlQoZjgWBAvqWkDN78M8LzE-Bk@z>

RnJvbTogWXVyaSBOb3JvdiA8eW5vcm92QG1hcnZlbGwuY29tPg0KDQpGb3Igbm9oel9mdWxsIENQ
VXMgdGhlIGRlc2lyYWJsZSBiZWhhdmlvciBpcyB0byByZWNlaXZlIGludGVycnVwdHMNCmdlbmVy
YXRlZCBieSB0aWNrX25vaHpfZnVsbF9raWNrX2NwdSgpLiBCdXQgZm9yIGhhcmQgaXNvbGF0aW9u
IGl0J3MNCm9idmlvdXNseSBub3QgZGVzaXJhYmxlIGJlY2F1c2UgaXQgYnJlYWtzIGlzb2xhdGlv
bi4NCg0KVGhpcyBwYXRjaCBhZGRzIGNoZWNrIGZvciBpdC4NCg0KU2lnbmVkLW9mZi1ieTogQWxl
eCBCZWxpdHMgPGFiZWxpdHNAbWFydmVsbC5jb20+DQotLS0NCiBrZXJuZWwvdGltZS90aWNrLXNj
aGVkLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYyBiL2tlcm5lbC90
aW1lL3RpY2stc2NoZWQuYw0KaW5kZXggMWQ0ZGVjOWQzZWU3Li5mZTQ1MDNiYTEzMTYgMTAwNjQ0
DQotLS0gYS9rZXJuZWwvdGltZS90aWNrLXNjaGVkLmMNCisrKyBiL2tlcm5lbC90aW1lL3RpY2st
c2NoZWQuYw0KQEAgLTIwLDYgKzIwLDcgQEANCiAjaW5jbHVkZSA8bGludXgvc2NoZWQvY2xvY2su
aD4NCiAjaW5jbHVkZSA8bGludXgvc2NoZWQvc3RhdC5oPg0KICNpbmNsdWRlIDxsaW51eC9zY2hl
ZC9ub2h6Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2lzb2xhdGlvbi5oPg0KICNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvaXJxX3dvcmsuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvcG9zaXgtdGltZXJzLmg+DQpAQCAtMjYyLDcgKzI2Myw3IEBAIHN0YXRpYyB2b2lkIHRpY2tf
bm9oel9mdWxsX2tpY2sodm9pZCkNCiAgKi8NCiB2b2lkIHRpY2tfbm9oel9mdWxsX2tpY2tfY3B1
KGludCBjcHUpDQogew0KLQlpZiAoIXRpY2tfbm9oel9mdWxsX2NwdShjcHUpKQ0KKwlpZiAoIXRp
Y2tfbm9oel9mdWxsX2NwdShjcHUpIHx8IHRhc2tfaXNvbGF0aW9uX29uX2NwdShjcHUpKQ0KIAkJ
cmV0dXJuOw0KIA0KIAlpcnFfd29ya19xdWV1ZV9vbigmcGVyX2NwdShub2h6X2Z1bGxfa2lja193
b3JrLCBjcHUpLCBjcHUpOw0KLS0gDQoyLjIwLjENCg0K
