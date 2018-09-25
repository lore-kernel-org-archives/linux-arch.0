From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation
	support
Date: Tue, 25 Sep 2018 10:48:49 +1000
Message-ID: <87efdi5rm6.fsf@concordia.ellerman.id.au>
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
 <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
 <CAK8P3a2hi-Ndh7X-9r3NhBUJXQBTBFsTU==GbHesy6YD9idCJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <CAK8P3a2hi-Ndh7X-9r3NhBUJXQBTBFsTU==GbHesy6YD9idCJA@mail.gmail.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch <linux-arch@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boqun Feng <boqun.feng@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, linuxram@us.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Paul Mackerras <paulus@samba.org>, Deepa Dinamani <deepa.kernel@gmail.com>, gregkh <gregkh@linuxfoundation.org>, leitao@debian.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-arch.vger.kernel.org

QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gd3JpdGVzOgo+IE9uIFR1ZSwgU2VwIDE4LCAy
MDE4IGF0IDI6MTUgUE0gRmlyb3ogS2hhbiA8Zmlyb3oua2hhbkBsaW5hcm8ub3JnPiB3cm90ZToK
Pj4gT24gMTQgU2VwdGVtYmVyIDIwMTggYXQgMTU6MzEsIEFybmQgQmVyZ21hbm4gPGFybmRAYXJu
ZGIuZGU+IHdyb3RlOgo+PiA+IE9uIEZyaSwgU2VwIDE0LCAyMDE4IGF0IDEwOjMzIEFNIEZpcm96
IEtoYW4gPGZpcm96LmtoYW5AbGluYXJvLm9yZz4gd3JvdGU6Cj4+ID4KPj4gPj4gLS0tCj4+ID4+
ICBhcmNoL3Bvd2VycGMva2VybmVsL3N5c2NhbGxzL01ha2VmaWxlICAgICAgIHwgIDUxICsrKysK
Pj4gPj4gIGFyY2gvcG93ZXJwYy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbF8zMi50YmwgfCAzNzgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiA+PiAgYXJjaC9wb3dlcnBjL2tlcm5lbC9z
eXNjYWxscy9zeXNjYWxsXzY0LnRibCB8IDM3MiArKysrKysrKysrKysrKysrKysrKysrKysrKysK
Pj4gPj4gIGFyY2gvcG93ZXJwYy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbGhkci5zaCAgfCAgMzcg
KysrCj4+ID4+ICBhcmNoL3Bvd2VycGMva2VybmVsL3N5c2NhbGxzL3N5c2NhbGx0Ymwuc2ggIHwg
IDM4ICsrKwo+PiA+Cj4+ID4gSSB0aGluayB5b3Ugc2hvdWxkIG9ubHkgbmVlZCBhIHNpbmdsZSAu
dGJsICBpbnB1dCBmaWxlIGhlcmUuCj4+Cj4+IFllcywgd2UgY2FuIGRvIHRoYXQgd2F5IGFsc28u
QXMgSSBtZW50aW9uZWQsIGl0IHdpbGwgYWRkCj4+IG1vcmUgY29tcGxleGl0eSBpbiB0aGUgc2Ny
aXB0Lgo+Pgo+PiAgVGhlIHNjcmlwdCBoYXMgdG8gYmUgc21hcnQgZW5vdWdoIHRvIHBhcnNlIHRo
ZQo+PiAudGJsIGlmIHdlIGFkZCBtb3JlIHRoaW5nIGluIHRoZSAudGJsZSBmaWxlLiBJdCBuZWVk
IG1vcmUKPj4gbG9naWMgaW4gdGhlIHNjcmlwdHMuIFRoaXMgaXMgbm90IGNvbW1vbi4gU28gaWYg
eW91IGtlZXAKPj4gc2VwYXJhdGUgLnRibCB3ZSBjYW4gYXZvaWQgdGhpcy4KPgo+IEJ1dCBhbGwg
dGhyZWUgZXhpc3RpbmcgYXJjaGl0ZWN0dXJlcyAoeDg2LCBzMzkwIGFuZCBhcm0pIGFscmVhZHkK
PiBoYXZlIHRoZSBjYXBhYmlsaXR5IHRvIHBhcnNlIHRoZSB0YWJsZSBhbmQgZ2VuZXJhdGUgZGlm
ZmVyZW50IG91dHB1dAo+IGZyb20gdGhhdC4KClllYWgsIHdlIHdhbnQgdGhhdCBvbiBwb3dlcnBj
IHRvby4KCklmIHRoZSBzY3JpcHQgbmVlZHMgdG8gYmUgbW9yZSBjb21wbGV4IHRoYXQncyBmaW5l
LCBpZiBpdCBjYW4ndCBiZQpzaGFyZWQgYWNyb3NzIGFyY2hlcyB0aGF0J3MgZmluZSwgdGhlIG1h
aW4gdGhpbmcgZm9yIG1lIGlzIHRoYXQgd2lyaW5nCnVwIGEgc3lzY2FsbCBjYW4gYmUgZG9uZSBi
eSBhZGRpbmcgYSBzaW5nbGUgbGluZSBpbiBhIHNpbmdsZSBmaWxlLgoKY2hlZXJzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClkyMDM4IG1haWxpbmcgbGlz
dApZMjAzOEBsaXN0cy5saW5hcm8ub3JnCmh0dHBzOi8vbGlzdHMubGluYXJvLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3kyMDM4Cg==
