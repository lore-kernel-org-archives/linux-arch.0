From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v7 06/14] firmware/Makefile: force
 recompilation if makefile changes
Date: Mon, 23 Jan 2017 17:12:45 +0100
Message-ID: <20170123161245.GN13946@wotan.suse.de>
References: <20170109145833.11502-1-mcgrof@kernel.org>
 <20170115211057.17167-1-mcgrof@kernel.org>
 <20170115211057.17167-7-mcgrof@kernel.org>
 <20170119111915.GL28024@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20170119111915.GL28024@kroah.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: gnomes@lxorguk.ukuu.org.uk, dalias@libc.org, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, mpe@ellerman.id.au, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, wangnan0@huawei.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, will.deacon@arm.com, korea.drzix@gmail.com, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, dsahern@gmail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, bp@suse.de, linux@roeck-us.net, david.vrabel@citrix.com, linux-xtensa@linux
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCBKYW4gMTksIDIwMTcgYXQgMTI6MTk6MTVQTSArMDEwMCwgR3JlZyBLSCB3cm90ZToK
PiBPbiBTdW4sIEphbiAxNSwgMjAxNyBhdCAwMToxMDo0OVBNIC0wODAwLCBMdWlzIFIuIFJvZHJp
Z3VleiB3cm90ZToKPiA+IElmIHlvdSBtb2RpZnkgdGhlIHRhcmdldCBhc20gd2UgY3VycmVudGx5
IGRvIG5vdCBmb3JjZSB0aGUKPiA+IHJlY29tcGlsYXRpb24gb2YgdGhlIGZpcm13YXJlIGZpbGVz
LiBUaGUgdGFyZ2V0IGFzbSBpcyBpbgo+ID4gdGhlIGZpcm13YXJlL01ha2VmaWxlLCBwZWcgdGhp
cyBmaWxlIGFzIGEgZGVwZW5kZW5jeSB0bwo+ID4gcmVxdWlyZSByZS1jb21waWxhdGlvbiBvZiBm
aXJtd2FyZSB0YXJnZXRzIHdoZW4gdGhlIGFzbQo+ID4gY2hhbmdlcy4KPiA+IAo+ID4gdjM6IGlu
dHJvZHVjZWQgaW4gdGhpcyBzZXJpZXMKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTHVpcyBSLiBS
b2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwub3JnPgo+ID4gLS0tCj4gPiAgZmlybXdhcmUvTWFrZWZp
bGUgfCAzICsrLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2Zpcm13YXJlL01ha2VmaWxlIGIvZmlybXdhcmUv
TWFrZWZpbGUKPiA+IGluZGV4IGUyOTdlMWI1MjYzNi4uZmEzZTgxYzJhOTdiIDEwMDY0NAo+ID4g
LS0tIGEvZmlybXdhcmUvTWFrZWZpbGUKPiA+ICsrKyBiL2Zpcm13YXJlL01ha2VmaWxlCj4gPiBA
QCAtMTc2LDcgKzE3Niw4IEBAIHF1aWV0X2NtZF9md2JpbiA9IE1LX0ZXICAgJEAKPiA+ICB3b3Jk
c2l6ZV9kZXBzIDo9ICQod2lsZGNhcmQgaW5jbHVkZS9jb25maWcvNjRiaXQuaCBpbmNsdWRlL2Nv
bmZpZy8zMmJpdC5oIFwKPiA+ICAJCWluY2x1ZGUvY29uZmlnL3BwYzMyLmggaW5jbHVkZS9jb25m
aWcvcHBjNjQuaCBcCj4gPiAgCQlpbmNsdWRlL2NvbmZpZy9zdXBlcmgzMi5oIGluY2x1ZGUvY29u
ZmlnL3N1cGVyaDY0LmggXAo+ID4gLQkJaW5jbHVkZS9jb25maWcveDg2XzMyLmggaW5jbHVkZS9j
b25maWcveDg2XzY0LmgpCj4gPiArCQlpbmNsdWRlL2NvbmZpZy94ODZfMzIuaCBpbmNsdWRlL2Nv
bmZpZy94ODZfNjQuaCBcCj4gPiArCQlmaXJtd2FyZS9NYWtlZmlsZSkKPiA+ICAKPiA+ICAkKHBh
dHN1YnN0ICUsJChvYmopLyUuZ2VuLlMsICQoZnctc2hpcHBlZC15KSk6ICU6ICQod29yZHNpemVf
ZGVwcykKPiA+ICAJJChjYWxsIGNtZCxmd2JpbiwkKHBhdHN1YnN0ICUuZ2VuLlMsJSwkQCkpCj4g
Cj4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGlzIHBhdGNoIGlzIGluIHRoaXMgc2VyaWVzIDoo
CgpJJ3ZlIHRha2VuIGl0IG91dCBhbmQgaXQgaGFzIG5vdyBiZWVuIHJvdXRlZCB2aWEga2J1aWxk
IGZvbGtzIGFzIHlvdQpyZXF1ZXN0ZWQuCgpUaGFua3MhCgogIEx1aXMKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QK
WGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1kZXZlbAo=
