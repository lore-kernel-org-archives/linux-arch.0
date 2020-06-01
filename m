Return-Path: <SRS0=za/P=7O=kvack.org=owner-linux-mm@kernel.org>
From: Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: RE: [PATCH 00/10] Hi,
Date: Mon, 1 Jun 2020 04:22:22 +0000
Message-ID: 
 <BYAPR02MB5559708A5A584D05516D77EBA58A0@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
 <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
 <0f8140c1-da6f-ef04-0809-252d6de6a5d7@xilinx.com>
 <CAL_JsqLf2e3z+m14264WFcsQgiwKR35Rs9Rw0c_MgoFvKwO2Xg@mail.gmail.com>
 <5dfa98df-8955-59fd-1d65-c0a988190acb@xilinx.com>
In-Reply-To: <5dfa98df-8955-59fd-1d65-c0a988190acb@xilinx.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: owner-linux-mm@kvack.org
To: Michal Simek <michals@xilinx.com>, Rob Herring <robh@kernel.org>Michal Simek <michals@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>, git <git@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Borislav Petkov <bp@suse.de>, Cornelia Huck <cohuck@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Ungerer <gerg@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mike Rapoport <rppt@linux.ibm.com>, Mubin Usman Sayyed <MUBINUSM@xilinx.com>, Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Shubhrajyoti Datta <shubhraj@xilinx.com>, Siva Durga Prasad Paladugu <sivadur@xilinx.com>, Stefan Asserhall <stefana@xilinx.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Will Deacon <will@kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-ID: <linux-arch.vger.kernel.org>

PiBPbiAyNS4gMDIuIDIwIDE3OjMyLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiBPbiBNb24sIEZl
YiAxNywgMjAyMCBhdCA4OjI4IEFNIE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5j
b20+DQo+IHdyb3RlOg0KPiA+Pg0KPiA+PiBIaSBSb2IsDQo+ID4+DQo+ID4+IE9uIDE0LiAwMi4g
MjAgMDo0NywgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4+PiBPbiBXZWQsIEZlYiAxMiwgMjAyMCBh
dCAyOjU4IEFNIE1pY2hhbCBTaW1law0KPiA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+IHdyb3Rl
Og0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBJIGFtIHNlbmRpbmcgdGhpcyBzZXJpZXMgYXMgYmVm
b3JlIFNNUCBzdXBwb3J0Lg0KPiA+Pj4+IE1vc3Qgb2YgdGhlc2UgcGF0Y2hlcyBhcmUgY2xlYW4g
dXBzIGFuZCBzaG91bGQgYmUgZWFzeSB0byByZXZpZXcNCj4gPj4+PiB0aGVtLiBJIGV4cGVjdCB0
aGVyZSB3aWxsIGJlIG1vcmUgZGlzY3Vzc2lvbnMgYWJvdXQgU01QIHN1cHBvcnQuDQo+ID4+Pg0K
PiA+Pj4gV2hpbGUgbm90IHJlYWxseSByZWxhdGVkIHRvIGFkZGluZyBTTVAsIGFueSBjaGFuY2Ug
eW91IG9yIHNvbWVvbmUNCj4gPj4+IGNvdWxkIGxvb2sgYXQgbW92aW5nIG1pY3JvYmxhemUgUENJ
IHN1cHBvcnQgdG8gZHJpdmVycy9wY2kvPyBJDQo+ID4+PiBzdXNwZWN0IG11Y2ggb2YgdGhlIGNv
ZGUgc2hvdWxkIGRyb3Agb3V0IGFzIHdlIGhhdmUgY29tbW9uIGhlbHBlcnMNCj4gPj4+IGZvciBt
dWNoIG9mIGl0IG5vdy4gVGhhdCB3b3VsZCBsZWF2ZSBvbmx5IHBvd2VycGMgYW5kIG1pcHMgZm9y
IERUK1BDSQ0KPiBwbGF0Zm9ybXMuDQo+ID4+DQo+ID4+IGNhbiB5b3UgcGxlYXNlIHN1Z2dlc3Qg
Y2hhbmdlcyB3aGljaCBjb3VsZCBiZSBkb25lPw0KPiA+PiBJIGhhdmUgQ0MgQmhhcmF0IGFuZCBo
ZSBjb3VsZCBsb29rIGF0IGl0Lg0KPiA+DQo+ID4gTG9vayBhdCB0aGUgaG9zdCBjb250cm9sbGVy
IGRyaXZlcnMgaW4gZHJpdmVycy9wY2kvY29udHJvbGxlci8uDQo+ID4gcGNpLWhvc3Qte2dlbmVy
aWMsY29tbW9ufS5jIGlzIGEgZ29vZCB0ZW1wbGF0ZSB0byBzdGFydCB3aXRoIGFzIHRoYXQncw0K
PiA+IGEgY29udHJvbGxlciB3aXRoIHN0YW5kYXJkIGNvbmZpZyBzcGFjZSBhY2Nlc3NlcyBhbmQg
bm8gaC93IHNldHVwDQo+ID4gbmVlZGVkLiBFc3NlbnRpYWxseSB5b3UgbmVlZCB0byBjYWxsIGRl
dm1fcGNpX2FsbG9jX2hvc3RfYnJpZGdlKCksDQo+ID4gcGNpX3BhcnNlX3JlcXVlc3Rfb2ZfcGNp
X3JhbmdlcygpIGFuZCBwY2lfaG9zdF9wcm9iZSgpIHdpdGggd2hhdGV2ZXINCj4gPiBoL3cgc2V0
dXAgeW91IG5lZWQgaW4gYmV0d2VlbiB0aG9zZSBjYWxscy4NCj4gPg0KPiA+IExvb2tpbmcgYXQg
dGhlIG1pY3JvYmxhemUgUENJIGNvZGUsIGxvb2tzIGxpa2UgeW91IG1heSBuZWVkIGN1c3RvbQ0K
PiA+IGNvbmZpZyBzcGFjZSBhY2Nlc3NvcnMgd2hpY2ggaXMgcXVpdGUgY29tbW9uLiBQcm9iYWJs
eSBhbGwgdGhlDQo+ID4gcmVzb3VyY2UgYW5kIGRldmljZSBzY2FubmluZyBjYW4gYmUgcmVtb3Zl
ZC4gSWYgeW91IGxvb2sgYXQgYXJtNjQsIGFsbA0KPiA+IHRoZSBhcmNoIFBDSSBjb2RlIGlzIGp1
c3QgZm9yIEFDUEkuDQpIaSBSb2IsDQoNCkNhbiB5b3UgcGxlYXNlIGxldCB1cyBrbm93IHdoeSB3
ZSBtaWdodCBuZWVkIGN1c3RvbSBjb25maWcgc3BhY2UgYWNjZXNzb3JzID8NCldlIHRlc3RlZCBw
Y2lfZ2VuZXJpY19jb25maWdfcmVhZC93cml0ZSBhY2Nlc3NvcnMgb24gbWljcm9ibGF6ZSwgYW5k
IHdlIA0KZGlkIG5vdCBzZWUgYW55IGlzc3Vlcy4NCg0KUmVnYXJkcywNCkJoYXJhdA0KDQo=
