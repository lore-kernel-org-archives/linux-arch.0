From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [PATCH 1/6] alpha: Move __IGNORE* entries to non uapi
	header
Date: Sun, 12 Aug 2018 08:59:01 +1200
Message-ID: <20180811205901.gxbcn5vf4z36cozi@tower>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-2-git-send-email-firoz.khan@linaro.org>
 <20180811192804.GI6515@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
Content-Disposition: inline
In-Reply-To: <20180811192804.GI6515@ZenIV.linux.org.uk>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru, deepa.kernel@gmail.com, linux-alpha@vger.kernel.org, Firoz Khan <firoz.khan@linaro.org>, mattst88@gmail.com, rth@twiddle.net
List-Id: linux-arch.vger.kernel.org

T24gU2F0LCBBdWcgMTEsIDIwMTggYXQgMDg6Mjg6MDRQTSArMDEwMCwgQWwgVmlybyB3cm90ZToK
PiBPbiBNb24sIEp1bCAxNiwgMjAxOCBhdCAwMzo1Mzo1M1BNICswNTMwLCBGaXJveiBLaGFuIHdy
b3RlOgo+ID4gSXQgaXMgY29ycmVjdCB0byBrZWVwIF9fSUdOT1JFKiBlbnRyeSBpbiBub24gdWFw
aSBoZWFkZXIKPiA+IGFzbS91bmlzdGQuaCB3aGlsZSB1YXBpL2FzbS91bmlzdGQuaCBtdXN0IGhv
bGQgaW5mb3JtYXRpb24KPiA+IG9ubHkgdXNlZnVsIGZvciB1c2VyIHNwYWNlIGFwcGxpY2F0aW9u
cy4KPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FscGhhL2luY2x1ZGUvdWFwaS9hc20vdW5pc3Rk
LmggYi9hcmNoL2FscGhhL2luY2x1ZGUvdWFwaS9hc20vdW5pc3RkLmgKPiA+IGluZGV4IGUxNTNj
YTYuLjNiYjZhYzEgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2FscGhhL2luY2x1ZGUvdWFwaS9hc20v
dW5pc3RkLmgKPiA+ICsrKyBiL2FyY2gvYWxwaGEvaW5jbHVkZS91YXBpL2FzbS91bmlzdGQuaAo+
ID4gQEAgLTQ4MSw5ICs0ODEsNCBAQAo+ID4gICNkZWZpbmUgX19OUl9wd3JpdGV2MgkJCTUyMQo+
ID4gICNkZWZpbmUgX19OUl9zdGF0eAkJCTUyMgo+ID4gIAo+ID4gLS8qIEFscGhhIGRvZXNuJ3Qg
aGF2ZSBwcm90ZWN0aW9uIGtleXMuICovCj4gPiAtI2RlZmluZSBfX0lHTk9SRV9wa2V5X21wcm90
ZWN0Cj4gPiAtI2RlZmluZSBfX0lHTk9SRV9wa2V5X2FsbG9jCj4gPiAtI2RlZmluZSBfX0lHTk9S
RV9wa2V5X2ZyZWUKPiA+IC0KPiA+ICAjZW5kaWYgLyogX1VBUElfQUxQSEFfVU5JU1REX0ggKi8K
PiAKPiBIbW0uLi4gIFRoZXJlJ3MgYWxzbwo+IAo+ICNkZWZpbmUgX19JR05PUkVfYWxhcm0KPiAj
ZGVmaW5lIF9fSUdOT1JFX2NyZWF0CgpUZWxsIHlvdSB3aGF0LCBJIHdvdWxkbid0IG1pbmQgaWYg
dGhlIGZvbGxvd2luZyBvbmVzIHdlcmUgYWN0dWFsbHkKaW1wbGVtZW50ZWQgYXMgc3lzY2FsbHMg
aW4gdGhlIGtlcm5lbCBvbiBBbHBoYToKCj4gI2RlZmluZSBfX0lHTk9SRV9nZXRlZ2lkCj4gI2Rl
ZmluZSBfX0lHTk9SRV9nZXRldWlkCj4gI2RlZmluZSBfX0lHTk9SRV9nZXRnaWQKPiAjZGVmaW5l
IF9fSUdOT1JFX2dldHBpZAo+ICNkZWZpbmUgX19JR05PUkVfZ2V0cHBpZAo+ICNkZWZpbmUgX19J
R05PUkVfZ2V0dWlkCgpUaGVyZSdzIGEgZ3Jvd2luZyBudW1iZXIgb2Ygc29mdHdhcmUgcGFja2Fn
ZXMgdGhhdCBhcmUgZGVjaWRpbmcKdG8gc2lkZXNraXAgZ2xpYmMgYW5kIGNhbGwgdGhlc2Ugc3lz
Y2FsbHMgZGlyZWN0bHkuICBTdXBwb3J0aW5nCk9TRidzIEMgQUJJIGluY29tcGxpYW50IGdldHhw
aWQsIGV0Yy4sIGluIHN1Y2ggcGFja2FnZXMgaXMgbm90CmVhc3kgYW5kIHJhdGhlciBpbnRydXNp
dmUuCgpDaGVlcnMsCk1pY2hhZWwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClkyMDM4IG1haWxpbmcgbGlzdApZMjAzOEBsaXN0cy5saW5hcm8ub3JnCmh0
dHBzOi8vbGlzdHMubGluYXJvLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3kyMDM4Cg==
