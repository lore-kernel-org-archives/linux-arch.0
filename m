From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Tue, 16 Jul 2019 10:30:28 -0400
Message-ID: <FDD00A3A-6938-40DE-B464-A56C641B4634@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <20190716110518.GQ3419@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190716110518.GQ3419@hirez.programming.kicks-ass.net>
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

Cj4gT24gSnVsIDE2LCAyMDE5LCBhdCA3OjA1IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+IAo+IE9uIE1vbiwgSnVsIDE1LCAyMDE5IGF0IDAzOjI1OjM0
UE0gLTA0MDAsIEFsZXggS29nYW4gd3JvdGU6Cj4+ICsvKioKPj4gKyAqIGZpbmRfc3VjY2Vzc29y
IC0gU2NhbiB0aGUgbWFpbiB3YWl0aW5nIHF1ZXVlIGxvb2tpbmcgZm9yIHRoZSBmaXJzdAo+PiAr
ICogdGhyZWFkIHJ1bm5pbmcgb24gdGhlIHNhbWUgbm9kZSBhcyB0aGUgbG9jayBob2xkZXIuIElm
IGZvdW5kIChjYWxsIGl0Cj4+ICsgKiB0aHJlYWQgVCksIG1vdmUgYWxsIHRocmVhZHMgaW4gdGhl
IG1haW4gcXVldWUgYmV0d2VlbiB0aGUgbG9jayBob2xkZXIKPj4gKyAqIGFuZCBUIHRvIHRoZSBl
bmQgb2YgdGhlIHNlY29uZGFyeSBxdWV1ZSBhbmQgcmV0dXJuIFQ7IG90aGVyd2lzZSwgcmV0dXJu
IE5VTEwuCj4+ICsgKi8KPj4gK3N0YXRpYyBzdHJ1Y3QgY25hX25vZGUgKmZpbmRfc3VjY2Vzc29y
KHN0cnVjdCBtY3Nfc3BpbmxvY2sgKm1lKQo+IAo+IEVpdGhlciBkb24ndCB1c2UgYSBrZXJuZWwg
ZG9jIGNvbW1lbnQsIGJ1dCBpZiB5b3UgbXVzdCwgeW91IGhhdmUgdG8KPiBzdGljayB0byB0aGVp
ciBmb3JtYXQsIG90aGVyd2lzZSB3ZSdsbCBnZXQgZW5kbGVzcyBzdHVwaWQgcGF0Y2hlcyBmaXhp
bmcKPiB1cCB0aGUgc3R1cGlkIGNvbW1lbnQuCldpbGwgZml4IHRoYXQuCgpUaGFua3MsCuKAlCBB
bGV4CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
