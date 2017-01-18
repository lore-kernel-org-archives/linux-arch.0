From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v7 02/14] xtensa: skip adding literal when
	SORT() is used
Date: Wed, 18 Jan 2017 12:29:51 +0100
Message-ID: <20170118112951.62drjsk264rhe5lj@pd.tnic>
References: <20170109145833.11502-1-mcgrof@kernel.org>
 <20170115211057.17167-1-mcgrof@kernel.org>
 <20170115211057.17167-3-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20170115211057.17167-3-mcgrof@kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk, dalias@libc.org, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, mpe@ellerman.id.au, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, wangnan0@huawei.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, will.deacon@arm.com, korea.drzix@gmail.com, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, dsahern@gmail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, linux@roeck-us.net, david.vrabel@citrix.com, linux-xte
List-Id: linux-arch.vger.kernel.org

T24gU3VuLCBKYW4gMTUsIDIwMTcgYXQgMDE6MTA6NDVQTSAtMDgwMCwgTHVpcyBSLiBSb2RyaWd1
ZXogd3JvdGU6Cj4gV2hlbiBTT1JUKGZvby4qKSBpcyB1c2VkIHRoZSBjdXJyZW50IHNlZCByZXBs
YWNlbWVudHMgYWRkCj4gU09SVChmb28ubGl0ZXJhbCBmb28uKiksIHRoaXMgYnJlYWtzIGxpbmtp
bmcuIEF2b2lkIGFkZGluZwo+IGxpdGVyYWxzIGZvciBTT1JUIGdsb2JzLCBpZiBuZWVkZWQsIHRo
ZXNlIG5lZWQgdG8gYmUgYWRkZWQKPiBtYW51YWxseS4KClBsZWFzZSByZXdyaXRlIHRoaXMgY29t
bWl0IG1lc3NhZ2UgYnkgYnJlYWtpbmcgaW50byBzZXBhcmF0ZSBzZW50ZW5jZXMsCmFkZGluZyBw
dW5jdHVhdGlvbiwgZXRjLgoKQWxzbywgInRoZSBjdXJyZW50IHNlZCByZXBsYWNlbWVudHMgYWRk
IiBzb3VuZHMgcmVhbGx5IHN0cmFuZ2UgYW5kIG1ha2VzCm1lIHdvbmRlciB3aGF0IGRvIHlvdSBt
ZWFuLiBXaGF0IGFyZSAic2VkIHJlcGxhY2VtZW50cyI/IEkgdGhpbmsgeW91Cm1lYW4gdGhlICJz
ZWQgcmVnZXggYWRkcyIgZnJvbSBsb29raW5nIGF0IHRoZSBkaWZmLgoKLS0gClJlZ2FyZHMvR3J1
c3MsCiAgICBCb3Jpcy4KClNVU0UgTGludXggR21iSCwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwg
SmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbiwgSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCi0t
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRl
dmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhl
bi5vcmcveGVuLWRldmVsCg==
