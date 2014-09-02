From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 3/7] clk: Move all drivers to use internal API
Date: Tue, 2 Sep 2014 09:13:14 +0200
Message-ID: <CAPDyKFq2vzUT+NSkC8ZTau=sbFW_frpQ+paLM_EsYLyp_5ivag@mail.gmail.com>
References: <1409585377-26091-1-git-send-email-tomeu.vizoso@collabora.com>
 <1409585574-26673-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1409585574-26673-1-git-send-email-tomeu.vizoso@collabora.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <t.figa@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kern>
List-Id: linux-arch.vger.kernel.org

T24gMSBTZXB0ZW1iZXIgMjAxNCAxNzozMiwgVG9tZXUgVml6b3NvIDx0b21ldS52aXpvc29AY29s
bGFib3JhLmNvbT4gd3JvdGU6Cj4gSW4gcHJlcGFyYXRpb24gdG8gY2hhbmdlIHRoZSBwdWJsaWMg
QVBJIHRvIHJldHVybiBhIHBlci11c2VyIGNsayBzdHJ1Y3R1cmUsCj4gcmVtb3ZlIGFueSB1c2Fn
ZSBvZiB0aGlzIHB1YmxpYyBBUEkgZnJvbSB0aGUgY2xvY2sgaW1wbGVtZW50YXRpb25zLgo+Cj4g
VGhlIHJlYXNvbiBmb3IgaGF2aW5nIHRoaXMgaW4gYSBzZXBhcmF0ZSBjb21taXQgZnJvbSB0aGUg
b25lIHRoYXQgaW50cm9kdWNlcwo+IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgbmV3IGZ1bmN0
aW9ucyBpcyB0byBzZXBhcmF0ZSB0aGUgY2hhbmdlcyBnZW5lcmF0ZWQKPiB3aXRoIENvY2NpbmVs
bGUgZnJvbSB0aGUgcmVzdCwgYW5kIGtlZXAgdGhlIHBhdGNoZXMnIHNpemUgcmVhc29uYWJsZS4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFRvbWV1IFZpem9zbyA8dG9tZXUudml6b3NvQGNvbGxhYm9yYS5j
b20+Cj4gVGVzdGVkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBmcmVlLWVs
ZWN0cm9ucy5jb20+Cj4gVGVzdGVkLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNoLmRl
Pgo+IEFja2VkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBmcmVlLWVsZWN0
cm9ucy5jb20+CgpIaSBUb21ldSwKCkh1aCwgd2hhdCBhIHBhdGNoLiA6LSkgR3JlYXQgd29yayB5
b3UgYXJlIGRvaW5nIGhlcmUhCgpCeSBqdXN0IGxvb2tpbmcgYXQgdGhlIHV4NTAwIGNoYW5nZXMs
IEkgcmVhbGl6ZSB0aGF0IHlvdSBub3cgaGF2ZQpyZW1vdmVkIHRoZSBkZXBlbmRlbmN5IHRvICJz
dHJ1Y3QgY2xrIiwgdGh1cyB3ZSBzaG91bGRuJ3QgaW5jbHVkZSB0aGUKaGVhZGVyIGZpbGUgbGlu
dXgvY2xrLmggaW4gYW55IGZpbGUgbG9jYXRlZCBpbiBkcml2ZXIvY2xrL3V4NTAwLyosCnJpZ2h0
IT8KCkkgc3VwcG9zZSB0aGlzIGNvbW1lbnQgbWF5IGFsc28gYXBwbGljYWJsZSBmb3Igb3RoZXJz
IHRoYW4gdGhlIHV4NTAwCmNsayBkcml2ZXIsIGJ1dCBoYXZlbid0IGNoZWNrZWQuCgpLaW5kIHJl
Z2FyZHMKVWZmZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3Jn
Cmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
