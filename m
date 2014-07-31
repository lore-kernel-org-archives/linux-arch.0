From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v4 6/6] clk: Add floor and ceiling constraints to clock
 rates
Date: Thu, 31 Jul 2014 11:54:44 -0700
Message-ID: <20140731185444.4463.35237@quantum>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
 <53CEA483.6090704@wwwdotorg.org> <53DA2CCB.2080300@collabora.com>
 <53DA8218.7070300@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <53DA8218.7070300@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, "Jason Cooper  <jason@lakedaemon.net>,
 Andrew Lunn  <andrew@lunn.ch>,
 Sebastian Hesselbarth  <sebastian.hesselbarth@gmail.com>,
 Russell King  <linux@arm.linux.org.uk>,
 Shawn Guo  <shawn.guo@freescale.com>,
 Sascha Hauer  <kernel@pengutronix.de>,
 David Brown  <davidb@codeaurora.org>,  Daniel Walker  <dwalker@fifo99.com>,
 Bryan Huntsman  <bryanh@codeaurora.org>,  Paul Walmsley  <paul@pwsan.com>,
 Tony Lindgren  <tony@atomide.com>,
 =?utf-8?q?=22_Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Kevin Hilman" <khilman@deeprootsystems.com>, Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

UXVvdGluZyBTdGVwaGVuIFdhcnJlbiAoMjAxNC0wNy0zMSAxMDo1MToyMCkKPiBPbiAwNy8zMS8y
MDE0IDA1OjQ3IEFNLCBUb21ldSBWaXpvc28gd3JvdGU6Cj4gPiBPbiAwNy8yMi8yMDE0IDA3OjUw
IFBNLCBTdGVwaGVuIFdhcnJlbiB3cm90ZToKPiA+PiBPbiAwNy8xNy8yMDE0IDA4OjEzIEFNLCBU
b21ldSBWaXpvc28gd3JvdGU6Cj4gPj4+IEFkZHMgYSB3YXkgZm9yIGNsb2NrIGNvbnN1bWVycyB0
byBzZXQgbWF4aW11bSBhbmQgbWluaW11bSByYXRlcy4gVGhpcwo+ID4+PiBjYW4gYmUKPiA+Pj4g
dXNlZCBmb3IgdGhlcm1hbCBkcml2ZXJzIHRvIHNldCBjZWlsaW5nIHJhdGVzLCBvciBieSBtaXNj
LiBkcml2ZXJzIHRvCj4gPj4+IHNldAo+ID4+PiBmbG9vciByYXRlcyB0byBhc3N1cmUgYSBtaW5p
bXVtIHBlcmZvcm1hbmNlIGxldmVsLgo+ID4+Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9jbGsuYyBiL2RyaXZlcnMvY2xrL2Nsay5jCj4gPj4KPiA+Pj4gK3N0cnVjdCByYXRlX2NvbnN0
cmFpbnQgewo+ID4+PiArICAgIHN0cnVjdCBobGlzdF9ub2RlICAgIG5vZGU7Cj4gPj4+ICsgICAg
Y29uc3QgY2hhciAgICAgICAgKmRldl9pZDsKPiA+Pj4gKyAgICBjb25zdCBjaGFyICAgICAgICAq
Y29uX2lkOwo+ID4+PiArICAgIGVudW0gY29uc3RyYWludF90eXBlICAgIHR5cGU7Cj4gPj4+ICsg
ICAgdW5zaWduZWQgbG9uZyAgICAgICAgcmF0ZTsKPiA+Pj4gK307Cj4gPj4KPiA+PiBJIHdvdWxk
IHBlcnNvbmFsbHkgc3RpbGwgcHJlZmVyIGVpdGhlcjoKPiA+Pgo+ID4+IGEpIFRoZSBzdHJ1Y3Qg
cmF0ZV9jb25zdHJhaW50cyBiZSBzdG9yZWQgaW4gc3RydWN0IGNsayByYXRoZXIgdGhhbgo+ID4+
IHN0cnVjdCBjbGtfY29yZSwgc28gdGhleSdyZSBzdG9yZWQgaW4gdGhlIGNvbnRhaW5lciB0aGF0
ICJzZXQiIHRoZQo+ID4+IGNvbnN0cmFpbnRzLiBUaGlzIHdvdWxkIG1lYW4gaXRlcmF0aW5nIG92
ZXIgYSBzdHJ1Y3QgY2xrX2NvcmUncwo+ID4+IGFzc29jaWF0ZWQgc3RydWN0IGNsa3MsIHRoZW4g
aXRlcmF0aW5nIG92ZXIgdGhlIHN0cnVjdCByYXRlX2NvbnN0cmFpbnRzCj4gPj4gd2l0aGluIGVh
Y2ggc3RydWN0IGNsay4KPiA+Pgo+ID4+IG9yOgo+ID4+Cj4gPj4gYikgc3RydWN0IHJhdGVfY29u
c3RyYWludCB0byBjb250YWluIGEgcG9pbnRlciB0byB0aGUgc3RydWN0IGNsayB0aGF0Cj4gPj4g
Y3JlYXRlZCB0aGUgY29uc3RyYWludCwgcmF0aGVyIHRoYW4gY29weWluZyB0aGUgZGV2X2lkL2Nv
bl9pZCBmcm9tIHRoYXQKPiA+PiBzdHJ1Y3QgY2xrIGludG8gdGhlIHN0cnVjdCByYXRlX2NvbnN0
cmFpbnQuCj4gPj4KPiA+PiBXaXRoIGVpdGhlciBvZiB0aG9zZSBjaGFuZ2VzLCB0aGUgY29uc3Ry
YWludHMgYXJlIGRpcmVjdGx5IGFzc29jaWF0ZWQKPiA+PiB3aXRoIHRoZSBjbG9jayBjbGllbnQg
b2JqZWN0IHRoYXQgY3JlYXRlZCB0aGUgY29uc3RyYWludCBtdWNoIGJldHRlcgo+ID4+IHRoYW4g
cmlnaHQgbm93LCB3aGVyZSB0aGUgbWF0Y2hpbmcgaXMgb25seSBiZWNhdXNlIHRoZSBzdHJ1Y3Qg
Y2xrIGFuZAo+ID4+IHN0cnVjdCByYXRlX2NvbnN0cmFpbnQgImhhcHBlbiB0byIgaGF2ZSB0aGUg
c2FtZSBkZXZfaWQvY29uX2lkIHZhbHVlcy4KPiA+Pgo+ID4+IFN0aWxsLCB0aGlzIGlzIGEgcHJl
dHR5IG1pbm9yIGlzc3VlLCBhbmQgb3ZlcmFsbCB0aGlzIHNlcmllcyBsb29rcwo+ID4+IHJlYXNv
bmFibGUgdG8gbWUgYXQgYSBxdWljayBsb29rLgo+ID4KPiA+IFllYWgsIEkgYWdyZWUgYW5kIHBl
cnNvbmFsbHkgcHJlZmVyIGEpLCBidXQgZ2l2ZW4gdGhlIGxpdHRsZSBmZWVkYmFjawo+ID4gdGhh
dCBJIGhhdmUgZ290dGVuIHNvIGZhciBvbiB0aGUgcmVmYWN0b3JpbmcsIEknbSBzdGFydGluZyB0
byBjb25zaWRlcgo+ID4gZm9yZ2V0dGluZyBhYm91dCB0aGUgcGVyLXVzZXIgY2xrIHN0cnVjdCBh
bmQgZ28gaW5zdGVhZCB3aXRoIGEKPiA+IHJlcXVlc3QtYmFzZWQgQVBJIHNpbWlsYXIgdG8gdGhh
dCBvZiBwbV9xb3MsIGZvciBzZXR0aW5nIGZsb29yIGFuZAo+ID4gY2VpbGluZyBmcmVxdWVuY2ll
cy4KPiAKPiBJIHdvdWxkIG9idmlvdXNseSBlbmNvdXJhZ2UgeW91IHRvIGNvbnRpbnVlIHB1c2hp
bmcgZm9yIHRoaXMgZmVhdHVyZSwgCj4gYWx0aG91Z2ggSSB1bmRlcnN0YW5kIGl0IGNhbiBiZSBk
aWZmaWN1bHQgdG8gYmUgbW90aXZhdGVkIHdoZW4gdGhlIAo+IHBhdGNoZXMgZG9uJ3QgZ2V0IG11
Y2ggZmVlZGJhY2suCgpTb3JyeSBmb3Igbm90IGdpdmluZyB0aGlzIG1vcmUgb2YgYSBsb29rLiBN
eSBzZWNyZXQgcGxhbiB3YXMgdG8gcmV2aWV3CnRoaXMgaW4gbW9yZSBkZXRhaWwgb25jZSB3ZSdy
ZSBjbG9zZXIgdG8gdGhlIG1lcmdlIHdpbmRvdyBhbmQsIGlmCmFwcHJvcHJpYXRlLCBhcHBseSBp
dCBhcyBvbmUgb2YgdGhlIGZpcnN0IHRoaW5ncyBzaW5jZSB0aGlzIGlzIGJvdW5kIHRvCmNhdXNl
IHNvbWUgYnJlYWthZ2UgZWFybHkgb24gd2hpY2ggbmVlZHMgdG8gYmUgY2F1Z2h0IGFuZCBmaXhl
ZCB1cApxdWlja2x5LgoKV2UgYXJlIHZlcnkgY2xvc2UgdG8gdGhlIG1lcmdlIHdpbmRvdyBzbyBJ
IHdpbGwgdHJ5IHRvIGdldCB0byB0aGlzIGxhdGVyCnRoaXMgd2Vlay4gSSBsaWtlIHRoZSBwZXIt
dXNlciBzdHJ1Y3QgY2xrIG15c2VsZiBhbmQgSSBob3BlIHdlIGNhbiBnZXQKdGhpcyBpbiBmb3Ig
My4xOC4KClJlZ2FyZHMsCk1pa2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMu
b3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
