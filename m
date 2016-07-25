From: Richard Fontana <fontana@sharpeleven.org>
Subject: Re: [RFC v3 00/13] linux: generalize sections,
 ranges and linker tables
Date: Mon, 25 Jul 2016 09:55:32 -0400
Message-ID: <f0947242-a917-d036-694d-5f01f5e77d01@sharpeleven.org>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <20160725223229.7de71264e9e6ec8d635ee785@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20160725223229.7de71264e9e6ec8d635ee785@kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, platform-driver-x86@vger.kernel.org, paul.gortmaker@windriver.com, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, will.deacon@arm.com, korea.drzix@gmail.com, x86@kernel.org, anil.s.keshavamurthy@intel.com, torvalds@linux-foundation.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb.de, realmz6@gmail.com, linux@rasmusvillemoes.dk, rusty@rustcorp.com.au, rostedt@goodmis.org, christopher.denicolo@suse.com, jbaron@akamai.com, ananth@linux.vnet.ibm.com, bp@alien8.de, jpoimboe@redhat
List-Id: linux-arch.vger.kernel.org

T24gMDcvMjUvMjAxNiAwOTozMiBBTSwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToKCj4gSSdtIG5v
dCBhIGxhd3llciwgc28gSSBkb24ndCBrbm93IHJlYWxseSBpdCBpcyBjb21wYXRpYmxlIHdpdGgg
R1BMdjIsCj4gYW5kIGlmIGl0IGlzLCBJJ20gbm90IHN1cmUgdGhlIHJlYXNvbiB3aHkgd2UgbmVl
ZCBhbm90aGVyIGxpY2Vuc2UuCj4gQUZBSUNTIHRoZSBsaWNlbnNlIHRlcm1zLCBtb3N0IG9mIHBh
cnRzIGxvb2tzIHJlYXNvbmFibGUuIEkganVzdCBjb25jZXJuCj4gY2xhdXNlIDgsIGFmdGVyIGZp
ZnRlZW4geWVhcnMsIGlzIHRoYXQgc3RpbGwgR1BMdjIgY29tcGF0aWJsZT8KPiAoSSdkIGxpa2Ug
c2VlIEZBUSBhYm91dCB0aGlzIGxpY2Vuc2UuLi4pCgpZZXMsIGFmdGVyIGZpZnRlZW4geWVhcnMg
dGhlIHJlc3RyaWN0aW9ucyBpbiB0aGUgbGljZW5zZSB0aGF0IG1ha2UgaXQKY29weWxlZnQgcmF0
aGVyIHRoYW4gcGVybWlzc2l2ZSBkaXNhcHBlYXIsIGFuZCB0aGUgbGljZW5zZSBpcwp0cmFuc2Zv
cm1lZCBpbnRvIGEgc2ltcGxlLCBlc3NlbnRpYWxseSB1bmNvbmRpdGlvbmFsLCBwZXJtaXNzaXZl
IG9wZW4Kc291cmNlIGxpY2Vuc2UuCgpSaWNoYXJkCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVs
QGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1kZXZlbAo=
