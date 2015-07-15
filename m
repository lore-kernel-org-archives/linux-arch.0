From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/6] cputime: Introduce
 cputime_to_timespec64()/timespec64_to_cputime()
Date: Wed, 15 Jul 2015 13:55:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507151345060.18576@nanos>
References: <cover.1436511577.git.baolin.wang@linaro.org>
 <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
 <alpine.DEB.2.11.1507151226210.18576@nanos>
 <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, riel@redhat.com, Arnd Bergmann <arnd@arndb.de>, peterz@infradead.org, benh@kernel.crashing.org, linux390@de.ibm.com, heiko.carstens@de.ibm.com, linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, tj@kernel.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, John Stultz <john.stultz@linaro.org>, cl@linux.com, =?ISO-8859-15?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, y2038 Mailman List <y2038@lists.linaro.org>, rth@twiddle.net
List-Id: linux-arch.vger.kernel.org

T24gV2VkLCAxNSBKdWwgMjAxNSwgQmFvbGluIFdhbmcgd3JvdGU6Cgo+IE9uIDE1IEp1bHkgMjAx
NSBhdCAxODozMSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOgo+
ID4gT24gV2VkLCAxNSBKdWwgMjAxNSwgQmFvbGluIFdhbmcgd3JvdGU6Cj4gPgo+ID4+IFRoZSBj
cHV0aW1lX3RvX3RpbWVzcGVjKCkgYW5kIHRpbWVzcGVjX3RvX2NwdXRpbWUoKSBmdW5jdGlvbnMg
YXJlCj4gPj4gbm90IHllYXIgMjAzOCBzYWZlIG9uIDMyYml0IHN5c3RlbXMgZHVlIHRvIHRoYXQg
dGhlIHN0cnVjdCB0aW1lcHNlYwo+ID4+IHdpbGwgb3ZlcmZsb3cgaW4gMjAzOCB5ZWFyLgo+ID4K
PiA+IEFuZCBob3cgaXMgdGhpcyByZWxldmFudD8gY3B1dGltZSBpcyBub3QgYmFzZWQgb24gd2Fs
bCBjbG9jayB0aW1lIGF0Cj4gPiBhbGwuIFNvIHdoYXQgaGFzIDIwMzggdG8gZG8gd2l0aCBjcHV0
aW1lPwo+ID4KPiA+IFdlIHdhbnQgcHJvcGVyIGV4cGxhbmF0aW9ucyBXSFkgd2UgbmVlZCBzdWNo
IGEgY2hhbmdlLgo+IAo+IFdoZW4gY29udmVydGluZyB0aGUgcG9zaXgtY3B1LXRpbWVycywgaXQg
Y2FsbCB0aGUKPiBjcHV0aW1lX3RvX3RpbWVzcGVjKCkgZnVuY3Rpb24uIFRodXMgaXQgbmVlZCBh
IGNvbnZlcnNpb24gZm9yIHRoaXMKPiBmdW5jdGlvbi4KClRoZXJlIGlzIG5vIHJlcXVpcmVtZW50
IHRvIGNvbnZlcnQgcG9zaXgtY3B1LXRpbWVycyBvbiB0aGVpciBvd24uIFdlCm5lZWQgdG8gYWRv
cHQgdGhlIHBvc2l4IGNwdSB0aW1lcnMgY29kZSBiZWNhdXNlIGl0IHNoYXJlcyBzeXNjYWxscwp3
aXRoIHRoZSBvdGhlciBwb3NpeCB0aW1lcnMsIGJ1dCB0aGF0IHN0aWxsIGRvZXMgbm90IGV4cGxh
aW4gd2h5IHdlCm5lZWQgdGhlc2UgZnVuY3Rpb25zLgoKPiBZb3UgY2FuIHNlZSB0aGF0IGNvbnZl
cnNpb24gaW4gcGF0Y2ggInBvc2l4LWNwdS10aW1lcnM6IENvbnZlcnQgdG8KPiB5MjAzOCBzYWZl
IGNhbGxiYWNrcyIgZnJvbQo+IGh0dHBzOi8vZ2l0LmxpbmFyby5vcmcvcGVvcGxlL2Jhb2xpbi53
YW5nL3Vwc3RyZWFtXzA2MjcuZ2l0LgoKSSBkbyBub3QgY2FyZSBhYm91dCB5b3VyIHJhbmRvbSBn
aXQgdHJlZS4gSSBjYXJlIGFib3V0IHByb3BlcgpjaGFuZ2Vsb2dzLiBZb3VyIGNoYW5nZWxvZ3Mg
YXJlIGp1c3QgYSBjb3BpZWQgYm9pbGVycGxhdGUgZnVsbCBvZgplcnJvcnMuCgpUaGFua3MsCgoJ
dGdseApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAz
OCBtYWlsaW5nIGxpc3QKWTIwMzhAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFy
by5vcmcvbWFpbG1hbi9saXN0aW5mby95MjAzOAo=
