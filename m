From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 6/6] cputime: Introduce
	cputime_to_timespec64()/timespec64_to_cputime()
Date: Wed, 15 Jul 2015 19:42:26 +0800
Message-ID: <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
References: <cover.1436511577.git.baolin.wang@linaro.org>
 <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
 <alpine.DEB.2.11.1507151226210.18576@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <alpine.DEB.2.11.1507151226210.18576@nanos>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, riel@redhat.com, Arnd Bergmann <arnd@arndb.de>, peterz@infradead.org, benh@kernel.crashing.org, linux390@de.ibm.com, heiko.carstens@de.ibm.com, linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, tj@kernel.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, John Stultz <john.stultz@linaro.org>, cl@linux.com, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, y2038 Mailman List <y2038@lists.linaro.org>, rth@twiddle.net
List-Id: linux-arch.vger.kernel.org

T24gMTUgSnVseSAyMDE1IGF0IDE4OjMxLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6Cj4gT24gV2VkLCAxNSBKdWwgMjAxNSwgQmFvbGluIFdhbmcgd3JvdGU6Cj4K
Pj4gVGhlIGNwdXRpbWVfdG9fdGltZXNwZWMoKSBhbmQgdGltZXNwZWNfdG9fY3B1dGltZSgpIGZ1
bmN0aW9ucyBhcmUKPj4gbm90IHllYXIgMjAzOCBzYWZlIG9uIDMyYml0IHN5c3RlbXMgZHVlIHRv
IHRoYXQgdGhlIHN0cnVjdCB0aW1lcHNlYwo+PiB3aWxsIG92ZXJmbG93IGluIDIwMzggeWVhci4K
Pgo+IEFuZCBob3cgaXMgdGhpcyByZWxldmFudD8gY3B1dGltZSBpcyBub3QgYmFzZWQgb24gd2Fs
bCBjbG9jayB0aW1lIGF0Cj4gYWxsLiBTbyB3aGF0IGhhcyAyMDM4IHRvIGRvIHdpdGggY3B1dGlt
ZT8KPgo+IFdlIHdhbnQgcHJvcGVyIGV4cGxhbmF0aW9ucyBXSFkgd2UgbmVlZCBzdWNoIGEgY2hh
bmdlLgoKV2hlbiBjb252ZXJ0aW5nIHRoZSBwb3NpeC1jcHUtdGltZXJzLCBpdCBjYWxsIHRoZQpj
cHV0aW1lX3RvX3RpbWVzcGVjKCkgZnVuY3Rpb24uIFRodXMgaXQgbmVlZCBhIGNvbnZlcnNpb24g
Zm9yIHRoaXMKZnVuY3Rpb24uCllvdSBjYW4gc2VlIHRoYXQgY29udmVyc2lvbiBpbiBwYXRjaCAi
cG9zaXgtY3B1LXRpbWVyczogQ29udmVydCB0bwp5MjAzOCBzYWZlIGNhbGxiYWNrcyIgZnJvbQpo
dHRwczovL2dpdC5saW5hcm8ub3JnL3Blb3BsZS9iYW9saW4ud2FuZy91cHN0cmVhbV8wNjI3Lmdp
dC4KQW5kIEkgYWxzbyB3aWxsIGV4cGxhaW4gdGhpcyBpbiB0aGUgY2hhbmdlbG9nLiBUaGFua3Mg
Zm9yIHlvdXIgY29tbWVudHMuCgo+Cj4gVGhhbmtzLAo+Cj4gICAgICAgICB0Z2x4Cj4KPgoKCi0t
IApCYW9saW4ud2FuZwpCZXN0IFJlZ2FyZHMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KWTIwMzggbWFpbGluZyBsaXN0ClkyMDM4QGxpc3RzLmxpbmFyby5v
cmcKaHR0cHM6Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8veTIwMzgK
