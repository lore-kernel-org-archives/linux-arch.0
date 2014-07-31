From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 6/6] clk: Add floor and ceiling constraints to clock
 rates
Date: Thu, 31 Jul 2014 11:51:20 -0600
Message-ID: <53DA8218.7070300@wwwdotorg.org>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
 <53CEA483.6090704@wwwdotorg.org> <53DA2CCB.2080300@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <53DA2CCB.2080300@collabora.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, =?windows-1252?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com, Vi
List-Id: linux-arch.vger.kernel.org

T24gMDcvMzEvMjAxNCAwNTo0NyBBTSwgVG9tZXUgVml6b3NvIHdyb3RlOgo+IE9uIDA3LzIyLzIw
MTQgMDc6NTAgUE0sIFN0ZXBoZW4gV2FycmVuIHdyb3RlOgo+PiBPbiAwNy8xNy8yMDE0IDA4OjEz
IEFNLCBUb21ldSBWaXpvc28gd3JvdGU6Cj4+PiBBZGRzIGEgd2F5IGZvciBjbG9jayBjb25zdW1l
cnMgdG8gc2V0IG1heGltdW0gYW5kIG1pbmltdW0gcmF0ZXMuIFRoaXMKPj4+IGNhbiBiZQo+Pj4g
dXNlZCBmb3IgdGhlcm1hbCBkcml2ZXJzIHRvIHNldCBjZWlsaW5nIHJhdGVzLCBvciBieSBtaXNj
LiBkcml2ZXJzIHRvCj4+PiBzZXQKPj4+IGZsb29yIHJhdGVzIHRvIGFzc3VyZSBhIG1pbmltdW0g
cGVyZm9ybWFuY2UgbGV2ZWwuCj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLmMg
Yi9kcml2ZXJzL2Nsay9jbGsuYwo+Pgo+Pj4gK3N0cnVjdCByYXRlX2NvbnN0cmFpbnQgewo+Pj4g
KyAgICBzdHJ1Y3QgaGxpc3Rfbm9kZSAgICBub2RlOwo+Pj4gKyAgICBjb25zdCBjaGFyICAgICAg
ICAqZGV2X2lkOwo+Pj4gKyAgICBjb25zdCBjaGFyICAgICAgICAqY29uX2lkOwo+Pj4gKyAgICBl
bnVtIGNvbnN0cmFpbnRfdHlwZSAgICB0eXBlOwo+Pj4gKyAgICB1bnNpZ25lZCBsb25nICAgICAg
ICByYXRlOwo+Pj4gK307Cj4+Cj4+IEkgd291bGQgcGVyc29uYWxseSBzdGlsbCBwcmVmZXIgZWl0
aGVyOgo+Pgo+PiBhKSBUaGUgc3RydWN0IHJhdGVfY29uc3RyYWludHMgYmUgc3RvcmVkIGluIHN0
cnVjdCBjbGsgcmF0aGVyIHRoYW4KPj4gc3RydWN0IGNsa19jb3JlLCBzbyB0aGV5J3JlIHN0b3Jl
ZCBpbiB0aGUgY29udGFpbmVyIHRoYXQgInNldCIgdGhlCj4+IGNvbnN0cmFpbnRzLiBUaGlzIHdv
dWxkIG1lYW4gaXRlcmF0aW5nIG92ZXIgYSBzdHJ1Y3QgY2xrX2NvcmUncwo+PiBhc3NvY2lhdGVk
IHN0cnVjdCBjbGtzLCB0aGVuIGl0ZXJhdGluZyBvdmVyIHRoZSBzdHJ1Y3QgcmF0ZV9jb25zdHJh
aW50cwo+PiB3aXRoaW4gZWFjaCBzdHJ1Y3QgY2xrLgo+Pgo+PiBvcjoKPj4KPj4gYikgc3RydWN0
IHJhdGVfY29uc3RyYWludCB0byBjb250YWluIGEgcG9pbnRlciB0byB0aGUgc3RydWN0IGNsayB0
aGF0Cj4+IGNyZWF0ZWQgdGhlIGNvbnN0cmFpbnQsIHJhdGhlciB0aGFuIGNvcHlpbmcgdGhlIGRl
dl9pZC9jb25faWQgZnJvbSB0aGF0Cj4+IHN0cnVjdCBjbGsgaW50byB0aGUgc3RydWN0IHJhdGVf
Y29uc3RyYWludC4KPj4KPj4gV2l0aCBlaXRoZXIgb2YgdGhvc2UgY2hhbmdlcywgdGhlIGNvbnN0
cmFpbnRzIGFyZSBkaXJlY3RseSBhc3NvY2lhdGVkCj4+IHdpdGggdGhlIGNsb2NrIGNsaWVudCBv
YmplY3QgdGhhdCBjcmVhdGVkIHRoZSBjb25zdHJhaW50IG11Y2ggYmV0dGVyCj4+IHRoYW4gcmln
aHQgbm93LCB3aGVyZSB0aGUgbWF0Y2hpbmcgaXMgb25seSBiZWNhdXNlIHRoZSBzdHJ1Y3QgY2xr
IGFuZAo+PiBzdHJ1Y3QgcmF0ZV9jb25zdHJhaW50ICJoYXBwZW4gdG8iIGhhdmUgdGhlIHNhbWUg
ZGV2X2lkL2Nvbl9pZCB2YWx1ZXMuCj4+Cj4+IFN0aWxsLCB0aGlzIGlzIGEgcHJldHR5IG1pbm9y
IGlzc3VlLCBhbmQgb3ZlcmFsbCB0aGlzIHNlcmllcyBsb29rcwo+PiByZWFzb25hYmxlIHRvIG1l
IGF0IGEgcXVpY2sgbG9vay4KPgo+IFllYWgsIEkgYWdyZWUgYW5kIHBlcnNvbmFsbHkgcHJlZmVy
IGEpLCBidXQgZ2l2ZW4gdGhlIGxpdHRsZSBmZWVkYmFjawo+IHRoYXQgSSBoYXZlIGdvdHRlbiBz
byBmYXIgb24gdGhlIHJlZmFjdG9yaW5nLCBJJ20gc3RhcnRpbmcgdG8gY29uc2lkZXIKPiBmb3Jn
ZXR0aW5nIGFib3V0IHRoZSBwZXItdXNlciBjbGsgc3RydWN0IGFuZCBnbyBpbnN0ZWFkIHdpdGgg
YQo+IHJlcXVlc3QtYmFzZWQgQVBJIHNpbWlsYXIgdG8gdGhhdCBvZiBwbV9xb3MsIGZvciBzZXR0
aW5nIGZsb29yIGFuZAo+IGNlaWxpbmcgZnJlcXVlbmNpZXMuCgpJIHdvdWxkIG9idmlvdXNseSBl
bmNvdXJhZ2UgeW91IHRvIGNvbnRpbnVlIHB1c2hpbmcgZm9yIHRoaXMgZmVhdHVyZSwgCmFsdGhv
dWdoIEkgdW5kZXJzdGFuZCBpdCBjYW4gYmUgZGlmZmljdWx0IHRvIGJlIG1vdGl2YXRlZCB3aGVu
IHRoZSAKcGF0Y2hlcyBkb24ndCBnZXQgbXVjaCBmZWVkYmFjay4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApM
aW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlz
dGluZm8vbGludXhwcGMtZGV2
