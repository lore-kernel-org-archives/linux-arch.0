Return-Path: <Tim.Bird@sony.com>
From: <Tim.Bird@sony.com>
Subject: RE: [RFC v1 0/6] kunit: create a centralized executor to dispatch
 all KUnit tests
Date: Tue, 28 Jan 2020 19:35:36 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com>
 <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
 <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
In-Reply-To: <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: frowand.list@gmail.com, brendanhiggins@google.com
Cc: mcgrof@kernel.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200128193536.vbGh_Q9Ql3TZwZZVXchGSN4QY1664AbUklFCyte_3js@z>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogIEZyYW5rIFJvd2FuZCBv
biBKYW51YXJ5IDI4LCAyMDIwIDExOjM3IEFNDQo+IA0KPiBPbiAxLzI4LzIwIDE6MTkgQU0sIEJy
ZW5kYW4gSGlnZ2lucyB3cm90ZToNCj4gPiBPbiBNb24sIEphbiAyNywgMjAyMCBhdCA5OjQwIEFN
IEZyYW5rIFJvd2FuZCA8ZnJvd2FuZC5saXN0QGdtYWlsLmNvbT4gd3JvdGU6DQouLi4NCj4gPiB3
ZSBjb3VsZCBhZGQgS2NvbmZpZ3MgdG8gY29udHJvbCB0aGlzLCBidXQgdGhlIGNvbXBpbGVyIG5l
dmVydGhlbGVzcw0KPiA+IGNvbXBsYWlucyBiZWNhdXNlIGl0IGRvZXNuJ3Qga25vdyB3aGF0IHBo
YXNlIEtVbml0IHJ1bnMgaW4uDQo+ID4NCj4gPiBJcyB0aGVyZSBhbnkgd2F5IHRvIHRlbGwgdGhl
IGNvbXBpbGVyIHRoYXQgaXQgaXMgb2theSBmb3Igbm9uIF9faW5pdA0KPiA+IGNvZGUgdG8gY2Fs
bCBfX2luaXQgY29kZT8gSSB3b3VsZCBwcmVmZXIgbm90IHRvIGhhdmUgYSBkdXBsaWNhdGUNCj4g
PiB2ZXJzaW9uIG9mIGFsbCB0aGUgS1VuaXQgbGlicmFyaWVzIHdpdGggYWxsIHRoZSBzeW1ib2xz
IG1hcmtlZCBfX2luaXQuDQo+IA0KPiBJJ20gbm90IHN1cmUuICBUaGUgYnVpbGQgbWVzc2FnZXMg
aGF2ZSBhbHdheXMgYmVlbiB1c2VmdWwgYW5kIHZhbGlkIGluDQo+IG15IGNvbnRleHQsIHNvIEkg
bmV2ZXIgdGhvdWdodCB0byBjb25zaWRlciB0aGF0IHBvc3NpYmlsaXR5Lg0KPiANCj4gPiBUaG91
Z2h0cz8NCg0KSSdtIG5vdCBzdXJlIHRoZXJlJ3MgYSByZXN0cmljdGlvbiBvbiBub24gX19pbml0
IGNvZGUgY2FsbGluZyBfX2luaXQNCmNvZGUuICBJbiBpbml0L21haW4uYyBhcmNoX2NhbGxfcmVz
ZXRfaW5pdCgpIGlzIGluIF9faW5pdCwgYW5kIGl0IGNhbGxzDQpyZXN0X2luaXQgd2hpY2ggaXMg
bm9uIF9faW5pdCwgd2l0aG91dCBhbnkgc3BlY2lhbCBoYW5kbGluZy4NCg0KSXMgdGhlIGNvbXBp
bGVyIGNvbXBsYWludCBtZW50aW9uZWQgYWJvdmUgcmVsYXRlZCB0byAgY2FsbGluZw0KaW50byBf
X2luaXQgY29kZSwgb3Igd2l0aCBzb21lIG90aGVyIGlzc3VlPw0KIC0tIFRpbQ0KDQo=
