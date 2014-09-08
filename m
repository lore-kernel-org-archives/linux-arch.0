From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v9 2/6] clk: Move all drivers to use internal API
Date: Sun, 07 Sep 2014 23:13:55 -0700
Message-ID: <20140908061355.19023.47997@quantum>
References: <1409758148-20104-2-git-send-email-tomeu.vizoso@collabora.com>
 <1409758317-20564-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1409758317-20564-1-git-send-email-tomeu.vizoso@collabora.com>
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
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, "Stephen Warren  <swarren@wwwdotorg.org>,
 Thierry Reding  <thierry.reding@gmail.com>, tomasz.figa@gmail.com,
 Peter De Schrijver  <pdeschrijver@nvidia.com>, rabin@rab.in,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jason Cooper  <jason@lakedaemon.net>,  Andrew Lunn  <andrew@lunn.ch>,
 Sebastian Hesselbarth  <sebastian.hesselbarth@gmail.com>,
 Russell King  <linux@arm.linux.org.uk>,
 Shawn Guo  <shawn.guo@freescale.com>,
 Sascha Hauer  <kernel@pengutronix.de>,
 David Brown  <davidb@codeaurora.org>,  Daniel Walker  <dwalker@fifo99.com>,
 Bryan Huntsman  <bryanh@codeaurora.org>,  Paul Walmsley  <paul@pwsan.com>,
 Tony Lindgren  <tony@atomide.com>,
 =?utf-8?q?=22_Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Kevin Hilman" <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org
List-Id: linux-arch.vger.kernel.org

UXVvdGluZyBUb21ldSBWaXpvc28gKDIwMTQtMDktMDMgMDg6MzE6NTcpCj4gSW4gcHJlcGFyYXRp
b24gdG8gY2hhbmdlIHRoZSBwdWJsaWMgQVBJIHRvIHJldHVybiBhIHBlci11c2VyIGNsayBzdHJ1
Y3R1cmUsCj4gcmVtb3ZlIGFueSB1c2FnZSBvZiB0aGlzIHB1YmxpYyBBUEkgZnJvbSB0aGUgY2xv
Y2sgaW1wbGVtZW50YXRpb25zLgo+IAo+IFRoZSByZWFzb24gZm9yIGhhdmluZyB0aGlzIGluIGEg
c2VwYXJhdGUgY29tbWl0IGZyb20gdGhlIG9uZSB0aGF0IGludHJvZHVjZXMKPiB0aGUgaW1wbGVt
ZW50YXRpb24gb2YgdGhlIG5ldyBmdW5jdGlvbnMgaXMgdG8gc2VwYXJhdGUgdGhlIGNoYW5nZXMg
Z2VuZXJhdGVkCj4gd2l0aCBDb2NjaW5lbGxlIGZyb20gdGhlIHJlc3QsIGFuZCBrZWVwIHRoZSBw
YXRjaGVzJyBzaXplIHJlYXNvbmFibGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogVG9tZXUgVml6b3Nv
IDx0b21ldS52aXpvc29AY29sbGFib3JhLmNvbT4KPiBUZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxv
biA8Ym9yaXMuYnJlemlsbG9uQGZyZWUtZWxlY3Ryb25zLmNvbT4KPiBUZXN0ZWQtYnk6IEhlaWtv
IFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+Cj4gQWNrZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8
Ym9yaXMuYnJlemlsbG9uQGZyZWUtZWxlY3Ryb25zLmNvbT4KCkhpIFRvbWV1LAoKTG9va3MgbGlr
ZSB0aGUgQ29jY2luZWxsZSBzY3JpcHQgaGFkIGEgZmFsc2UtcG9zaXRpdmUuCmFzbS1nZW5lcmlj
L2Nsa2Rldi5oIHdhcyBjb252ZXJ0ZWQgZnJvbSBjbGstPmNsa19jb3JlIGFuZCB0aGlzIGJsb3dl
ZCB1cApjbG9jayBkcml2ZXJzIGZvciBhcmNoaXRlY3R1cmVzIHRoYXQgZG9uJ3QgcHJvdmlkZSBh
biBhc20tc3BlY2lmaWMKY2xrZGV2LmggaW1wbGVtZW50YXRpb24uIFRoaXMgZml4ZXMgeDg2J3Mg
TFBTUyBhbmQgYSBNaWNyb2JsYXplIGRyaXZlci4KCkkndmUgcm9sbGVkIHRoZSBmb2xsb3dpbmcg
Zml4IGludG8geW91ciAyLzkgcGF0Y2guIE5vIGFjdGlvbiBpcwpuZWNlc3NhcnkuCgpSZWdhcmRz
LApNaWtlCgoKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL2Nsa2Rldi5oIGIvaW5j
bHVkZS9hc20tZ2VuZXJpYy9jbGtkZXYuaAppbmRleCA0MzIwMjI1Li45MGEzMmE2IDEwMDY0NAot
LS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL2Nsa2Rldi5oCisrKyBiL2luY2x1ZGUvYXNtLWdlbmVy
aWMvY2xrZGV2LmgKQEAgLTE1LDEwICsxNSwxMCBAQAoKICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+
Cgotc3RydWN0IGNsa19jb3JlOworc3RydWN0IGNsazsKCi1zdGF0aWMgaW5saW5lIGludCBfX2Ns
a19nZXQoc3RydWN0IGNsa19jb3JlICpjbGspIHsgcmV0dXJuIDE7IH0KLXN0YXRpYyBpbmxpbmUg
dm9pZCBfX2Nsa19wdXQoc3RydWN0IGNsa19jb3JlICpjbGspIHsgfQorc3RhdGljIGlubGluZSBp
bnQgX19jbGtfZ2V0KHN0cnVjdCBjbGsgKmNsaykgeyByZXR1cm4gMTsgfQorc3RhdGljIGlubGlu
ZSB2b2lkIF9fY2xrX3B1dChzdHJ1Y3QgY2xrICpjbGspIHsgfQoKIHN0YXRpYyBpbmxpbmUgc3Ry
dWN0IGNsa19sb29rdXBfYWxsb2MgKl9fY2xrZGV2X2FsbG9jKHNpemVfdCBzaXplKQogewpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYg
bWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMu
b3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
