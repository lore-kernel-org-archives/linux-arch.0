From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4 6/6] clk: Add floor and ceiling constraints to clock
 rates
Date: Thu, 31 Jul 2014 13:47:23 +0200
Message-ID: <53DA2CCB.2080300@collabora.com>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
 <53CEA483.6090704@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <53CEA483.6090704@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>, Mike Turquette <mturquette@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, Vire
List-Id: linux-arch.vger.kernel.org

T24gMDcvMjIvMjAxNCAwNzo1MCBQTSwgU3RlcGhlbiBXYXJyZW4gd3JvdGU6Cj4gT24gMDcvMTcv
MjAxNCAwODoxMyBBTSwgVG9tZXUgVml6b3NvIHdyb3RlOgo+PiBBZGRzIGEgd2F5IGZvciBjbG9j
ayBjb25zdW1lcnMgdG8gc2V0IG1heGltdW0gYW5kIG1pbmltdW0gcmF0ZXMuIFRoaXMgY2FuIGJl
Cj4+IHVzZWQgZm9yIHRoZXJtYWwgZHJpdmVycyB0byBzZXQgY2VpbGluZyByYXRlcywgb3IgYnkg
bWlzYy4gZHJpdmVycyB0byBzZXQKPj4gZmxvb3IgcmF0ZXMgdG8gYXNzdXJlIGEgbWluaW11bSBw
ZXJmb3JtYW5jZSBsZXZlbC4KPgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLmMgYi9k
cml2ZXJzL2Nsay9jbGsuYwo+Cj4+ICtzdHJ1Y3QgcmF0ZV9jb25zdHJhaW50IHsKPj4gKwlzdHJ1
Y3QgaGxpc3Rfbm9kZQlub2RlOwo+PiArCWNvbnN0IGNoYXIJCSpkZXZfaWQ7Cj4+ICsJY29uc3Qg
Y2hhcgkJKmNvbl9pZDsKPj4gKwllbnVtIGNvbnN0cmFpbnRfdHlwZQl0eXBlOwo+PiArCXVuc2ln
bmVkIGxvbmcJCXJhdGU7Cj4+ICt9Owo+Cj4gSSB3b3VsZCBwZXJzb25hbGx5IHN0aWxsIHByZWZl
ciBlaXRoZXI6Cj4KPiBhKSBUaGUgc3RydWN0IHJhdGVfY29uc3RyYWludHMgYmUgc3RvcmVkIGlu
IHN0cnVjdCBjbGsgcmF0aGVyIHRoYW4KPiBzdHJ1Y3QgY2xrX2NvcmUsIHNvIHRoZXkncmUgc3Rv
cmVkIGluIHRoZSBjb250YWluZXIgdGhhdCAic2V0IiB0aGUKPiBjb25zdHJhaW50cy4gVGhpcyB3
b3VsZCBtZWFuIGl0ZXJhdGluZyBvdmVyIGEgc3RydWN0IGNsa19jb3JlJ3MKPiBhc3NvY2lhdGVk
IHN0cnVjdCBjbGtzLCB0aGVuIGl0ZXJhdGluZyBvdmVyIHRoZSBzdHJ1Y3QgcmF0ZV9jb25zdHJh
aW50cwo+IHdpdGhpbiBlYWNoIHN0cnVjdCBjbGsuCj4KPiBvcjoKPgo+IGIpIHN0cnVjdCByYXRl
X2NvbnN0cmFpbnQgdG8gY29udGFpbiBhIHBvaW50ZXIgdG8gdGhlIHN0cnVjdCBjbGsgdGhhdAo+
IGNyZWF0ZWQgdGhlIGNvbnN0cmFpbnQsIHJhdGhlciB0aGFuIGNvcHlpbmcgdGhlIGRldl9pZC9j
b25faWQgZnJvbSB0aGF0Cj4gc3RydWN0IGNsayBpbnRvIHRoZSBzdHJ1Y3QgcmF0ZV9jb25zdHJh
aW50Lgo+Cj4gV2l0aCBlaXRoZXIgb2YgdGhvc2UgY2hhbmdlcywgdGhlIGNvbnN0cmFpbnRzIGFy
ZSBkaXJlY3RseSBhc3NvY2lhdGVkCj4gd2l0aCB0aGUgY2xvY2sgY2xpZW50IG9iamVjdCB0aGF0
IGNyZWF0ZWQgdGhlIGNvbnN0cmFpbnQgbXVjaCBiZXR0ZXIKPiB0aGFuIHJpZ2h0IG5vdywgd2hl
cmUgdGhlIG1hdGNoaW5nIGlzIG9ubHkgYmVjYXVzZSB0aGUgc3RydWN0IGNsayBhbmQKPiBzdHJ1
Y3QgcmF0ZV9jb25zdHJhaW50ICJoYXBwZW4gdG8iIGhhdmUgdGhlIHNhbWUgZGV2X2lkL2Nvbl9p
ZCB2YWx1ZXMuCj4KPiBTdGlsbCwgdGhpcyBpcyBhIHByZXR0eSBtaW5vciBpc3N1ZSwgYW5kIG92
ZXJhbGwgdGhpcyBzZXJpZXMgbG9va3MKPiByZWFzb25hYmxlIHRvIG1lIGF0IGEgcXVpY2sgbG9v
ay4KClllYWgsIEkgYWdyZWUgYW5kIHBlcnNvbmFsbHkgcHJlZmVyIGEpLCBidXQgZ2l2ZW4gdGhl
IGxpdHRsZSBmZWVkYmFjayAKdGhhdCBJIGhhdmUgZ290dGVuIHNvIGZhciBvbiB0aGUgcmVmYWN0
b3JpbmcsIEknbSBzdGFydGluZyB0byBjb25zaWRlciAKZm9yZ2V0dGluZyBhYm91dCB0aGUgcGVy
LXVzZXIgY2xrIHN0cnVjdCBhbmQgZ28gaW5zdGVhZCB3aXRoIGEgCnJlcXVlc3QtYmFzZWQgQVBJ
IHNpbWlsYXIgdG8gdGhhdCBvZiBwbV9xb3MsIGZvciBzZXR0aW5nIGZsb29yIGFuZCAKY2VpbGlu
ZyBmcmVxdWVuY2llcy4KClJlZ2FyZHMsCgpUb21ldQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9s
aW51eHBwYy1kZXY=
