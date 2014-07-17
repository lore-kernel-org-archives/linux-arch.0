From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 2/6] ASoC: mxs-saif: fix mixed use of public and provider
 clk API
Date: Thu, 17 Jul 2014 16:13:15 +0200
Message-ID: <1405606399-26608-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
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
To: Mike Turquette <mturquette@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, Vire
List-Id: linux-arch.vger.kernel.org

SW4gcHJlcGFyYXRpb24gdG8gY2hhbmdpbmcgdGhlIGNsayBwcm92aWRlciBBUEkgdG8gdXNlIHN0
cnVjdCBjbGtfY29yZSBpbnN0ZWFkCm9mIHN0cnVjdCBjbGsuCgpTaWduZWQtb2ZmLWJ5OiBUb21l
dSBWaXpvc28gPHRvbWV1LnZpem9zb0Bjb2xsYWJvcmEuY29tPgotLS0KIHNvdW5kL3NvYy9teHMv
bXhzLXNhaWYuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbXhzL214cy1zYWlmLmMgYi9zb3Vu
ZC9zb2MvbXhzL214cy1zYWlmLmMKaW5kZXggMjMxZDdlNy4uYTI0MzY3ZCAxMDA2NDQKLS0tIGEv
c291bmQvc29jL214cy9teHMtc2FpZi5jCisrKyBiL3NvdW5kL3NvYy9teHMvbXhzLXNhaWYuYwpA
QCAtNjgyLDExICs2ODIsMTEgQEAgc3RhdGljIGludCBteHNfc2FpZl9tY2xrX2luaXQoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKIAlzdHJ1Y3QgbXhzX3NhaWYgKnNhaWYgPSBwbGF0
Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+
ZGV2Lm9mX25vZGU7Ci0Jc3RydWN0IGNsayAqY2xrOworCXN0cnVjdCBjbGtfY29yZSAqY2xrOwog
CWludCByZXQ7CiAKIAljbGsgPSBjbGtfcmVnaXN0ZXJfZGl2aWRlcigmcGRldi0+ZGV2LCAibXhz
X3NhaWZfbWNsayIsCi0JCQkJICAgX19jbGtfZ2V0X25hbWUoc2FpZi0+Y2xrKSwgMCwKKwkJCQkg
ICBjbGtfZ2V0X25hbWUoc2FpZi0+Y2xrKSwgMCwKIAkJCQkgICBzYWlmLT5iYXNlICsgU0FJRl9D
VFJMLAogCQkJCSAgIEJQX1NBSUZfQ1RSTF9CSVRDTEtfTVVMVF9SQVRFLCAzLAogCQkJCSAgIDAs
IE5VTEwpOwotLSAKMS45LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96
bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
