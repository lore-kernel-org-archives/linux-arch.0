Return-Path: <SRS0=iRyw=4Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37936 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgCHH3K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Mar 2020 03:29:10 -0400
From: Alex Belits <abelits@marvell.com>
Subject: Re: [EXT] Re: [PATCH 08/12] task_isolation: don't interrupt CPUs with
 tick_nohz_full_kick_cpu()
Date: Sun, 8 Mar 2020 07:28:22 +0000
Message-ID: <646a22fd24e8dfeb1eb3101ae7be2b88e91dbfa3.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <d7ce01e57d4a35b126e1cb96a63109eaa9781cb6.camel@marvell.com>
         <20200306160341.GE8590@lenoir>
In-Reply-To: <20200306160341.GE8590@lenoir>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD5961556E38F24FA82A8F3B47E2B2FC@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Message-ID: <20200308072822.0Pu4mYcVMs1clNjp30_uLhSF4k-Qbo-092gX7YkfZZQ@z>

T24gRnJpLCAyMDIwLTAzLTA2IGF0IDE3OjAzICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiBPbiBXZWQsIE1hciAwNCwgMjAyMCBhdCAwNDoxMjo0MFBNICswMDAwLCBBbGV4IEJl
bGl0cyB3cm90ZToNCj4gPiBGcm9tOiBZdXJpIE5vcm92IDx5bm9yb3ZAbWFydmVsbC5jb20+DQo+
ID4gDQo+ID4gRm9yIG5vaHpfZnVsbCBDUFVzIHRoZSBkZXNpcmFibGUgYmVoYXZpb3IgaXMgdG8g
cmVjZWl2ZSBpbnRlcnJ1cHRzDQo+ID4gZ2VuZXJhdGVkIGJ5IHRpY2tfbm9oel9mdWxsX2tpY2tf
Y3B1KCkuIEJ1dCBmb3IgaGFyZCBpc29sYXRpb24gaXQncw0KPiA+IG9idmlvdXNseSBub3QgZGVz
aXJhYmxlIGJlY2F1c2UgaXQgYnJlYWtzIGlzb2xhdGlvbi4NCj4gPiANCj4gPiBUaGlzIHBhdGNo
IGFkZHMgY2hlY2sgZm9yIGl0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVsaXRz
IDxhYmVsaXRzQG1hcnZlbGwuY29tPg0KPiA+IC0tLQ0KPiA+ICBrZXJuZWwvdGltZS90aWNrLXNj
aGVkLmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpY2stc2NoZWQu
YyBiL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYw0KPiA+IGluZGV4IDFkNGRlYzlkM2VlNy4uZmU0
NTAzYmExMzE2IDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYw0KPiA+
ICsrKyBiL2tlcm5lbC90aW1lL3RpY2stc2NoZWQuYw0KPiA+IEBAIC0yMCw2ICsyMCw3IEBADQo+
ID4gICNpbmNsdWRlIDxsaW51eC9zY2hlZC9jbG9jay5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
c2NoZWQvc3RhdC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc2NoZWQvbm9oei5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvaXNvbGF0aW9uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lycV93b3JrLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51
eC9wb3NpeC10aW1lcnMuaD4NCj4gPiBAQCAtMjYyLDcgKzI2Myw3IEBAIHN0YXRpYyB2b2lkIHRp
Y2tfbm9oel9mdWxsX2tpY2sodm9pZCkNCj4gPiAgICovDQo+ID4gIHZvaWQgdGlja19ub2h6X2Z1
bGxfa2lja19jcHUoaW50IGNwdSkNCj4gPiAgew0KPiA+IC0JaWYgKCF0aWNrX25vaHpfZnVsbF9j
cHUoY3B1KSkNCj4gPiArCWlmICghdGlja19ub2h6X2Z1bGxfY3B1KGNwdSkgfHwgdGFza19pc29s
YXRpb25fb25fY3B1KGNwdSkpDQo+ID4gIAkJcmV0dXJuOw0KPiANCj4gSSBmZWFyIHlvdSBjYW4n
dCBkbyB0aGF0LiBBIG5vaHogZnVsbCBDUFUgaXMga2lja2VkIGZvciBhIHJlYXNvbi4NCj4gQXMg
Zm9yIHRoZSBvdGhlciBjYXNlcywgeW91IG5lZWQgdG8gZml4IHRoZSBjYWxsZXJzLg0KPiANCj4g
SW4gdGhlIGdlbmVyYWwgY2FzZSwgcmFuZG9tbHkgaWdub3JpbmcgYW4gaW50ZXJydXB0IGlzIGEg
Y29ycmVjdG5lc3MNCj4gaXNzdWUuDQoNCk5vdCBpZ25vcmluZywganVzdCBkZWxheWluZyB1bnRp
bCB3ZSBhcmUgYmFjayBmcm9tIHVzZXJzcGFjZS4gV2Uga25vdw0KdGhhdCBldmVyeXRoaW5nIHdh
cyBkb25lIG9uIHRoaXMgQ1BVIHdoZW4gd2Ugc3VjY2Vzc2Z1bGx5IGVudGVyZWQNCnVzZXJzcGFj
ZSBpbiBpc29sYXRlZCBtb2RlIC0tIG90aGVyd2lzZSB3ZSB3b3VsZCBiZSBraWNrZWQgb3V0LiBX
ZQ0KcmVzdGFydCB0aW1lcnMgd2hlbiB3ZSBhcmUgYmFjayBpbiBrZXJuZWwgYWdhaW4gb24gY2xl
YW51cCwgc28gdGhpbmdzDQp3aWxsIGJlIGJhY2sgdG8gbm9ybWFsIGF0IHRoYXQgcG9pbnQuIEJl
dHdlZW4gdGhvc2UgbW9tZW50cyB3ZSBjYW4ganVzdA0KYXMgd2VsbCByZW1haW4gaW4gdXNlcnNw
YWNlIGFuZCBmb3JnZXQgYWJvdXQgdGhlIHRpbWVycyB1bnRpbCB3ZSBhcmUNCmJhY2sgaW4ga2Vy
bmVsLg0KDQo+IA0KPiBUaGFua3MuDQo=
