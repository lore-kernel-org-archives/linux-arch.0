From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/6] tools: add init.h for tools
Date: Thu, 19 Jan 2017 12:02:21 +0100
Message-ID: <20170119110221.GB28024@kroah.com>
References: <20170109150249.11667-1-mcgrof@kernel.org>
 <20170115211215.17216-1-mcgrof@kernel.org>
 <20170115211215.17216-3-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20170115211215.17216-3-mcgrof@kernel.org>
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

T24gU3VuLCBKYW4gMTUsIDIwMTcgYXQgMDE6MTI6MTFQTSAtMDgwMCwgTHVpcyBSLiBSb2RyaWd1
ZXogd3JvdGU6Cj4gU3RhcnQgb2ZmIHdpdGgganVzdCBfX3JlZiAtLSB3ZSBlbmFsYmUgeW91IHRv
IG92ZXJyaWRlLCBpZiB5b3UgZG8KPiB0aGF0IHRoZW4geW91IGNhbiBkZWZpbmUgeW91ciBvd24u
CgpJIGhhdmUgbm8gaWRlYSB3aGF0IHRoaXMgbWVhbnMsIGRvIHlvdT8KCj4gVGhlIHdheSB5b3Un
ZCB1c2UgdGhpcywgaWYgeW91Cj4gZG8gb3ZlcnJpZGUsIGlzIGRlZmluZSB5b3VyIG93biBfX3Jl
ZiBhbmQgdGhlbiB1c2UgaW5jbHVkZV9uZXh0LgoKSHVoPwoKQWdhaW4sIHBsZWFzZSBiZSBtb3Jl
IHNwZWNpZmljIG9yIGNsZWFyIG9yIHNvbWV0aGluZywgSSBoYXZlIG5vIGlkZWEKYWdhaW4gd2hh
dCB0aGlzIHBhdGNoIGlzIGZvci4KCnRoYW5rcywKCmdyZWcgay1oCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhl
bi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
