From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Date: Thu, 27 Nov 2014 17:49:25 +0100
Message-ID: <20141127174925.53e9d7a6@thinkpad-w530>
References: <20141126151729.GB9612@redhat.com>
 <20141126152334.GA9648@redhat.com>
 <20141126163207.63810fcb@thinkpad-w530>
 <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com>
 <20141126163216.GB10850@redhat.com> <547604FC.4030300@de.ibm.com>
 <20141126170447.GC11202@redhat.com> <20141127070919.GA4390@osiris>
 <20141127090301.3ddc3077@thinkpad-w530>
 <20141127120441.GB4390@osiris>
 <alpine.DEB.2.11.1411271602320.3961@nanos>
 <20141127161905.7c6220ee@thinkpad-w530>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDD6A@AcuExch.aculab.com>
 <20141127164555.4bcebfe8@thinkpad-w530>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDDD6@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9FDDD6@AcuExch.aculab.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCBbbWFpbHRvOmRhaGlAbGludXgudm5ldC5pYm0uY29t
XQo+ID4gPiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZAo+ID4gPiAuLi4KPiA+ID4gPiBBbHRob3Vn
aCBpdCBtaWdodCBub3QgYmUgb3B0aW1hbCwgYnV0IGtlZXBpbmcgYSBzZXBhcmF0ZSBjb3VudGVy
IGZvcgo+ID4gPiA+IHBhZ2VmYXVsdF9kaXNhYmxlKCkgYXMgcGFydCBvZiB0aGUgcHJlZW1wdGlv
biBjb3VudGVyIHNlZW1zIHRvIGJlIHRoZSBvbmx5Cj4gPiA+ID4gZG9hYmxlIHRoaW5nIHJpZ2h0
IG5vdy4gSSBhbSBub3Qgc3VyZSBpZiBhIGNvbXBsZXRlbHkgc2VwYXJhdGVkIGNvdW50ZXIgaXMg
ZXZlbgo+ID4gPiA+IHBvc3NpYmxlLCBpbmNyZWFzaW5nIHRoZSBzaXplIG9mIHRocmVhZF9pbmZv
Lgo+ID4gPgo+ID4gPiBXaGF0IGFib3V0IGFkZGluZyAoc2F5KSAweDEwMDAwIGZvciB0aGUgbW9y
ZSByZXN0cmljdGl2ZSB0ZXN0Pwo+ID4gPgo+ID4gPiAJRGF2aWQKPiA+ID4KPiA+IAo+ID4gWW91
IG1lYW4gYXMgcGFydCBvZiB0aGUgcHJlZW1wdCBjb3VudGVyPwo+ID4gCj4gPiBUaGUgY3VycmVu
dCBsYXlvdXQgKG9uIG15IGJyYW5jaCkgaXMKPiA+IAo+ID4gICogUFJFRU1QVF9NQVNLOiAgICAg
ICAgMHgwMDAwMDBmZgo+ID4gICogU09GVElSUV9NQVNLOiAgICAgICAgMHgwMDAwZmYwMAo+ID4g
ICogSEFSRElSUV9NQVNLOiAgICAgICAgMHgwMDBmMDAwMAo+ID4gICogICAgIE5NSV9NQVNLOiAg
ICAgICAgMHgwMDEwMDAwMAo+ID4gICogUFJFRU1QVF9BQ1RJVkU6ICAgICAgMHgwMDIwMDAwMAo+
ID4gCj4gPiBJIHdvdWxkIGhhdmUgYWRkZWQKPiA+ICAqIFBBR0VGQVVMVF9NQVNLOiAgICAgIDB4
MDNDMDAwMDAKPiAKPiBJJ20gbm90IHN1cmUgd2hlcmUgeW91J2QgbmVlZCB0byBhZGQgdGhlIGJp
dHMuCj4gCj4gSSB0aGluayB0aGUgYWJvdmUgd29ya3MgYmVjYXVzZSBkaXNhYmxpbmcgJ0hBUkRJ
UlEnIGltcGxpY2l0bHkKPiBkaXNhYmxlcyAnU09GVElSUScgYW5kICdQUkVFTVBUJyAoZXRjKSwg
c28gaWYgMjU2KyB0aHJlYWRzCj4gZGlzYWJsZSBQUkVFTVBUIGV2ZXJ5dGhpbmcgc3RpbGwgd29y
a3MuCgpBRkFJSyAyNTYrIGxldmVscyBvZiBwcmVlbXB0IHdpbGwgYnJlYWsgdGhlIHN5c3RlbSA6
KQoKVGhlcmVmb3JlIHdpdGggQ09ORklHX0RFQlVHX1BSRUVNUFQgd2UgdmVyaWZ5IHRoYXQgd2Ug
ZG9uJ3QgaGF2ZSBhbnkKb3Zlci91bmRlcmZsb3dzLgoKQnV0IHN1Y2ggYnVncyBjYW4gb25seSBi
ZSBmb3VuZCB3aXRoIENPTkZJR19ERUJVR19QUkVFTVBUIGVuYWJsZWQuCgo+IAo+IFNvIGlmIGRp
c2FibGluZyBwYWdlZmF1bHRzIGltcGxpZXMgdGhhdCBwcmUtZW1wdGlvbiBpcyBkaXNhYmxlZAo+
IChidXQgU09GVElSUSBpcyBzdGlsbCBhbGxvd2VkKSB0aGVuIHlvdSBuZWVkIHRvIGluc2VydCB5
b3VyIGJpdChzKQo+IGJldHdlZW4gMHhmZjAwIGFuZCAweDAwZmYuCj4gT1RPSCBpZiBkaXNhYmxp
bmcgcHJlLWVtcHRpb24gaW1wbGllcyB0aGF0IHBhZ2VmYXVsdHMgYXJlIGRpc2FibGVkCj4gdGhl
biB5b3UnZCBuZWVkIHRvIHVzZSB0aGUgbHNiIGFuZCBjaGFuZ2UgYWxsIHRoZSBhYm92ZSB2YWx1
ZXMuCj4gCj4gV2hpY2ggbWFrZXMgbWUgdGhpbmsgdGhhdCAnUFJFRU1QVF9BQ1RJVkUnIGlzbid0
IHJpZ2h0IGF0IGFsbC4KPiBUd28gdGhyZWFkcyBkaXNhYmxpbmcgTk1JcyAob3IgMzIgIGRpc2Fi
bGluZyBIQVJESVJRKSB3b24ndCBEVFJULgoKV2l0aCB0aHJlYWRzIHlvdSBtZWFuIGxldmVscz8g
VGhpcyBpcyBhIHBlciB0aHJlYWQgaW5mb3JtYXRpb24uCgo+IAo+IE9UT0ggSSdtIG9ubHkgZ3Vl
c3NpbmcgYXQgaG93IHRoaXMgaXMgdXNlZC4KPiAKPiAJRGF2aWQKPiAKPiAKPiAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWls
aW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxh
YnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
