From: Alex Belits <abelits@marvell.com>
Subject: Re: [EXT] Re: [PATCH v4 00/13] "Task_isolation" mode
Date: Thu, 23 Jul 2020 15:41:46 +0000
Message-ID: <670609a91be23ebb4f179850601439fbed844479.camel@marvell.com>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
         <87imeextf3.fsf@nanos.tec.linutronix.de>
         <20200723142902.GT5523@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37994 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728306AbgGWPm3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 11:42:29 -0400
In-Reply-To: <20200723142902.GT5523@worktop.programming.kicks-ass.net>
Content-Language: en-US
Content-ID: <338E0FC799BFDC42AFD75D748BE872A0@namprd18.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org" <peterz@infradead.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "frederic@kernel.org" <frederic@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

DQpPbiBUaHUsIDIwMjAtMDctMjMgYXQgMTY6MjkgKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3Rl
Og0KPiAuDQo+IA0KPiBUaGlzLi4gYXMgcHJlc2VudGVkIGl0IGlzIGFuIGFic29sdXRlbHkgdW5y
ZXZpZXdhYmxlIHBpbGUgb2YganVuay4gSXQNCj4gcHJlc2VudHMgY29kZSB3aXRvdXQgYW55IGNv
aGVyZW50IHByb2JsZW0gZGVzY3JpcHRpb24gYW5kIGFuYWx5c2lzLg0KPiBBbmQNCj4gdGhlIHBh
dGNoZXMgYXJlIG5vdCBzcGxpdCBzYW5lbHkgZWl0aGVyLg0KDQpUaGVyZSBpcyBhIG1vcmUgY29t
cGxldGUgYW5kIHNsaWdodGx5IG91dGRhdGVkIGRlc2NyaXB0aW9uIGluIHRoZQ0KcHJldmlvdXMg
dmVyc2lvbiBvZiB0aGUgcGF0Y2ggYXQgDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzA3
YzI1YzI0NmM1NTAxMjk4MWVjMDI5NmVlZTIzZTY4YzcxOTMzM2EuY2FtZWxAbWFydmVsbC5jb20v
DQogLg0KDQpJdCBhbGxvd3MgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIHRvIHRha2UgYSBDUFUgY29y
ZSBmb3IgaXRzZWxmIGFuZCBydW4NCmNvbXBsZXRlbHkgaXNvbGF0ZWQsIHdpdGggbm8gZGlzdHVy
YmFuY2VzLiBUaGVyZSBpcyB3b3JrIGluIHByb2dyZXNzDQp0aGF0IGFsc28gZGlzYWJsZXMgYW5k
IHJlLWVuYWJsZXMgVExCIGZsdXNoZXMsIGFuZCBkZXBlbmRpbmcgb24gQ1BVIGl0DQptYXkgYmUg
cG9zc2libGUgdG8gYWxzbyBwcmUtYWxsb2NhdGUgY2FjaGUsIHNvIGl0IHdvdWxkIG5vdCBiZSBh
ZmZlY3RlZA0KYnkgdGhlIHJlc3Qgb2YgdGhlIHN5c3RlbS4gRXZlbnRzIHRoYXQgY2F1c2UgaW50
ZXJhY3Rpb24gd2l0aCBpc29sYXRlZA0KdGFzaywgY2F1c2UgaXNvbGF0aW9uIGJyZWFraW5nLCB0
dXJuaW5nIHRoZSB0YXNrIGludG8gYSByZWd1bGFyDQp1c2Vyc3BhY2UgdGFzayB0aGF0IGNhbiBj
b250aW51ZSBydW5uaW5nIG5vcm1hbGx5IGFuZCBlbnRlciBpc29sYXRlZA0Kc3RhdGUgYWdhaW4g
aWYgbmVjZXNzYXJ5Lg0KDQpUbyBtYWtlIHRoaXMgZmVhdHVyZSBzdWl0YWJsZSBmb3IgYW55IHBy
YWN0aWNhbCB1c2UsIG1hbnkgbWVjaGFuaXNtcw0KdGhhdCBub3JtYWxseSB3b3VsZCBjYXVzZSBl
dmVudHMgb24gYSBDUFUsIHNob3VsZCBleGNsdWRlIENQVSBjb3JlcyBpbg0KdGhpcyBzdGF0ZSwg
YW5kIHN5bmNocm9uaXphdGlvbiBzaG91bGQgaGFwcGVuIGxhdGVyLCBhdCB0aGUgdGltZSBvZg0K
aXNvbGF0aW9uIGJyZWFraW5nLg0KDQpUaGVyZSBhcmUgdGhyZWUgYXJjaGl0ZWN0dXJlcyBzdXBw
b3J0ZWQsIHg4NiwgYXJtIGFuZCBhcm02NCwgYW5kIGl0DQpzaG91bGQgYmUgcG9zc2libGUgdG8g
ZXh0ZW5kIGl0IHRvIG90aGVycy4gVW5mb3J0dW5hdGVseSBrZXJuZWwgZW50cnkNCnByb2NlZHVy
ZXMgYXJlIG5laXRoZXIgdW5pZmllZCwgbm9yIHN0cmFpZ2h0Zm9yd2FyZCwgc28gaW50cm9kdWNp
bmcgbmV3DQpmZWF0dXJlIHRvIHRoZW0gY2F1c2VzIGFuIGFwcGVhcmFuY2Ugb2YgYSBtZXNzLg0K
DQotLSANCkFsZXgNCg==
