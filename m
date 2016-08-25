From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 04/16] generic-sections: add section core
	helpers
Date: Thu, 25 Aug 2016 19:52:39 +0200
Message-ID: <20160825175239.GB3296@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642454-5679-5-git-send-email-mcgrof@kernel.org>
 <20160823112633.7d482e62@roar.ozlabs.ibm.com>
 <20160823173306.GA3296@wotan.suse.de>
 <20160824135141.2c8f06ec@roar.ozlabs.ibm.com>
 <20160824201253.GS3296@wotan.suse.de>
 <20160825120633.057b2f6f@roar.ozlabs.ibm.com>
 <20160825060540.GX3296@wotan.suse.de>
 <20160825165121.45d26fb0@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20160825165121.45d26fb0@roar.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, mpe@ellerman.id.au, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, will.deacon@arm.com, korea.drzix@gmail.com, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, david.vrabel@citrix.com, linux-xtensa@linux-xtensa.org, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCBBdWcgMjUsIDIwMTYgYXQgMDQ6NTE6MjFQTSArMTAwMCwgTmljaG9sYXMgUGlnZ2lu
IHdyb3RlOgo+IE9uIFRodSwgMjUgQXVnIDIwMTYgMDg6MDU6NDAgKzAyMDAKPiAiTHVpcyBSLiBS
b2RyaWd1ZXoiIDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiA+IE9oLCB0aGF0IG1ha2Vz
IG1vcmUgc2Vuc2UuIFRoZSBTRUNUSU9OIHN0dWZmIGFuZCBjdXN0b20gc2VjdGlvbnMgd2FzCj4g
PiA+IGNvbmZ1c2luZyBtZS4gSSB3b3VsZCBwcmVmZXIganVzdCB0byBkcm9wIGFsbCB0aGUgTElO
VVhfU0VDVElPTiBuYW1pbmcKPiA+ID4gYW5kIG1ha2UgaXQgbWF0Y2ggdGhlIGZ1bmN0aW9uYWxp
dHkgeW91J3JlIHVzaW5nLiBGb3IgZXhhbXBsZToKPiA+ID4gCj4gPiA+ICtERUZJTkVfTElOS1RB
QkxFKHN0cnVjdCBqdW1wX2VudHJ5LCBfX2p1bXBfdGFibGUpOwo+ID4gPiArCj4gPiA+ICAvKiBt
dXRleCB0byBwcm90ZWN0IGNvbWluZy9nb2luZyBvZiB0aGUgdGhlIGp1bXBfbGFiZWwgdGFibGUg
Ki8KPiA+ID4gIHN0YXRpYyBERUZJTkVfTVVURVgoanVtcF9sYWJlbF9tdXRleCk7Cj4gPiA+ICAK
PiA+ID4gQEAgLTI3NCw4ICsyNzcsNiBAQCBzdGF0aWMgdm9pZCBfX2p1bXBfbGFiZWxfdXBkYXRl
KHN0cnVjdCBzdGF0aWNfa2V5ICprZXksCj4gPiA+ICAKPiA+ID4gIHZvaWQgX19pbml0IGp1bXBf
bGFiZWxfaW5pdCh2b2lkKQo+ID4gPiAgewo+ID4gPiAtCXN0cnVjdCBqdW1wX2VudHJ5ICppdGVy
X3N0YXJ0ID0gX19zdGFydF9fX2p1bXBfdGFibGU7Cj4gPiA+IC0Jc3RydWN0IGp1bXBfZW50cnkg
Kml0ZXJfc3RvcCA9IF9fc3RvcF9fX2p1bXBfdGFibGU7Cj4gPiA+ICAJc3RydWN0IHN0YXRpY19r
ZXkgKmtleSA9IE5VTEw7Cj4gPiA+ICAJc3RydWN0IGp1bXBfZW50cnkgKml0ZXI7Cj4gPiA+ICAK
PiA+ID4gQEAgLTI5Miw5ICsyOTMsMTAgQEAgdm9pZCBfX2luaXQganVtcF9sYWJlbF9pbml0KHZv
aWQpCj4gPiA+ICAJCXJldHVybjsKPiA+ID4gIAo+ID4gPiAgCWp1bXBfbGFiZWxfbG9jaygpOwo+
ID4gPiAtCWp1bXBfbGFiZWxfc29ydF9lbnRyaWVzKGl0ZXJfc3RhcnQsIGl0ZXJfc3RvcCk7Cj4g
PiA+ICsJanVtcF9sYWJlbF9zb3J0X2VudHJpZXMoTElOVVhfU0VDVElPTl9TVEFSVChfX2p1bXBf
dGFibGUpLAo+ID4gPiArCQkJCUxJTlVYX1NFQ1RJT05fRU5EKF9fanVtcF90YWJsZSkpOwo+ID4g
PiAKPiA+ID4gTm93IEkgdGhpbmsgdGhpcyBpcyBhIGZpbmUgYWJzdHJhY3Rpb24gdG8gaGF2ZS4g
IAo+ID4gCj4gPiBPSyB3aWxsIGtlZXAgdGhpcyBvbmUuCj4gPiAKPiA+ID4gSSB0aGluayBpdCB3
b3VsZCBsb29rCj4gPiA+IGV2ZW4gY2xlYW5lciBpZiB5b3UgaGFkOgo+ID4gPiAKPiA+ID4gTElO
S1RBQkxFX1NUQVJUKF9fanVtcF90YWJsZSkKPiA+ID4gTElOS1RBQkxFX0VORChfX2p1bXBfdGFi
bGUpCj4gPiA+Cj4gPiA+IFRoZW4gZG8gd2UgbmVlZCB0byBldmVuIGhhdmUgdGhlIExJTlVYX1NF
Q1RJT04gbWlkZGxlIG1hbiBhdCBhbGw/ICAKPiA+IAo+ID4gQWgsIHRoaW5nIGlzIHdlIHVzZSB0
aGlzIGZvciBib3RoIGxpbmt0YWJsZXMgYW5kIHNlY3Rpb24gcmFuZ2VzLgo+ID4gT3IgZG8gd2Ug
d2FudCBtYWNyb3MgZm9yIGJvdGggdGhhdCBkbyB0aGUgc2FtZSB0aGluZyA/Cj4gCj4gSSB0aGlu
ayBpdCB3b3VsZCBtYWtlIHRoZSBjb2RlIHVzaW5nIGl0IG1vcmUgcmVhZGFibGUuCgpBbHJpZ2h0
eS4uLiBzbzoKCkxJTktUQUJMRV9TVEFSVCgpCkxJTktUQUJMRV9FTkQoKQoKU0VDVElPTl9SQU5H
RV9TVEFSVCgpClNFQ1RJT05fUkFOR0VfRU5EKCkKCkFuZCB0aGVzZSBtYWNyb3MgZG8gdGhlIGV4
YWN0IHNhbWUgdGhpbmcuIEllLCBub3RoaW5nIHNoYXJlZC4gUmlnaHQ/CgogIEx1aXMKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWls
aW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hl
bi1kZXZlbAo=
