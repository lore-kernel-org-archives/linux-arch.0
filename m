From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 3/6] clk: Move all drivers to use internal API
Date: Wed, 13 Aug 2014 11:50:56 +0200
Message-ID: <20140813115056.0bd5ead7@bbrezillon>
References: <1407333468-32180-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1407333468-32180-1-git-send-email-tomeu.vizoso@collabora.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, Viresh Kumar <viresh.linux@gmai>
List-Id: linux-arch.vger.kernel.org

SGkgVG9tZXUsCgpPbiBXZWQsICA2IEF1ZyAyMDE0IDE1OjU3OjQ4ICswMjAwClRvbWV1IFZpem9z
byA8dG9tZXUudml6b3NvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgoKPiBJbiBwcmVwYXJhdGlvbiB0
byBjaGFuZ2UgdGhlIHB1YmxpYyBBUEkgdG8gcmV0dXJuIGEgcGVyLXVzZXIgY2xrIHN0cnVjdHVy
ZSwKPiByZW1vdmUgYW55IHVzYWdlIG9mIHRoaXMgcHVibGljIEFQSSBmcm9tIHRoZSBjbG9jayBp
bXBsZW1lbnRhdGlvbnMuCj4gCj4gVGhlIHJlYXNvbiBmb3IgaGF2aW5nIHRoaXMgaW4gYSBzZXBh
cmF0ZSBjb21taXQgZnJvbSB0aGUgb25lIHRoYXQgaW50cm9kdWNlcwo+IHRoZSBpbXBsZW1lbnRh
dGlvbiBvZiB0aGUgbmV3IGZ1bmN0aW9ucyBpcyB0byBzZXBhcmF0ZSB0aGUgY2hhbmdlcyBnZW5l
cmF0ZWQKPiB3aXRoIENvY2NpbmVsbGUgZnJvbSB0aGUgcmVzdCwgYW5kIGtlZXAgdGhlIHBhdGNo
ZXMnIHNpemUgcmVhc29uYWJsZS4KPiAKCllvdSBjYW4gYWRkIG15OgoKVGVzdGVkLWJ5OiBCb3Jp
cyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBmcmVlLWVsZWN0cm9ucy5jb20+CgphbmQKCkFj
a2VkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBmcmVlLWVsZWN0cm9ucy5j
b20+Cgpmb3IgdGhlIGF0OTEgcGFydC4KCj4gU2lnbmVkLW9mZi1ieTogVG9tZXUgVml6b3NvIDx0
b21ldS52aXpvc29AY29sbGFib3JhLmNvbT4KCkJlc3QgUmVnYXJkcywKCkJvcmlzCgotLSAKQm9y
aXMgQnJlemlsbG9uLCBGcmVlIEVsZWN0cm9ucwpFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVu
Z2luZWVyaW5nCmh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51
eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGlu
Zm8vbGludXhwcGMtZGV2
