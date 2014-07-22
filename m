From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 6/6] clk: Add floor and ceiling constraints to clock
 rates
Date: Tue, 22 Jul 2014 11:50:59 -0600
Message-ID: <53CEA483.6090704@wwwdotorg.org>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
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
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mike Turquette <mturquette@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, Vire
List-Id: linux-arch.vger.kernel.org

T24gMDcvMTcvMjAxNCAwODoxMyBBTSwgVG9tZXUgVml6b3NvIHdyb3RlOgo+IEFkZHMgYSB3YXkg
Zm9yIGNsb2NrIGNvbnN1bWVycyB0byBzZXQgbWF4aW11bSBhbmQgbWluaW11bSByYXRlcy4gVGhp
cyBjYW4gYmUKPiB1c2VkIGZvciB0aGVybWFsIGRyaXZlcnMgdG8gc2V0IGNlaWxpbmcgcmF0ZXMs
IG9yIGJ5IG1pc2MuIGRyaXZlcnMgdG8gc2V0Cj4gZmxvb3IgcmF0ZXMgdG8gYXNzdXJlIGEgbWlu
aW11bSBwZXJmb3JtYW5jZSBsZXZlbC4KCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay5j
IGIvZHJpdmVycy9jbGsvY2xrLmMKCj4gK3N0cnVjdCByYXRlX2NvbnN0cmFpbnQgewo+ICsJc3Ry
dWN0IGhsaXN0X25vZGUJbm9kZTsKPiArCWNvbnN0IGNoYXIJCSpkZXZfaWQ7Cj4gKwljb25zdCBj
aGFyCQkqY29uX2lkOwo+ICsJZW51bSBjb25zdHJhaW50X3R5cGUJdHlwZTsKPiArCXVuc2lnbmVk
IGxvbmcJCXJhdGU7Cj4gK307CgpJIHdvdWxkIHBlcnNvbmFsbHkgc3RpbGwgcHJlZmVyIGVpdGhl
cjoKCmEpIFRoZSBzdHJ1Y3QgcmF0ZV9jb25zdHJhaW50cyBiZSBzdG9yZWQgaW4gc3RydWN0IGNs
ayByYXRoZXIgdGhhbgpzdHJ1Y3QgY2xrX2NvcmUsIHNvIHRoZXkncmUgc3RvcmVkIGluIHRoZSBj
b250YWluZXIgdGhhdCAic2V0IiB0aGUKY29uc3RyYWludHMuIFRoaXMgd291bGQgbWVhbiBpdGVy
YXRpbmcgb3ZlciBhIHN0cnVjdCBjbGtfY29yZSdzCmFzc29jaWF0ZWQgc3RydWN0IGNsa3MsIHRo
ZW4gaXRlcmF0aW5nIG92ZXIgdGhlIHN0cnVjdCByYXRlX2NvbnN0cmFpbnRzCndpdGhpbiBlYWNo
IHN0cnVjdCBjbGsuCgpvcjoKCmIpIHN0cnVjdCByYXRlX2NvbnN0cmFpbnQgdG8gY29udGFpbiBh
IHBvaW50ZXIgdG8gdGhlIHN0cnVjdCBjbGsgdGhhdApjcmVhdGVkIHRoZSBjb25zdHJhaW50LCBy
YXRoZXIgdGhhbiBjb3B5aW5nIHRoZSBkZXZfaWQvY29uX2lkIGZyb20gdGhhdApzdHJ1Y3QgY2xr
IGludG8gdGhlIHN0cnVjdCByYXRlX2NvbnN0cmFpbnQuCgpXaXRoIGVpdGhlciBvZiB0aG9zZSBj
aGFuZ2VzLCB0aGUgY29uc3RyYWludHMgYXJlIGRpcmVjdGx5IGFzc29jaWF0ZWQKd2l0aCB0aGUg
Y2xvY2sgY2xpZW50IG9iamVjdCB0aGF0IGNyZWF0ZWQgdGhlIGNvbnN0cmFpbnQgbXVjaCBiZXR0
ZXIKdGhhbiByaWdodCBub3csIHdoZXJlIHRoZSBtYXRjaGluZyBpcyBvbmx5IGJlY2F1c2UgdGhl
IHN0cnVjdCBjbGsgYW5kCnN0cnVjdCByYXRlX2NvbnN0cmFpbnQgImhhcHBlbiB0byIgaGF2ZSB0
aGUgc2FtZSBkZXZfaWQvY29uX2lkIHZhbHVlcy4KClN0aWxsLCB0aGlzIGlzIGEgcHJldHR5IG1p
bm9yIGlzc3VlLCBhbmQgb3ZlcmFsbCB0aGlzIHNlcmllcyBsb29rcwpyZWFzb25hYmxlIHRvIG1l
IGF0IGEgcXVpY2sgbG9vay4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3ps
YWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
