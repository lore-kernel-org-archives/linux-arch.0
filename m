From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v7 07/11] pvqspinlock, x86: Allow unfair queue spinlock
	in a XEN guest
Date: Fri, 21 Mar 2014 07:00:07 -0400
Message-ID: <201403211100.s2LB0FRD028064@userz7021.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel
List-Id: linux-arch.vger.kernel.org

Ck9uIE1hciAyMCwgMjAxNCAxMTo0MCBQTSwgV2FpbWFuIExvbmcgPHdhaW1hbi5sb25nQGhwLmNv
bT4gd3JvdGU6Cj4KPiBPbiAwMy8xOS8yMDE0IDA0OjI4IFBNLCBLb25yYWQgUnplc3p1dGVrIFdp
bGsgd3JvdGU6IAo+ID4gT24gV2VkLCBNYXIgMTksIDIwMTQgYXQgMDQ6MTQ6MDVQTSAtMDQwMCwg
V2FpbWFuIExvbmcgd3JvdGU6IAo+ID4+IFRoaXMgcGF0Y2ggYWRkcyBhIFhFTiBpbml0IGZ1bmN0
aW9uIHRvIGFjdGl2YXRlIHRoZSB1bmZhaXIgcXVldWUgCj4gPj4gc3BpbmxvY2sgaW4gYSBYRU4g
Z3Vlc3Qgd2hlbiB0aGUgUEFSQVZJUlRfVU5GQUlSX0xPQ0tTIGtlcm5lbCBjb25maWcgCj4gPj4g
b3B0aW9uIGlzIHNlbGVjdGVkLiAKPiA+PiAKPiA+PiBTaWduZWQtb2ZmLWJ5OiBXYWltYW4gTG9u
ZzxXYWltYW4uTG9uZ0BocC5jb20+IAo+ID4+IC0tLSAKPiA+PsKgwqAgYXJjaC94ODYveGVuL3Nl
dHVwLmMgfMKgwqAgMTkgKysrKysrKysrKysrKysrKysrKyAKPiA+PsKgwqAgMSBmaWxlcyBjaGFu
Z2VkLCAxOSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKSAKPiA+PiAKPiA+PiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYveGVuL3NldHVwLmMgYi9hcmNoL3g4Ni94ZW4vc2V0dXAuYyAKPiA+PiBp
bmRleCAwOTgyMjMzLi42NmJiNmY1IDEwMDY0NCAKPiA+PiAtLS0gYS9hcmNoL3g4Ni94ZW4vc2V0
dXAuYyAKPiA+PiArKysgYi9hcmNoL3g4Ni94ZW4vc2V0dXAuYyAKPiA+PiBAQCAtNjI1LDMgKzYy
NSwyMiBAQCB2b2lkIF9faW5pdCB4ZW5fYXJjaF9zZXR1cCh2b2lkKSAKPiA+PsKgwqAgbnVtYV9v
ZmYgPSAxOyAKPiA+PsKgwqAgI2VuZGlmIAo+ID4+wqDCoCB9IAo+ID4+ICsgCj4gPj4gKyNpZmRl
ZiBDT05GSUdfUEFSQVZJUlRfVU5GQUlSX0xPQ0tTIAo+ID4+ICsvKiAKPiA+PiArICogRW5hYmxl
IHVuZmFpciBsb2NrIGlmIHJ1bm5pbmcgaW4gYSBYZW4gZ3Vlc3QgCj4gPj4gKyAqLyAKPiA+PiAr
c3RhdGljIF9faW5pdCBpbnQgeGVuX3VuZmFpcl9sb2Nrc19pbml0X2p1bXAodm9pZCkgCj4gPj4g
K3sgCj4gPj4gKyAvKiAKPiA+PiArICogRGlzYWJsZSB1bmZhaXIgbG9jayBpZiBub3QgcnVubmlu
ZyBpbiBhIFBWIGRvbWFpbiAKPiA+PiArICovIAo+ID4+ICsgaWYgKCF4ZW5fcHZfZG9tYWluKCkp
IAo+ID4+ICsgcmV0dXJuIDA7IAo+ID4gSSB3b3VsZCBqdXN0IG1ha2UgdGhpcyAneGVuX2RvbWFp
bicuIE5vdCBzdXJlIHdoeSB5b3UgbmVlZCAKPiA+IHRvIGhhdmUgaXQgb25seSBmb3IgUFYgd2hp
bGUgdGhlIFBWSFZNIGd1ZXN0cyBjYW4gYWxzbyB1c2UgaXQ/IAo+Cj4gVGhlIGNvbXBpbGF0aW9u
IG9mIHRoZSBzZXR1cC5jIGZpbGUgc2hvdWxkIGhhdmUgaW1wbGllZCB4ZW5fZG9tYWluIAo+IGFs
cmVhZHkgKGF0IGxlYXN0IEhWTSkuIFRoZSBjaGVjayBpcyBhZGRlZCB0byBtYWtlIHN1cmUgdGhh
dCB1bmZhaXIgbG9jayAKPiB3b24ndCBiZSBlbmFibGVkIG9uIGJhcmUgbWV0YWwuIEFzIGZvciBQ
VkhWTSwgaXMgdGhlcmUgYSB3YXkgdG8gZGV0ZWN0IAo+IGl0IGlzIHJ1bm5pbmcgYXMgc3VjaCB3
aGljaCBpcyBkaXN0aW5jdCBmcm9tIEhWTT8KClhlbl9kb21haW4oKSBzaG91bGQgY292ZXIgUFZI
Vk0gYW5kIFBWLgo+Cj4gPiBXb3VsZCBpdCBhbHNvIG1ha2Ugc2Vuc2UgdG8gdXNlIHRoZSBzYW1l
IHByaW50ayBzdGF0ZW1lbnQgCj4gPiB0aGF0IHRoZSBLVk0gaGFzPyAKPiA+IAo+Cj4gWWVzLCBJ
IGNhbiBhZGQgYSBwcmludGsgc3RhdGVtZW50IGxpa2UgS1ZNLiAKPgo+IC1Mb25nbWFuIApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
