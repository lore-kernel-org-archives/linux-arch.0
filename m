From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 6/6] cputime: Introduce
	cputime_to_timespec64()/timespec64_to_cputime()
Date: Thu, 16 Jul 2015 10:22:43 +0800
Message-ID: <CAMz4kuKNVACNhwddXMyCqKGpOf_gsoHk=ZFZFuaY=8e4DCRwGw@mail.gmail.com>
References: <cover.1436511577.git.baolin.wang@linaro.org>
 <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
 <alpine.DEB.2.11.1507151226210.18576@nanos>
 <CAMz4kuLxBj+82trNVXs9qkuecrKvgdbXuJ3dfvDOCfyJwrDX9Q@mail.gmail.com>
 <alpine.DEB.2.11.1507151345060.18576@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <alpine.DEB.2.11.1507151345060.18576@nanos>
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

T24gMTUgSnVseSAyMDE1IGF0IDE5OjU1LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4gd3JvdGU6Cj4gT24gV2VkLCAxNSBKdWwgMjAxNSwgQmFvbGluIFdhbmcgd3JvdGU6Cj4K
Pj4gT24gMTUgSnVseSAyMDE1IGF0IDE4OjMxLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRy
b25peC5kZT4gd3JvdGU6Cj4+ID4gT24gV2VkLCAxNSBKdWwgMjAxNSwgQmFvbGluIFdhbmcgd3Jv
dGU6Cj4+ID4KPj4gPj4gVGhlIGNwdXRpbWVfdG9fdGltZXNwZWMoKSBhbmQgdGltZXNwZWNfdG9f
Y3B1dGltZSgpIGZ1bmN0aW9ucyBhcmUKPj4gPj4gbm90IHllYXIgMjAzOCBzYWZlIG9uIDMyYml0
IHN5c3RlbXMgZHVlIHRvIHRoYXQgdGhlIHN0cnVjdCB0aW1lcHNlYwo+PiA+PiB3aWxsIG92ZXJm
bG93IGluIDIwMzggeWVhci4KPj4gPgo+PiA+IEFuZCBob3cgaXMgdGhpcyByZWxldmFudD8gY3B1
dGltZSBpcyBub3QgYmFzZWQgb24gd2FsbCBjbG9jayB0aW1lIGF0Cj4+ID4gYWxsLiBTbyB3aGF0
IGhhcyAyMDM4IHRvIGRvIHdpdGggY3B1dGltZT8KPj4gPgo+PiA+IFdlIHdhbnQgcHJvcGVyIGV4
cGxhbmF0aW9ucyBXSFkgd2UgbmVlZCBzdWNoIGEgY2hhbmdlLgo+Pgo+PiBXaGVuIGNvbnZlcnRp
bmcgdGhlIHBvc2l4LWNwdS10aW1lcnMsIGl0IGNhbGwgdGhlCj4+IGNwdXRpbWVfdG9fdGltZXNw
ZWMoKSBmdW5jdGlvbi4gVGh1cyBpdCBuZWVkIGEgY29udmVyc2lvbiBmb3IgdGhpcwo+PiBmdW5j
dGlvbi4KPgo+IFRoZXJlIGlzIG5vIHJlcXVpcmVtZW50IHRvIGNvbnZlcnQgcG9zaXgtY3B1LXRp
bWVycyBvbiB0aGVpciBvd24uIFdlCj4gbmVlZCB0byBhZG9wdCB0aGUgcG9zaXggY3B1IHRpbWVy
cyBjb2RlIGJlY2F1c2UgaXQgc2hhcmVzIHN5c2NhbGxzCj4gd2l0aCB0aGUgb3RoZXIgcG9zaXgg
dGltZXJzLCBidXQgdGhhdCBzdGlsbCBkb2VzIG5vdCBleHBsYWluIHdoeSB3ZQo+IG5lZWQgdGhl
c2UgZnVuY3Rpb25zLgo+CgpJbiBwb3NpeC1jcHUtdGltZXJzLCBpdCBhbHNvIGRlZmluZWQgc29t
ZSAna19jbG9jayBzdHJ1Y3QnIHZhcmlhYmxlcywKYW5kIHdlIG5lZWQgdG8gY29udmVydCB0aGUg
Y2FsbGJhY2tzIG9mIHRoZSAna19jbG9jayBzdHJ1Y3QnIHdoaWNoIGFyZQpub3QgeWVhciAyMDM4
IHNhZmUgb24gMzJiaXQgc3lzdGVtcy4gU29tZSBjYWxsYmFja3Mgd2hpY2ggbmVlZCB0bwpjb252
ZXJ0IGNhbGwgdGhlIGNwdXRpbWVfdG9fdGltZXNwZWMoKSBmdW5jdGlvbiwgdGh1cyB3ZSBhbHNv
IHdhbnQgdG8KY29udmVydCB0aGUgY3B1dGltZV90b190aW1lc3BlYygpIGZ1bmN0aW9uIHRvIGEg
eWVhciAyMDM4IHNhZmUKZnVuY3Rpb24gdG8gbWFrZSBhbGwgdGhlbSByZWFkeSBmb3IgdGhlIHll
YXIgMjAzOCBpc3N1ZS4KCj4+IFlvdSBjYW4gc2VlIHRoYXQgY29udmVyc2lvbiBpbiBwYXRjaCAi
cG9zaXgtY3B1LXRpbWVyczogQ29udmVydCB0bwo+PiB5MjAzOCBzYWZlIGNhbGxiYWNrcyIgZnJv
bQo+PiBodHRwczovL2dpdC5saW5hcm8ub3JnL3Blb3BsZS9iYW9saW4ud2FuZy91cHN0cmVhbV8w
NjI3LmdpdC4KPgo+IEkgZG8gbm90IGNhcmUgYWJvdXQgeW91ciByYW5kb20gZ2l0IHRyZWUuIEkg
Y2FyZSBhYm91dCBwcm9wZXIKPiBjaGFuZ2Vsb2dzLiBZb3VyIGNoYW5nZWxvZ3MgYXJlIGp1c3Qg
YSBjb3BpZWQgYm9pbGVycGxhdGUgZnVsbCBvZgo+IGVycm9ycy4KPgo+IFRoYW5rcywKPgo+ICAg
ICAgICAgdGdseAoKCgotLSAKQmFvbGluLndhbmcKQmVzdCBSZWdhcmRzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClkyMDM4IG1haWxpbmcgbGlzdApZMjAz
OEBsaXN0cy5saW5hcm8ub3JnCmh0dHBzOi8vbGlzdHMubGluYXJvLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3kyMDM4Cg==
