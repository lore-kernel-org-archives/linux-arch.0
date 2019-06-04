From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Tue, 4 Jun 2019 19:21:13 -0400
Message-ID: <C0BC44A5-875C-4BED-A616-D380F6CF25D5@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190403160112.GK4038@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, Rahul Yadav <rahul.x.yadav@oracle.com>, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Steven Sistare <steven.sistare@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

SGksIFBldGVyLCBMb25nbWFuLCAKCj4gT24gQXByIDMsIDIwMTksIGF0IDEyOjAxIFBNLCBQZXRl
ciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+IAo+IE9uIFdlZCwgQXBy
IDAzLCAyMDE5IGF0IDExOjM5OjA5QU0gLTA0MDAsIEFsZXggS29nYW4gd3JvdGU6Cj4gCj4+Pj4g
VGhlIHBhdGNoIHRoYXQgSSBhbSBsb29raW5nIGZvciBpcyB0byBoYXZlIGEgc2VwYXJhdGUKPj4+
PiBudW1hX3F1ZXVlZF9zcGlubG9ja19zbG93cGF0aCgpIHRoYXQgY29leGlzdHMgd2l0aAo+Pj4+
IG5hdGl2ZV9xdWV1ZWRfc3BpbmxvY2tfc2xvd3BhdGgoKSBhbmQKPj4+PiBwYXJhdmlydF9xdWV1
ZWRfc3BpbmxvY2tfc2xvd3BhdGgoKS4gQXQgYm9vdCB0aW1lLCB3ZSBzZWxlY3QgdGhlIG1vc3QK
Pj4+PiBhcHByb3ByaWF0ZSBvbmUgZm9yIHRoZSBzeXN0ZW0gYXQgaGFuZC4KPj4gSXMgdGhpcyBo
b3cgdGhpcyBzZWxlY3Rpb24gd29ya3MgdG9kYXkgZm9yIHBhcmF2aXJ0Pwo+PiBJIHNlZSBhIFBB
UkFWSVJUX1NQSU5MT0NLUyBjb25maWcgb3B0aW9uLCBidXQgSUlVQyB5b3UgYXJlIHRhbGtpbmcg
YWJvdXQgYSBkaWZmZXJlbnQgbWVjaGFuaXNtIGhlcmUuCj4+IENhbiB5b3UsIHBsZWFzZSwgZWxh
Ym9yYXRlIG9yIGdpdmUgbWUgYSBsaW5rIHRvIGEgcGFnZSB0aGF0IGV4cGxhaW5zIHRoYXQ/Cj4g
Cj4gT2ggbWFuLCB5b3UgYXNrIHVzIHRvIGV4cGxhaW4gaG93IHBhcmF2aXJ0IHBhdGNoaW5nIHdv
cmtzLi4uIHRoYXQncwo+IG1hZ2ljIDotKQo+IAo+IEJhc2ljYWxseSwgdGhlIGNvbXBpbGVyIHdp
bGwgZW1pdCBhIGJ1bmNoIG9mIGluZGlyZWN0IGNhbGxzIHRvIHRoZQo+IHZhcmlvdXMgcHZfb3Bz
LiouKiBmdW5jdGlvbnMuCj4gCj4gVGhlbiwgYXQgYWx0ZXJuYXRpdmVfaW5zdHJ1Y3Rpb25zKCkg
PC0gYXBwbHlfcGFyYXZpcnQoKSBpdCB3aWxsIHJld3JpdGUKPiBhbGwgdGhlc2UgaW5kaXJlY3Qg
Y2FsbHMgdG8gZGlyZWN0IGNhbGxzIHRvIHRoZSBmdW5jdGlvbiBwb2ludGVycyB0aGF0Cj4gYXJl
IGluIHRoZSBwdl9vcHMgc3RydWN0dXJlIGF0IHRoYXQgdGltZSAoKy0gbW9yZSBtYWdpYykuClRy
eWluZyB0byByZXN1bWUgdGhpcyB3b3JrLCBJIGFtIGxvb2tpbmcgZm9yIGNvbmNyZXRlIHN0ZXBz
IHJlcXVpcmVkIHRvIGludGVncmF0ZSBDTkEgd2l0aCB0aGUgcGFyYXZpcnQgcGF0Y2hpbmcuCgpM
b29raW5nIGF0IGFsdGVybmF0aXZlX2luc3RydWN0aW9ucygpLCBJIHdvbmRlciBpZiBJIG5lZWQg
dG8gYWRkIGFub3RoZXIgY2FsbCwgc29tZXRoaW5nIGxpa2UgYXBwbHlfbnVtYSgpIHNpbWlsYXIg
dG8gYXBwbHlfcGFyYXZpcnQoKSwgYW5kIGRvIHRoZSBwYXRjaCB3b3JrIHRoZXJlLgpPciBwZXJo
YXBzIEkgc2hvdWxkIOKAnGp1c3QiIGluaXRpYWxpemUgdGhlIHB2X29wcyBzdHJ1Y3R1cmUgd2l0
aCB0aGUgY29ycmVzcG9uZGluZyBudW1hX3F1ZXVlZF9zcGlubG9ja19zbG93cGF0aCgpIGluIHBh
cmF2aXJ0LmM/CgpBbHNvLCB0aGUgcGFyYXZpcnQgY29kZSBpcyB1bmRlciBhcmNoL3g4Niwgd2hp
bGUgQ05BIGlzIGdlbmVyaWMgKG5vdCB4ODYtc3BlY2lmaWMpLgpEbyB5b3Ugc3RpbGwgd2FudCB0
byBzZWUgQ05BLXJlbGF0ZWQgcGF0Y2hpbmcgcmVzaWRpbmcgdW5kZXIgYXJjaC94ODY/CgpXZSBz
dGlsbCBuZWVkIGEgY29uZmlnIG9wdGlvbiAoc29tZXRoaW5nIGxpa2UgTlVNQV9BV0FSRV9TUElO
TE9DS1MpIHRvIGVuYWJsZSBDTkEgcGF0Y2hpbmcgdW5kZXIgdGhpcyBjb25maWcgb25seSwgY29y
cmVjdD8KClRoYW5rcyBpbiBhZHZhbmNlLArigJQgQWxleAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
