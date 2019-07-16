From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/5] locking/qspinlock: Refactor the qspinlock slow path
Date: Tue, 16 Jul 2019 17:58:39 +0200
Message-ID: <20190716155839.GF3402@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-3-alex.kogan@oracle.com>
 <20190716102034.GN3419@hirez.programming.kicks-ass.net>
 <9D5B6F33-6003-4CCA-BBE5-998B5A679B9C@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <9D5B6F33-6003-4CCA-BBE5-998B5A679B9C@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCBKdWwgMTYsIDIwMTkgYXQgMTA6NTM6MDJBTSAtMDQwMCwgQWxleCBLb2dhbiB3cm90
ZToKPiBPbiBKdWwgMTYsIDIwMTksIGF0IDY6MjAgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gPiAKPiA+IE9uIE1vbiwgSnVsIDE1LCAyMDE5IGF0IDAz
OjI1OjMzUE0gLTA0MDAsIEFsZXggS29nYW4gd3JvdGU6Cj4gPiAKPiA+PiArLyoKPiA+PiArICog
c2V0X2xvY2tlZF9lbXB0eV9tY3MgLSBUcnkgdG8gc2V0IHRoZSBzcGlubG9jayB2YWx1ZSB0byBf
UV9MT0NLRURfVkFMLAo+ID4+ICsgKiBhbmQgYnkgZG9pbmcgdGhhdCB1bmxvY2sgdGhlIE1DUyBs
b2NrIHdoZW4gaXRzIHdhaXRpbmcgcXVldWUgaXMgZW1wdHkKPiA+PiArICogQGxvY2s6IFBvaW50
ZXIgdG8gcXVldWVkIHNwaW5sb2NrIHN0cnVjdHVyZQo+ID4+ICsgKiBAdmFsOiBDdXJyZW50IHZh
bHVlIG9mIHRoZSBsb2NrCj4gPj4gKyAqIEBub2RlOiBQb2ludGVyIHRvIHRoZSBNQ1Mgbm9kZSBv
ZiB0aGUgbG9jayBob2xkZXIKPiA+PiArICoKPiA+PiArICogKiwqLCogLT4gMCwwLDEKPiA+PiAr
ICovCj4gPj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9vbCBfX3NldF9sb2NrZWRfZW1wdHlf
bWNzKHN0cnVjdCBxc3BpbmxvY2sgKmxvY2ssCj4gPj4gKwkJCQkJCSAgIHUzMiB2YWwsCj4gPj4g
KwkJCQkJCSAgIHN0cnVjdCBtY3Nfc3BpbmxvY2sgKm5vZGUpCj4gPj4gK3sKPiA+PiArCXJldHVy
biBhdG9taWNfdHJ5X2NtcHhjaGdfcmVsYXhlZCgmbG9jay0+dmFsLCAmdmFsLCBfUV9MT0NLRURf
VkFMKTsKPiA+PiArfQo+ID4gCj4gPiBUaGF0IG5hbWUgaXMgbm9uc2Vuc2UuIEl0IHNob3VsZCBi
ZSBzb21ldGhpbmcgbGlrZToKPiA+IAo+ID4gc3RhdGljIF9fYWx3YXlzX2lubGluZSBib29sIF9f
dHJ5X2NsZWFyX3RhaWwo4oCmKQo+IAo+IFdlIGFscmVhZHkgaGF2ZSBzZXRfbG9ja2VkKCksIHNv
IEkgd2FzIHRyeWluZyB0byBjb252ZXkgdGhlIGZhY3QgdGhhdCB3ZSBhcmUKPiBkb2luZyB0aGUg
c2FtZSBoZXJlLCBidXQgb25seSB3aGVuIHRoZSBNQ1MgY2hhaW4gaXMgZW1wdHkuCj4gCj4gSSBj
YW4gdXNlIF9fdHJ5X2NsZWFyX3RhaWwoKSBpbnN0ZWFkLgoKVGhpbmcgaXMsIHdlIGdvIGludG8g
dGhpcyBmdW5jdGlvbiB3aXRoOiAqLDAsMSBhbmQgYXJlIHRyeWluZyB0byBvYnRhaW4KMCwwLDEu
IElPVywgd2UncmUgdHJ5aW5nIHRvIGNsZWFyIHRoZSB0YWlsLCB3aGlsZSBwcmVzZXJ2aW5nIHBl
bmRpbmcgYW5kCmxvY2tlZC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
