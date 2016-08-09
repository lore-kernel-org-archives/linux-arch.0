From: Richard Fontana <fontana@sharpeleven.org>
Subject: Re: [RFC v3 00/13] linux: generalize sections,
 ranges and linker tables
Date: Tue, 9 Aug 2016 12:48:15 -0400
Message-ID: <20160809164815.fqqfflzegwjadm7s@antelope>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <20160809152429.5bb1c077@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <20160809152429.5bb1c077@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, platform-driver-x86@vger.kernel.org, paul.gortmaker@windriver.com, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, will.deacon@arm.com, korea.drzix@gmail.com, x86@kernel.org, anil.s.keshavamurthy@intel.com, torvalds@linux-foundation.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, david.vrabel@citrix.com, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb.de, realmz6@gmail.com, linux@rasmusvillemoes.dk, rusty@rustcorp.com.au, rostedt@goodmis.org, christopher.denicolo@suse.com, jbaron@akamai.com, ananth@linux.vnet.ibm.com, bp@alien8.de, jpoimboe@redhat.co
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCBBdWcgMDksIDIwMTYgYXQgMDM6MjQ6MjlQTSArMDEwMCwgT25lIFRob3VzYW5kIEdu
b21lcyB3cm90ZToKPiBJdCB3b3VsZCBhbHNvIGJlIGdvb2QgaWYgc29tZW9uZSBjbGFyaWZpZWQg
d2hldGhlciA2IGFuZCA3IGFyZSBpbnRlbmRlZAo+IHRvIGNvbWJpbmUgc28geW91IGNhbiB0YWtl
IGNvbnRyaWJ1dGVkIHBhdGNoZXMgYW5kIHB1dCB0aGVtIGluIHlvdXIgb3duCj4gcHJvcHJpZXRh
cnkgdmVyc2lvbi4gQXMgYSBub24tbGF3eWVyIHRoZSBpbnRlbnQgaXMgbm90IGNsZWFyIGF0IGFs
bC4KCjYgYW5kIDcgYXJlbid0IGludGVuZGVkIHRvIGNvbWJpbmU7IHRoZXkgYWRkcmVzcyBzZXBh
cmF0ZSBpc3N1ZXMgYW5kCmNpcmN1bXN0YW5jZXMuCgpSaWNoYXJkCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhl
bi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
