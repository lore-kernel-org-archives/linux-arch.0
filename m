From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v6 00/14] linux: generalize sections,
	ranges and linker tables
Date: Mon, 9 Jan 2017 11:16:16 -0600
Message-ID: <CAB=NE6WSqzaT=KO=NPtX5ogfdu9dQEMOTfa==iZyNW8xGcLsgw@mail.gmail.com>
References: <20161222023811.21246-1-mcgrof@kernel.org>
 <20170109145833.11502-1-mcgrof@kernel.org>
 <1483979228.26691.40.camel@linux.intel.com>
 <1483981946.26691.44.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1483981946.26691.44.camel@intel.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, Thomas Graf <tgraf@suug.ch>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>, "dalias@libc.org" <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "wangnan0@huawei.com" <wangnan0@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "ming.lei@canonical.com" <ming.lei@canonical.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "James.Bottomley@HansenPartnership.com" <James.Bottomley@hansenpartnership.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "paulus@samba.org" <paulus@samba.org>, "hpa@zytor.com" <hpa@zytor.com>, "masami.hiramatsu.pt@hitachi.com" <masami.hiramatsu.pt@hitachi.com>, "luto@amacapital.net" <luto@amacapital.net>, "mchehab@osg.samsung.com" <mcheh>
List-Id: linux-arch.vger.kernel.org

T24gTW9uLCBKYW4gOSwgMjAxNyBhdCAxMToxMiBBTSwgU2hldmNoZW5rbywgQW5kcml5CjxhbmRy
aXkuc2hldmNoZW5rb0BpbnRlbC5jb20+IHdyb3RlOgo+IE9uIE1vbiwgMjAxNy0wMS0wOSBhdCAx
ODoyNyArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+PiBPbiBNb24sIDIwMTctMDEtMDkg
YXQgMDY6NTggLTA4MDAsIEx1aXMgUi4gUm9kcmlndWV6IHdyb3RlOgo+Cj4+ID4gVGhlIG9ubHkg
YXJjaGl0ZWN0dXJlIHRoYXQgd2FzIG5vdCB0ZXN0ZWQgd2FzIGF2cjMyIGFuZCB0aGF0IGlzCj4+
ID4gYmVjYXVzZQo+PiA+IGxpbnV4LW5leHQgZmFpbHMgdG8gY29tcGlsZSBvbiBpdC4gSSdkIGxp
a2UgdG8gZ3JlYXRseSB0aGFuayBHdWVudGVyCj4+ID4gUm9lY2sgZm9yCj4+ID4gaGlzIGhlbHAg
d2l0aCB0ZXN0aW5nLgo+Pgo+PiBXZSBoYXZlIGEgcmVhbCBib2FyZCBoZXJlLiBJIHdvdWxkIHRy
eSB0byBjaGVjayBpZiB5b3UgcHJvdmlkZSBhIGdpdAo+PiB1cmwKPj4gdG8geW91ciBzdHVmZi4K
Pj4KPj4gSSBjYW4gY29uZmlybSB0aGF0IGJyZWFrYWdlIGhhcHBlbmVkIGxpa2UgaW4gbGFzdCBj
b3VwbGUgb2YgbW9udGguCj4+IHY0LjEwLXJjMyBjYW4ndCBiZSBjb21waWxlZCBlaXRoZXIuCj4K
PiBUaGUgY3VscHJpdCBjb21taXQgaXMKPgo+IGNvbW1pdCAzYTBhZjhmZDYxZjkwOTIwZjZmYTA0
ZTRmMWU5YTZhNzNjMWI0ZmQyCj4gQXV0aG9yOiBUaG9tYXMgR3JhZiA8dGdyYWZAc3V1Zy5jaD4K
PiBEYXRlOiAgIFdlZCBOb3YgMzAgMTc6MTA6MTAgMjAxNiArMDEwMAo+Cj4gICAgIGJwZjogQlBG
IGZvciBsaWdodHdlaWdodCB0dW5uZWwgaW5mcmFzdHJ1Y3R1cmUKCk9LIEkgZ3Vlc3MgeW91IGZv
bGtzIGNhbiB0YWtlIGl0IG9uIGluIGEgc2VwYXJhdGUgdGhyZWFkLCBwbGVhc2UgZmVlbApmcmVl
IHRvIENjIG1lLgoKICBMdWlzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3Jn
Cmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
