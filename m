From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] kallsyms: add support for relative offsets in kallsyms
 address table
Date: Thu, 21 Jan 2016 14:55:00 -0800
Message-ID: <CAGXu5j+yNZRC99BonVwdawqQTBDQWMKu4gw9TTnA8nOU+fqSMg@mail.gmail.com>
References: <1453373299-28181-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453396783-21591-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160121145008.746fc62fbe3fbc685869da57@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20160121145008.746fc62fbe3fbc685869da57@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Marek <mmarek@suse.cz>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "x86@kernel.org" <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCBKYW4gMjEsIDIwMTYgYXQgMjo1MCBQTSwgQW5kcmV3IE1vcnRvbgo8YWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gT24gVGh1LCAyMSBKYW4gMjAxNiAxODoxOTo0MyAr
MDEwMCBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4gd3JvdGU6Cj4K
Pj4gU2ltaWxhciB0byBob3cgcmVsYXRpdmUgZXh0YWJsZXMgYXJlIGltcGxlbWVudGVkLCBpdCBp
cyBwb3NzaWJsZSB0byBlbWl0Cj4+IHRoZSBrYWxsc3ltcyB0YWJsZSBpbiBzdWNoIGEgd2F5IHRo
YXQgaXQgY29udGFpbnMgb2Zmc2V0cyByZWxhdGl2ZSB0byBzb21lCj4+IGFuY2hvciBwb2ludCBp
biB0aGUga2VybmVsIGltYWdlIHJhdGhlciB0aGFuIGFic29sdXRlIGFkZHJlc3Nlcy4gVGhlIGJl
bmVmaXQKPj4gaXMgdGhhdCBzdWNoIHRhYmxlIGVudHJpZXMgYXJlIG5vIGxvbmdlciBzdWJqZWN0
IHRvIGR5bmFtaWMgcmVsb2NhdGlvbiB3aGVuCj4+IHRoZSBidWlsZCB0aW1lIGFuZCBydW50aW1l
IG9mZnNldHMgb2YgdGhlIGtlcm5lbCBpbWFnZSBhcmUgZGlmZmVyZW50LiBBbHNvLAo+PiBvbiA2
NC1iaXQgYXJjaGl0ZWN0dXJlcywgaXQgZXNzZW50aWFsbHkgY3V0cyB0aGUgc2l6ZSBvZiB0aGUg
YWRkcmVzcyB0YWJsZQo+PiBpbiBoYWxmIHNpbmNlIG9mZnNldHMgY2FuIHR5cGljYWxseSBiZSBl
eHByZXNzZWQgaW4gMzIgYml0cy4KPj4KPj4gU2luY2UgaXQgaXMgdXNlZnVsIGZvciBzb21lIGFy
Y2hpdGVjdHVyZXMgKGxpa2UgeDg2KSB0byByZXRhaW4gdGhlIGFiaWxpdHkKPj4gdG8gZW1pdCBh
YnNvbHV0ZSB2YWx1ZXMgYXMgd2VsbCwgdGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIGJvdGgs
IGJ5Cj4+IGVtaXR0aW5nIGFic29sdXRlIGFkZHJlc3NlcyBhcyBwb3NpdGl2ZSAzMi1iaXQgdmFs
dWVzLCBhbmQgYWRkcmVzc2VzCj4+IHJlbGF0aXZlIHRvIHRoZSBsb3dlc3QgZW5jb3VudGVyZWQg
cmVsYXRpdmUgc3ltYm9sIGFzIG5lZ2F0aXZlIHZhbHVlcywgd2hpY2gKPj4gYXJlIHN1YnRyYWN0
ZWQgZnJvbSB0aGUgcnVudGltZSBhZGRyZXNzIG9mIHRoaXMgYmFzZSBzeW1ib2wgdG8gcHJvZHVj
ZSB0aGUKPj4gYWN0dWFsIGFkZHJlc3MuCj4+Cj4+IFN1cHBvcnQgZm9yIHRoZSBhYm92ZSBpcyBl
bmFibGVkIGJ5IGRlZmF1bHQgZm9yIGFsbCBhcmNoaXRlY3R1cmVzIGV4Y2VwdAo+PiBJQS02NCwg
d2hvc2Ugc3ltYm9scyBhcmUgdG9vIGZhciBhcGFydCB0byBjYXB0dXJlIGluIHRoaXMgbWFubmVy
Lgo+Cj4gSSdtIG5vdCByZWFsbHkgdW5kZXJzdGFuZGluZyB0aGUgYmVuZWZpdHMgb2YgdGhpcy4g
IEEgc21hbGxlciBhZGRyZXNzCj4gdGFibGUgaXMgbmljZSwgYnV0IHdoeSBpcyBpdCBkZXNpcmFi
bGUgdGhhdCAic3VjaCB0YWJsZSBlbnRyaWVzIGFyZSBubwo+IGxvbmdlciBzdWJqZWN0IHRvIGR5
bmFtaWMgcmVsb2NhdGlvbiB3aGVuIHRoZSBidWlsZCB0aW1lIGFuZCBydW50aW1lCj4gb2Zmc2V0
cyBvZiB0aGUga2VybmVsIGltYWdlIGFyZSBkaWZmZXJlbnQiPwoKSUlVQywgdGhpcyBtZWFucyB0
aGF0IHRoZSByZWxvY2F0aW9uIHdvcmsgZG9uZSBhZnRlciBkZWNvbXByZXNzaW9uIG5vdwpkb2Vz
bid0IGhhdmUgdG8gZG8gcmVsb2NhdGlvbiB1cGRhdGVzIGZvciBhbGwgdGhlc2UgdmFsdWVzLCB3
aGljaAptZWFucyBhIHNtYWxsZXIgcmVsb2NhdGlvbiB0YWJsZSBhcyB3ZWxsLgoKLUtlZXMKCi0t
IApLZWVzIENvb2sKQ2hyb21lIE9TICYgQnJpbGxvIFNlY3VyaXR5Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QK
TGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xp
c3RpbmZvL2xpbnV4cHBjLWRldg==
