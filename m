From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v8 3/7] clk: Move all drivers to use internal API
Date: Wed, 03 Sep 2014 14:59:38 +0200
Message-ID: <540710BA.60108@collabora.com>
References: <1409585377-26091-1-git-send-email-tomeu.vizoso@collabora.com>	<1409585574-26673-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAPDyKFq2vzUT+NSkC8ZTau=sbFW_frpQ+paLM_EsYLyp_5ivag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CAPDyKFq2vzUT+NSkC8ZTau=sbFW_frpQ+paLM_EsYLyp_5ivag@mail.gmail.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <t.figa@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-k>
List-Id: linux-arch.vger.kernel.org

T24gMDkvMDIvMjAxNCAwOToxMyBBTSwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gT24gMSBTZXB0ZW1i
ZXIgMjAxNCAxNzozMiwgVG9tZXUgVml6b3NvIDx0b21ldS52aXpvc29AY29sbGFib3JhLmNvbT4g
d3JvdGU6Cj4+IEluIHByZXBhcmF0aW9uIHRvIGNoYW5nZSB0aGUgcHVibGljIEFQSSB0byByZXR1
cm4gYSBwZXItdXNlciBjbGsgc3RydWN0dXJlLAo+PiByZW1vdmUgYW55IHVzYWdlIG9mIHRoaXMg
cHVibGljIEFQSSBmcm9tIHRoZSBjbG9jayBpbXBsZW1lbnRhdGlvbnMuCj4+Cj4+IFRoZSByZWFz
b24gZm9yIGhhdmluZyB0aGlzIGluIGEgc2VwYXJhdGUgY29tbWl0IGZyb20gdGhlIG9uZSB0aGF0
IGludHJvZHVjZXMKPj4gdGhlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBuZXcgZnVuY3Rpb25zIGlz
IHRvIHNlcGFyYXRlIHRoZSBjaGFuZ2VzIGdlbmVyYXRlZAo+PiB3aXRoIENvY2NpbmVsbGUgZnJv
bSB0aGUgcmVzdCwgYW5kIGtlZXAgdGhlIHBhdGNoZXMnIHNpemUgcmVhc29uYWJsZS4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogVG9tZXUgVml6b3NvIDx0b21ldS52aXpvc29AY29sbGFib3JhLmNvbT4K
Pj4gVGVzdGVkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBmcmVlLWVsZWN0
cm9ucy5jb20+Cj4+IFRlc3RlZC1ieTogSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4K
Pj4gQWNrZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGZyZWUtZWxlY3Ry
b25zLmNvbT4KPgo+IEhpIFRvbWV1LAo+Cj4gSHVoLCB3aGF0IGEgcGF0Y2guIDotKSBHcmVhdCB3
b3JrIHlvdSBhcmUgZG9pbmcgaGVyZSEKClRoYW5rcyEKCj4gQnkganVzdCBsb29raW5nIGF0IHRo
ZSB1eDUwMCBjaGFuZ2VzLCBJIHJlYWxpemUgdGhhdCB5b3Ugbm93IGhhdmUKPiByZW1vdmVkIHRo
ZSBkZXBlbmRlbmN5IHRvICJzdHJ1Y3QgY2xrIiwgdGh1cyB3ZSBzaG91bGRuJ3QgaW5jbHVkZSB0
aGUKPiBoZWFkZXIgZmlsZSBsaW51eC9jbGsuaCBpbiBhbnkgZmlsZSBsb2NhdGVkIGluIGRyaXZl
ci9jbGsvdXg1MDAvKiwKPiByaWdodCE/Cj4KPiBJIHN1cHBvc2UgdGhpcyBjb21tZW50IG1heSBh
bHNvIGFwcGxpY2FibGUgZm9yIG90aGVycyB0aGFuIHRoZSB1eDUwMAo+IGNsayBkcml2ZXIsIGJ1
dCBoYXZlbid0IGNoZWNrZWQuCgpZb3UgYXJlIHJpZ2h0LiBJIGhhdmUgZ29uZSBhaGVhZCBhbmQg
cmVtb3ZlZCB0aGUgaW5jbHVkZSBmcm9tIGFsbCBmaWxlcyAKdGhhdCBhcmUgZmVkIHRvIHRoZSBj
b2NjaW5lbGxlIHNjcmlwdC4gRXZlcnl0aGluZyBidWlsZHMgZmluZSBpbiBhbGwgCmNvbmZpZ3Vy
YXRpb25zIEkgaGF2ZSB0ZXN0ZWQsIHNvIEkgd2lsbCBiZSBhZGRpbmcgaXQgdG8gdjkuCgpUaGFu
a3MgZm9yIHRoZSBpZGVhLAoKVG9tZXUKCgo+IEtpbmQgcmVnYXJkcwo+IFVmZmUKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1h
aWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96
bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
