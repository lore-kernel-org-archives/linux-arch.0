From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 00/14] linux: generalize sections,
 ranges and linker tables
Date: Mon, 9 Jan 2017 17:12:28 +0000
Message-ID: <1483981946.26691.44.camel@intel.com>
References: <20161222023811.21246-1-mcgrof@kernel.org>
 <20170109145833.11502-1-mcgrof@kernel.org>
 <1483979228.26691.40.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1483979228.26691.40.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <E5A4F303CA8B10439C6243B57C4B1C8A@intel.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "dalias@libc.org" <dalias@libc.org>, "masami.hiramatsu.pt@hitachi.com" <masami.hiramatsu.pt@hitachi.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "jbaron@akamai.com" <jbaron@akamai.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "jpoimboe@redhat.com" <jpoimboe@redhat.com>, "realmz6@gmail.com" <realmz6@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>, "acme@redhat.com" <acme@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, "ananth@linux.vnet.ibm.com" <ananth@linux.vnet.ibm.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>, "davem@davemloft.net" <davem@davemloft.net>, "npiggin@gmail.com" <npiggin@gmail.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "x86@kernel.org" <x86@kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "ming.lei@canonical.com" <ming.lei@canonical.com>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "paulus@samba.org" <paulus@samba.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "markus.heiser@darmarit.de" <markus.heiser@darmarit>
List-Id: linux-arch.vger.kernel.org

T24gTW9uLCAyMDE3LTAxLTA5IGF0IDE4OjI3ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IE9uIE1vbiwgMjAxNy0wMS0wOSBhdCAwNjo1OCAtMDgwMCwgTHVpcyBSLiBSb2RyaWd1ZXog
d3JvdGU6DQoNCj4gPiBUaGUgb25seSBhcmNoaXRlY3R1cmUgdGhhdCB3YXMgbm90IHRlc3RlZCB3
YXMgYXZyMzIgYW5kIHRoYXQgaXMNCj4gPiBiZWNhdXNlDQo+ID4gbGludXgtbmV4dCBmYWlscyB0
byBjb21waWxlIG9uIGl0LiBJJ2QgbGlrZSB0byBncmVhdGx5IHRoYW5rIEd1ZW50ZXINCj4gPiBS
b2VjayBmb3INCj4gPiBoaXMgaGVscCB3aXRoIHRlc3RpbmcuDQo+IA0KPiBXZSBoYXZlIGEgcmVh
bCBib2FyZCBoZXJlLiBJIHdvdWxkIHRyeSB0byBjaGVjayBpZiB5b3UgcHJvdmlkZSBhIGdpdA0K
PiB1cmwNCj4gdG8geW91ciBzdHVmZi4NCj4gDQo+IEkgY2FuIGNvbmZpcm0gdGhhdCBicmVha2Fn
ZSBoYXBwZW5lZCBsaWtlIGluIGxhc3QgY291cGxlIG9mIG1vbnRoLg0KPiB2NC4xMC1yYzMgY2Fu
J3QgYmUgY29tcGlsZWQgZWl0aGVyLg0KDQpUaGUgY3VscHJpdCBjb21taXQgaXMNCg0KY29tbWl0
IDNhMGFmOGZkNjFmOTA5MjBmNmZhMDRlNGYxZTlhNmE3M2MxYjRmZDINCkF1dGhvcjogVGhvbWFz
IEdyYWYgPHRncmFmQHN1dWcuY2g+DQpEYXRlOsKgwqDCoFdlZCBOb3YgMzAgMTc6MTA6MTAgMjAx
NiArMDEwMA0KDQrCoMKgwqDCoGJwZjogQlBGIGZvciBsaWdodHdlaWdodCB0dW5uZWwgaW5mcmFz
dHJ1Y3R1cmUNCg0KLS0gDQpBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVs
LmNvbT4NCkludGVsIEZpbmxhbmQgT3kgLSBCSUMgMDM1NzYwNi00IC0gV2VzdGVuZGlua2F0dSA3
LCAwMjE2MCBFc3BvbwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBz
Oi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
