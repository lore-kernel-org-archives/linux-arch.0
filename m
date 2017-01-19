From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 6/6] tools: add userspace linker table
	sandbox
Date: Thu, 19 Jan 2017 12:07:42 +0100
Message-ID: <20170119110742.GG28024@kroah.com>
References: <20170109150249.11667-1-mcgrof@kernel.org>
 <20170115211215.17216-1-mcgrof@kernel.org>
 <20170115211215.17216-7-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20170115211215.17216-7-mcgrof@kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk, dalias@libc.org, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, mpe@ellerman.id.au, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, wangnan0@huawei.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, will.deacon@arm.com, korea.drzix@gmail.com, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, dsahern@gmail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, bp@suse.de, linux@roeck-us.net, david.vrabel@citrix.com, linux-xtensa@linux
List-Id: linux-arch.vger.kernel.org

T24gU3VuLCBKYW4gMTUsIDIwMTcgYXQgMDE6MTI6MTVQTSAtMDgwMCwgTHVpcyBSLiBSb2RyaWd1
ZXogd3JvdGU6Cj4gQWRkIGEgdXNlcnNwYWNlIHNhbmRib3ggdG8gYWxsb3cgZWFzeSBleHBlcmlt
ZW50YXRpb24gYW5kCj4gdGVzdCBleHRlbnNpb25zIHdpdGggbGlua2VyIHRhYmxlcywgc2VjdGlv
biByYW5nZXMgYW5kIHRoZQo+IG5ldyBzZWN0aW9uIGNvcmUgZGVmaW5pdGlvbnMuCj4gCj4gVGhl
IHVzZXJzcGFjZSBzYW5kYm94IHRyaWVzIHRvIG1pbWljIHRoZSBMaW51eCBrZXJuZWwgZGV2ZWxv
cG1lbnQKPiBmbG93IGFzIG11Y2ggYXMgcG9zc2libGUsIGl0IGhvd2V2ZXIgcmVsaWVzIG9uIGFu
ZCB1c2VzIGxpYmMuIFN1cHBvcnQKPiBpcyBjdXJyZW50bHkgb25seSBwcm92aWRlZCB0byB4ODZf
NjQuCgpXaHkgaXMgeDg2XzY0IGEgcmVxdWlyZW1lbnQ/Cgo+IAo+IERlbW8gcnVuOgo+IAo+IGNk
IHRvb2xzL2xpbmtlci10YWJsZXMKPiBtYWtlIGNsZWFuOyBtYWtlOwo+IC4vZGVtbwo+IEluaXRp
YWxpemluZyB4ODYgYmFyZSBtZXRhbCB3b3JsZAo+IHg4Ni1pbml0OiBOdW1iZXIgb2YgaW5pdCBl
bnRyaWVzOiA4Cj4gSW5pdGlhbGl6aW5nIG1lbW9yeSAuLi4KPiBDb21wbGV0ZWQgaW5pdGlhbGl6
aW5nIG1lbW9yeSAhCj4gSW5pdGlhbGl6aW5nIHBjaSAuLi4KPiBQQ0kgZml4dXAgc2l6ZTogMQo+
IERlbW86IFVzaW5nIExJTktUQUJMRV9GT1JfRUFDSAo+IGZvb19maXh1cAo+IERlbW86IFVzaW5n
IExJTktUQUJMRV9SVU5fQUxMCj4gZm9vX2ZpeHVwCj4gQ29tcGxldGVkIGluaXRpYWxpemluZyBw
Y2kgIQo+IE51bWJlciBvZiBpbml0IGVudHJpZXM6IDEKPiBJbml0aWFsaXppbmcga3Byb2JlcyAu
Li4KPiA9PSBPSzogdGVzdF9rcHJvYmVfMDAwMSB3aXRoaW4gcmFuZ2UhCj4gPT0gT0s6IHRlc3Rf
a3Byb2JlXzAwMDIgbm90IGluIHJhbmdlIGFzIGV4cGVjdGVkIQo+IENvbXBsZXRlZCBpbml0aWFs
aXppbmcga3Byb2JlcyAhCj4gSW5pdGlhbGl6aW5nIGthc2FuIC4uLgo+IEVhcmx5IGluaXQgZm9y
IEthc2FuLi4uCj4gQ29tcGxldGVkIGluaXRpYWxpemluZyBrYXNhbiAhCj4gSW5pdGlhbGl6aW5n
IGJldGEgLi4uCj4gQ29tcGxldGVkIGluaXRpYWxpemluZyBiZXRhICEKPiBJbml0aWFsaXppbmcg
YWxwaGEgLi4uCj4gQ29tcGxldGVkIGluaXRpYWxpemluZyBhbHBoYSAhCj4gQm9vdGluZyBiYXJl
IG1ldGFsCj4gQ2FsbGluZyBzdGFydF9rZXJuZWwoKS4uLgo+IEFDTUU6IEluaXRpYWxpemluZyAu
Li4KPiBBQ01FOiBGaW5pc2hlZCBpbml0IC4uLiAhCj4gU3ludGhldGljczogc3ludGhfaW5pdF9v
cigyKSByZXR1cm5zOiAweERFQURCRUVGCj4gU3ludGhldGljczogcHNfc2hyKDB4REVBREJFRUYs
IGdldF9kZW1vX3NocikgcmV0dXJuczogMHgwMDAwREVBRAoKV2h5IGlzbid0IHRoaXMgdGllZCBp
bnRvIHRoZSBrZXJuZWwgdGVzdGluZyBmcmFtZXdvcms/Cgp0aGFua3MsCgpncmVnIGstaAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1h
aWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5vcmcv
eGVuLWRldmVsCg==
