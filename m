From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Wed, 17 Jul 2019 10:52:05 -0400
Message-ID: <57614CAF-AF4C-4814-A628-2D30B399C117@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716155022.GR3419@hirez.programming.kicks-ass.net>
 <193BBB31-F376-451F-BDE1-D4807140EB51@oracle.com>
 <20190716184724.GH3402@hirez.programming.kicks-ass.net>
 <20190717083944.GR3463@hirez.programming.kicks-ass.net>
 <20190717085900.GS3463@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190717085900.GS3463@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Cj4gT24gSnVsIDE3LCAyMDE5LCBhdCA0OjU5IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+IAo+IE9uIFdlZCwgSnVsIDE3LCAyMDE5IGF0IDEwOjM5OjQ0
QU0gKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOgo+PiBPbiBUdWUsIEp1bCAxNiwgMjAxOSBh
dCAwODo0NzoyNFBNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToKPiAKPj4+IE15IHByaW1h
cnkgY29uY2VybiB3YXMgcmVhZGFiaWxpdHk7IEkgZmluZCB0aGUgYWJvdmUgc3VnZ2VzdGlvbiBt
dWNoCj4+PiBtb3JlIHJlYWRhYmxlLiBNYXliZSBpdCBjYW4gYmUgd3JpdHRlbiBkaWZmZXJlbnRs
eTsgeW91J2xsIGhhdmUgdG8gcGxheQo+Pj4gYXJvdW5kIGEgYml0Lgo+PiAKPj4gc3RhdGljIHZv
aWQgY25hX3NwbGljZV90YWlsKHN0cnVjdCBjbmFfbm9kZSAqY24sIHN0cnVjdCBjbmFfbm9kZSAq
aGVhZCwgc3RydWN0IGNuYV9ub2RlICp0YWlsKQo+PiB7Cj4+IAlzdHJ1Y3QgY25hX25vZGUgKmxp
c3Q7Cj4+IAo+PiAJLyogcmVtb3ZlIFtoZWFkLHRhaWxdICovCj4+IAlXUklURV9PTkNFKGNuLT5t
Y3MubmV4dCwgdGFpbC0+bWNzLm5leHQpOwo+PiAJdGFpbC0+bWNzLm5leHQgPSBOVUxMOwo+PiAK
Pj4gCS8qIHN0aWNrIFtoZWFkLHRhaWxdIG9uIHRoZSBzZWNvbmRhcnkgbGlzdCB0YWlsICovCj4+
IAlpZiAoY24tPm1jcy5sb2NrZWQgPD0gMSkgewo+PiAJCS8qIGNyZWF0ZSBzZWNvbmRhcnkgbGlz
dCAqLwo+PiAJCWhlYWQtPnRhaWwgPSB0YWlsOwo+PiAJCWNuLT5tY3MubG9ja2VkID0gaGVhZC0+
ZW5jb2RlZF90YWlsOwo+PiAJfSBlbHNlIHsKPj4gCQkvKiBhZGQgdG8gdGFpbCAqLwo+PiAJCWxp
c3QgPSAoc3RydWN0IGNuYV9ub2RlICopZGVjb2RlX3RhaWwoY24tPm1jcy5sb2NrZWQpOwo+PiAJ
CWxpc3QtPnRhaWwtPm5leHQgPSBoZWFkOwo+PiAJCWxpc3QtPnRhaWwgPSB0YWlsOwo+PiAJfQo+
PiB9Cj4+IAo+PiBzdGF0aWMgc3RydWN0IGNuYV9ub2RlICpjbmFfZmluZF9uZXh0KHN0cnVjdCBt
Y3Nfc3BpbmxvY2sgKm5vZGUpCj4+IHsKPj4gCXN0cnVjdCBjbmFfbm9kZSAqY25pLCAqY24gPSAo
c3RydWN0IGNuYV9ub2RlICopbm9kZTsKPj4gCXN0cnVjdCBjbmFfbm9kZSAqaGVhZCwgKnRhaWwg
PSBOVUxMOwo+PiAKPj4gCS8qIGZpbmQgYW55IG5leHQgbG9jayBmcm9tICdvdXInIG5vZGUgKi8K
Pj4gCWZvciAoaGVhZCA9IGNuaSA9IChzdHJ1Y3QgY25hX25vZGUgKilSRUFEX09OQ0UoY24tPm1j
cy5uZXh0KTsKPj4gCSAgICAgY25pICYmIGNuaS0+bm9kZSAhPSBjbi0+bm9kZTsKPj4gCSAgICAg
dGFpbCA9IGNuaSwgY25pID0gKHN0cnVjdCBjbmFfbm9kZSAqKVJFQURfT05DRShjbmktPm1jcy5u
ZXh0KSkKPj4gCQk7Cj4gCj4gSSB0aGluayB3ZSBjYW4gZG8gYXdheSB3aXRoIHRob3NlIFJFQURf
T05DRSgpcywgYXQgdGhpcyBwb2ludCB0aG9zZQo+IHBvaW50ZXJzIHNob3VsZCBiZSBzdGFibGUu
IEJ1dCBwbGVhc2UgZG91YmxlIGNoZWNrLgoKSSB0aGluayB3ZSBjYW4gZ2V0IHJpZCBvZiBXUklU
RV9PTkNFIGFib3ZlIGFuZCB0aGUgZmlyc3QgUkVBRF9PTkNFLCBhcyB0aGUgCuKAnGZpcnN04oCd
IG5leHQgcG9pbnRlciAoaW4gdGhlIG5vZGUgb2YgdGhlIGN1cnJlbnQgbG9jayBob2xkZXIpIGlz
IHN0YWJsZSBhdCB0aGlzCnBvaW50LCBhbmQgaXMgbm90IHJlYWQgLyB3cml0dGVuIGNvbmN1cnJl
bnRseS4gV2UgZG8gbmVlZCB0aGUgc2Vjb25kIFJFQURfT05DRQphcyB3ZSB0cmF2ZXJzZSB0aGUg
bGlzdCBhbmQgY2FuIGNvbWUgYWNyb3NzIGEgbmV4dCBwb2ludGVyIGJlaW5nIGNoYW5nZWQuCgri
gJQgQWxleAoKPiAKPj4gCS8qIHdoZW4gZm91bmQsIHNwbGljZSBhbnkgc2tpcHBlZCBsb2NrcyBv
bnRvIHRoZSBzZWNvbmRhcnkgbGlzdCAqLwo+PiAJaWYgKGNuaSAmJiB0YWlsKQo+PiAJCWNuYV9z
cGxpY2VfdGFpbChjbiwgaGVhZCwgdGFpbCk7Cj4+IAo+PiAJcmV0dXJuIGNuaTsKPj4gfQo+PiAK
Pj4gSG93J3MgdGhhdD8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
