From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/3] arm64: system call table generation for
	asm-generic
Date: Sat, 19 Jan 2019 23:56:52 +0000
Message-ID: <20190119235650.GC26876@brain-police>
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
Content-Disposition: inline
In-Reply-To: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Philippe Ombredanne <pombredanne@nexb.com>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, marcin.juszkiewicz@linaro.org, Russell King <rmk+kernel@armlinux.org.uk>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, deepa.kernel@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCBKYW4gMDMsIDIwMTkgYXQgMDk6MTA6MjJQTSArMDUzMCwgRmlyb3ogS2hhbiB3cm90
ZToKPiBUaGlzIHdpbGwgYmUgYW4gYXV0b21hdGVkIHNjcmlwdHMgdG8gcHJvdmlkZSBlYXN5IHN1
cHBvcnQKPiBmb3IgYWRkL21vZGlmeS9kZWxldGUgdGhlIHN5c3RlbSBjYWxsIGVudHJ5IGJ5IGFk
ZCBpbiAKPiByZXNwZWN0aXZlICoudGJsIGZpbGUuCj4gCj4gU3lzdGVtIGNhbGwgdGFibGUgZ2Vu
ZXJhdGlvbiBzdXBwb3J0IGZvciBhc20tZ2VuZXJpYyBpcwo+IHByb3ZpZGUgZm9yIGFybTY0IGFy
Y2hpdGVjdHVyZSB3aGljaCB3aWxsIHVzZSB0aGUgY29tbW9uCj4gc2NyaXB0cyByZXNpZGVzIGlu
IHNjcmlwdHMgZGlyZWN0b3J5IGFuZCB1c2Ugc3lzY2FsbC50YmwKPiBzeXNjYWxsX2FybTMyLnRi
bCBmaWxlcyBhcyBpbnB1dHMuIFRoaXMgaW1wbGVtZW50YXRpb24gCj4gd2lsbCByZXBsYWNlIGFz
bS1nZW5lcmljL3VuaXN0ZC5oLgo+IAo+IFRoaXMgcGF0Y2ggZGVwZW5kcyBvbjoKPiAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNTQ2NDM5MzMxLTE4NjQ2LTEtZ2l0LXNlbmQtZW1haWwt
Zmlyb3oua2hhbkBsaW5hcm8ub3JnLwo+ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE1
NDY1MjA2ODEtMjQ0NTMtMS1naXQtc2VuZC1lbWFpbC1maXJvei5raGFuQGxpbmFyby5vcmcvCgpJ
J20gaGF2aW5nIGEgaGFyZCB0aW1lIHVuZGVyc3RhbmRpbmcgd2hhdCB0aGUgYmVuZWZpdCBvZiB0
aGlzIHNlcmllcyBpcywKZ2l2ZW4gdGhhdCB3ZSBvbmx5IHN1cHBvcnQgRUFCSSBjb21wYXQgdGFz
a3MuIFdoZW4gYWRkaW5nIGEgbmV3IGNvbXBhdApzeXN0ZW0gY2FsbCwgeW91IGNhbid0IGp1c3Qg
YmxpbmRseSBob29rIGl0IHVwIHdpdGhvdXQgY2hlY2tpbmcgd2hldGhlciBpdApuZWVkcyBhIHdy
YXBwZXIgdG8gZGVhbCB3aXRoIGFueSB0eXBlIGNvbnZlcnNpb24gZXRjLCBzbyByZWFsbHkgd2Un
cmUganVzdApyZXBsYWNpbmcgb25lIHRhYmxlIHdpdGggYW5vdGhlciBhcyBmYXIgYXMgSSBjYW4g
dGVsbC4gV2hhdCBhbSBJIG1pc3Npbmc/CgpJIGFsc28gcmVhbGx5IGRvbid0IHRoaW5rIHdlIHNo
b3VsZCBiZSBnZW5lcmF0aW5nIHRoZSAzMi1iaXQgVUFQSSBoZWFkZXJzCmZyb20gdGhlIDY0LWJp
dCBjb21wYXQgc3lzdGVtIGNhbGwgc3VwcG9ydCAoaWYgdGhhdCdzIHdoYXQgeW91J3JlIHRyeWlu
ZyB0bwpkbyAtLSBtYWtlIGhlYWRlcnNfY2hlY2sgZmFpbHMgd2l0aCB5b3VyIHBhdGNoZXMgYXBw
bGllZCkuIGFyY2gvYXJtLyBpcyB0aGUKY2Fub25pY2FsIHBsYWNlIGZvciB0aGUgMzItYml0IFVB
UEksIGFuZCB3ZSdyZSBqdXN0IGltcGxlbWVudGluZyB0aGF0LgoKV2lsbApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAzOCBtYWlsaW5nIGxpc3QKWTIw
MzhAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0
aW5mby95MjAzOAo=
