From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 04/16] generic-sections: add section core
	helpers
Date: Fri, 26 Aug 2016 13:00:24 +1000
Message-ID: <20160826130024.0ad51d33@roar.ozlabs.ibm.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642454-5679-5-git-send-email-mcgrof@kernel.org>
 <20160823112633.7d482e62@roar.ozlabs.ibm.com>
 <20160823173306.GA3296@wotan.suse.de>
 <20160824135141.2c8f06ec@roar.ozlabs.ibm.com>
 <20160824201253.GS3296@wotan.suse.de>
 <20160825120633.057b2f6f@roar.ozlabs.ibm.com>
 <20160825060540.GX3296@wotan.suse.de>
 <20160825165121.45d26fb0@roar.ozlabs.ibm.com>
 <20160825175239.GB3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20160825175239.GB3296@wotan.suse.de>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, mpe@ellerman.id.au, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, will.deacon@arm.com, korea.drzix@gmail.com, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, david.vrabel@citrix.com, linux-xtensa@linux-xtensa.org, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCAyNSBBdWcgMjAxNiAxOTo1MjozOSArMDIwMAoiTHVpcyBSLiBSb2RyaWd1ZXoiIDxt
Y2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6Cgo+IE9uIFRodSwgQXVnIDI1LCAyMDE2IGF0IDA0OjUx
OjIxUE0gKzEwMDAsIE5pY2hvbGFzIFBpZ2dpbiB3cm90ZToKPiA+IE9uIFRodSwgMjUgQXVnIDIw
MTYgMDg6MDU6NDAgKzAyMDAKPiA+ICJMdWlzIFIuIFJvZHJpZ3VleiIgPG1jZ3JvZkBrZXJuZWwu
b3JnPiB3cm90ZTogIAo+ID4gPiA+IE9oLCB0aGF0IG1ha2VzIG1vcmUgc2Vuc2UuIFRoZSBTRUNU
SU9OIHN0dWZmIGFuZCBjdXN0b20gc2VjdGlvbnMgd2FzCj4gPiA+ID4gY29uZnVzaW5nIG1lLiBJ
IHdvdWxkIHByZWZlciBqdXN0IHRvIGRyb3AgYWxsIHRoZSBMSU5VWF9TRUNUSU9OIG5hbWluZwo+
ID4gPiA+IGFuZCBtYWtlIGl0IG1hdGNoIHRoZSBmdW5jdGlvbmFsaXR5IHlvdSdyZSB1c2luZy4g
Rm9yIGV4YW1wbGU6Cj4gPiA+ID4gCj4gPiA+ID4gK0RFRklORV9MSU5LVEFCTEUoc3RydWN0IGp1
bXBfZW50cnksIF9fanVtcF90YWJsZSk7Cj4gPiA+ID4gKwo+ID4gPiA+ICAvKiBtdXRleCB0byBw
cm90ZWN0IGNvbWluZy9nb2luZyBvZiB0aGUgdGhlIGp1bXBfbGFiZWwgdGFibGUgKi8KPiA+ID4g
PiAgc3RhdGljIERFRklORV9NVVRFWChqdW1wX2xhYmVsX211dGV4KTsKPiA+ID4gPiAgCj4gPiA+
ID4gQEAgLTI3NCw4ICsyNzcsNiBAQCBzdGF0aWMgdm9pZCBfX2p1bXBfbGFiZWxfdXBkYXRlKHN0
cnVjdCBzdGF0aWNfa2V5ICprZXksCj4gPiA+ID4gIAo+ID4gPiA+ICB2b2lkIF9faW5pdCBqdW1w
X2xhYmVsX2luaXQodm9pZCkKPiA+ID4gPiAgewo+ID4gPiA+IC0Jc3RydWN0IGp1bXBfZW50cnkg
Kml0ZXJfc3RhcnQgPSBfX3N0YXJ0X19fanVtcF90YWJsZTsKPiA+ID4gPiAtCXN0cnVjdCBqdW1w
X2VudHJ5ICppdGVyX3N0b3AgPSBfX3N0b3BfX19qdW1wX3RhYmxlOwo+ID4gPiA+ICAJc3RydWN0
IHN0YXRpY19rZXkgKmtleSA9IE5VTEw7Cj4gPiA+ID4gIAlzdHJ1Y3QganVtcF9lbnRyeSAqaXRl
cjsKPiA+ID4gPiAgCj4gPiA+ID4gQEAgLTI5Miw5ICsyOTMsMTAgQEAgdm9pZCBfX2luaXQganVt
cF9sYWJlbF9pbml0KHZvaWQpCj4gPiA+ID4gIAkJcmV0dXJuOwo+ID4gPiA+ICAKPiA+ID4gPiAg
CWp1bXBfbGFiZWxfbG9jaygpOwo+ID4gPiA+IC0JanVtcF9sYWJlbF9zb3J0X2VudHJpZXMoaXRl
cl9zdGFydCwgaXRlcl9zdG9wKTsKPiA+ID4gPiArCWp1bXBfbGFiZWxfc29ydF9lbnRyaWVzKExJ
TlVYX1NFQ1RJT05fU1RBUlQoX19qdW1wX3RhYmxlKSwKPiA+ID4gPiArCQkJCUxJTlVYX1NFQ1RJ
T05fRU5EKF9fanVtcF90YWJsZSkpOwo+ID4gPiA+IAo+ID4gPiA+IE5vdyBJIHRoaW5rIHRoaXMg
aXMgYSBmaW5lIGFic3RyYWN0aW9uIHRvIGhhdmUuICAgIAo+ID4gPiAKPiA+ID4gT0sgd2lsbCBr
ZWVwIHRoaXMgb25lLgo+ID4gPiAgIAo+ID4gPiA+IEkgdGhpbmsgaXQgd291bGQgbG9vawo+ID4g
PiA+IGV2ZW4gY2xlYW5lciBpZiB5b3UgaGFkOgo+ID4gPiA+IAo+ID4gPiA+IExJTktUQUJMRV9T
VEFSVChfX2p1bXBfdGFibGUpCj4gPiA+ID4gTElOS1RBQkxFX0VORChfX2p1bXBfdGFibGUpCj4g
PiA+ID4KPiA+ID4gPiBUaGVuIGRvIHdlIG5lZWQgdG8gZXZlbiBoYXZlIHRoZSBMSU5VWF9TRUNU
SU9OIG1pZGRsZSBtYW4gYXQgYWxsPyAgICAKPiA+ID4gCj4gPiA+IEFoLCB0aGluZyBpcyB3ZSB1
c2UgdGhpcyBmb3IgYm90aCBsaW5rdGFibGVzIGFuZCBzZWN0aW9uIHJhbmdlcy4KPiA+ID4gT3Ig
ZG8gd2Ugd2FudCBtYWNyb3MgZm9yIGJvdGggdGhhdCBkbyB0aGUgc2FtZSB0aGluZyA/ICAKPiA+
IAo+ID4gSSB0aGluayBpdCB3b3VsZCBtYWtlIHRoZSBjb2RlIHVzaW5nIGl0IG1vcmUgcmVhZGFi
bGUuICAKPiAKPiBBbHJpZ2h0eS4uLiBzbzoKPiAKPiBMSU5LVEFCTEVfU1RBUlQoKQo+IExJTktU
QUJMRV9FTkQoKQo+IAo+IFNFQ1RJT05fUkFOR0VfU1RBUlQoKQo+IFNFQ1RJT05fUkFOR0VfRU5E
KCkKPiAKPiBBbmQgdGhlc2UgbWFjcm9zIGRvIHRoZSBleGFjdCBzYW1lIHRoaW5nLiBJZSwgbm90
aGluZyBzaGFyZWQuIFJpZ2h0PwoKWWVhaCBJIHRoaW5rIHNvLiBJbnRlcm5hbGx5IHRoZXkgd291
bGQgcHJvYmFibHkgYmUgYWxpYXNlZCB0byB0aGUKc2FtZSBjb21tb24gZGVmaW5pdGlvbiAodW5s
ZXNzIHlvdSBoYWQgc29tZSB0eXBlIGNoZWNrIG9yIHNvbWV0aGluZyksCmJ1dCB1c2VyIHdvdWxk
IGtub3cgYWJvdXQgc3VjaCBkZXRhaWxzLgoKVGhhbmtzLApOaWNrCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhl
bi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
