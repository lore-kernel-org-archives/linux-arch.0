From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Do we need to disable preemption in flush_tlb_range()?
Date: Thu, 1 Mar 2018 15:13:10 +0000
Message-ID: <1519917189.13866.6.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <F63FCB7436102149B26B564179AFB4FB@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

SGkgVmluZWV0LA0KDQpKdXN0IG5vdGljZWQgdGhhdCBpbiBjb21tZW50cyBmb3Igc21wX2NhbGxf
ZnVuY3Rpb25fbWFueSgpIGl0IGlzIHNhaWQgdGhhdA0KcHJlZW1wdGlvbiBtdXN0IGJlIGRpc2Fi
bGVkIGR1cmluZyBpdHMgZXhlY3V0aW9uLiBBbmQgdGhhdCBmdW5jdGlvbiBnZXRzIGV4ZWN1dGVk
DQphbW9uZyBvdGhlciB3YXlzIGxpa2UgdGhhdDoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICBmbHVzaF90bGJfcmFuZ2UoKQ0KICAgIC0+IG9u
X2VhY2hfY3B1X21hc2soKQ0KICAgICAgICAgLT4gc21wX2NhbGxfZnVuY3Rpb25fbWFueSgpDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KSSdt
IG5vdCBzZWVpbmcgcmlnaHQgbm93IGFueSByZWFsIHByb2JsZW0gd2l0aCBjdXJyZW50IGltcGxl
bWVudGF0aW9uIGJ1dA0Kc29tZSBhcmNoaXRlY3R1cmVzIGRvIHRoYXQgdGh1cyB0aGUgcXVlc3Rp
b24uDQoNCi1BbGV4ZXk=
