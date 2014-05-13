From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 03/19] qspinlock: Add pending bit
Date: Tue, 13 May 2014 15:47:00 -0400
Message-ID: <537276B4.10209@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-4-git-send-email-Waiman.Long@hp.com>
	<20140512152208.GA12309@potion.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140512152208.GA12309@potion.brq.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: x86@kernel.org, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Paolo Bonzini <paolo.bonzini@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Chegu Vinod <chegu_vinod@hp.com>, Oleg Nesterov <oleg@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

T24gMDUvMTIvMjAxNCAxMToyMiBBTSwgUmFkaW0gS3LEjW3DocWZIHdyb3RlOgo+IDIwMTQtMDUt
MDcgMTE6MDEtMDQwMCwgV2FpbWFuIExvbmc6Cj4+IEZyb206IFBldGVyIFppamxzdHJhPHBldGVy
ekBpbmZyYWRlYWQub3JnPgo+Pgo+PiBCZWNhdXNlIHRoZSBxc3BpbmxvY2sgbmVlZHMgdG8gdG91
Y2ggYSBzZWNvbmQgY2FjaGVsaW5lOyBhZGQgYSBwZW5kaW5nCj4+IGJpdCBhbmQgYWxsb3cgYSBz
aW5nbGUgaW4td29yZCBzcGlubmVyIGJlZm9yZSB3ZSBwdW50IHRvIHRoZSBzZWNvbmQKPj4gY2Fj
aGVsaW5lLgo+IEkgdGhpbmsgdGhlcmUgaXMgYW4gdW53YW50ZWQgc2NlbmFyaW8gb24gdmlydHVh
bCBtYWNoaW5lczoKPiAxKSBWQ1BVIHNldHMgdGhlIHBlbmRpbmcgYml0IGFuZCBzdGFydCBzcGlu
bmluZy4KPiAyKSBQZW5kaW5nIFZDUFUgZ2V0cyBkZXNjaGVkdWxlZC4KPiAgICAgIC0gd2UgaGF2
ZSBQTEUgYW5kIGxvY2sgaG9sZGVyIGlzbid0IHJ1bm5pbmcgWzFdCj4gICAgICAtIHRoZSBoeXBl
cnZpc29yIHJhbmRvbWx5IHByZWVtcHRzIHVzCj4gMykgTG9jayBob2xkZXIgdW5sb2NrcyB3aGls
ZSBwZW5kaW5nIFZDUFUgaXMgd2FpdGluZyBpbiBxdWV1ZS4KPiA0KSBTdWJzZXF1ZW50IGxvY2tl
cnMgd2lsbCBzZWUgZnJlZSBsb2NrIHdpdGggc2V0IHBlbmRpbmcgYml0IGFuZCB3aWxsCj4gICAg
IGxvb3AgaW4gdHJ5bG9jaydzICdmb3IgKDs7KScKPiAgICAgIC0gdGhlIHdvcnN0LWNhc2UgaXMg
bG9jayBzdGFydmluZyBbMl0KPiAgICAgIC0gUExFIGNhbiBzYXZlIHVzIGZyb20gd2FzdGluZyB3
aG9sZSB0aW1lc2xpY2UKPgo+IFJldHJ5IHRocmVzaG9sZCBpcyB0aGUgZWFzaWVzdCBzb2x1dGlv
biwgcmVnYXJkbGVzcyBvZiBpdHMgdWdsaW5lc3MgWzRdLgoKWWVzLCB0aGF0IGNhbiBiZSBhIHJl
YWwgaXNzdWUuIFNvbWUgc29ydCBvZiByZXRyeSB0aHJlc2hvbGQsIGFzIHlvdSAKc2FpZCwgc2hv
dWxkIGJlIGFibGUgdG8gaGFuZGxlIGl0LgoKQlRXLCB0aGUgcmVsZXZhbnQgcGF0Y2ggc2hvdWxk
IGJlIDE2LzE5IHdoZXJlIHRoZSBQViBzcGlubG9jayBzdHVmZiAKc2hvdWxkIGJlIGRpc2N1c3Nl
ZC4gVGhpcyBwYXRjaCBpcyBwZXJmZWN0bHkgZmluZS4KCj4gQW5vdGhlciBtaW5vciBkZXNpZ24g
ZmxhdyBpcyB0aGF0IGZvcm1lcmx5IGZpcnN0IFZDUFUgZ2V0cyBhcHBlbmRlZCB0bwo+IHRoZSB0
YWlsIHdoZW4gaXQgZGVjaWRlcyB0byBxdWV1ZTsKPiBpcyB0aGUgcGVyZm9ybWFuY2UgZ2FpbiB3
b3J0aCBpdD8KPgo+IFRoYW5rcy4KClllcywgdGhlIHBlcmZvcm1hbmNlIGdhaW4gaXMgd29ydGgg
aXQuIFRoZSBwcmltYXJ5IGdvYWwgaXMgdG8gYmUgbm90IAp3b3JzZSB0aGFuIHRpY2tldCBzcGlu
bG9jayBpbiBsaWdodCBsb2FkIHNpdHVhdGlvbiB3aGljaCBpcyB0aGUgbW9zdCAKY29tbW9uIGNh
c2UuIFRoaXMgZmVhdHVyZSBpcyBuZWVkIHRvIGFjaGlldmUgdGhhdC4KCi1Mb25nbWFuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
