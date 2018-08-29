From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Wed, 29 Aug 2018 18:33:53 +0000
Message-ID: <1535567633.4465.23.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <F67F572A3C91854BB3BC28E3C8138643@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

SGkgR3V5cywNClNpbmNlIHY0LjE5LXJjMSB3ZSBhcmUgZ2V0dGluZyBhIHNlcmlvdXMgcmVncmVz
c2lvbiBvbiBwbGF0Zm9ybXMgd2l0aCBBUkMgYXJjaGl0ZWN0dXJlLg0KVGhlIGtlcm5lbCBoYXZl
IGJlY29tZSB1bnN0YWJsZSBhbmQgc3BvbnRhbmVvdXNseSBjcmFzaGVzIG9uIExUUCB0ZXN0cyBl
eGVjdXRpb24gLyBJTyB0ZXN0cyBvcg0KZXZlbiBvbiBib290Lg0KDQpJIGRvbid0IGtub3cgZXhh
Y3RseSB3aGF0IGJyZWFrcyBidXQgYmlzZWN0IGNsZWFybHkgYXNzaWduIHRoZSBibGFtZSB0byB0
aGlzIGNvbW1pdDoNCjg0YzY1OTExMDNkYiAoImxvY2tpbmcvYXRvbWljcywgYXNtLWdlbmVyaWMv
Yml0b3BzL2xvY2suaDogUmV3cml0ZSB1c2luZyBhdG9taWNfZmV0Y2hfKigpIikNCmh0dHBzOi8v
Z2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9jb21taXQvODRjNjU5MTEwM2RiZWFmMzkzYTA5MmEz
ZmM3YjA5NTEwODI1ZjZiOQ0KDQpSZXZlcnRpbmcgdGhlIGNvbW1pdCBzb2x2ZXMgdGhpcyBwcm9i
bGVtLg0KDQpJIHRlc3RlZCB2NC4xOS1yYzEgb24gQVJNICh3YW5kYm9hcmQsIGkubXg2LCAzMmJp
dCwgcXVhcmQgY29yZSwgQVJNdjcpIHdoaWNoIHVzZXMgc2FtZQ0KZ2VuZXJpYyBiaXRvcHMgaW1w
bGVtZW50YXRpb24gYW5kIGl0IHdvcmtzIGZpbmUuDQoNCkRvIHlvdSBoYXZlIGFueSBpZGVhcyB3
aGF0IHdlbnQgd3Jvbmc/DQotLSANCiBFdWdlbml5IFBhbHRzZXY=
