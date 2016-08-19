From: mcgrof@kernel.org
Subject: [PATCH v4 09/16] firmware/Makefile: force recompilation
	if makefile changes
Date: Fri, 19 Aug 2016 14:32:58 -0700
Message-ID: <1471642385-5629-10-git-send-email-mcgrof@kernel.org>
References: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1471642385-5629-1-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, linux@rasmusvillemoes.dk, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, sparclinux@vger.kernel.org, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, xen-devel@lists.xensource.com, msalter@redhat.com, linux-sh@vger.kernel.org, mpe@ellerman.id.au, x86@kernel.org, fontana@sharpeleven.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, linux-xtensa@linux-xtensa.org, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb.de, jani.nikula@intel.com, will.deacon@arm.com, rusty@rustcorp.com.au, rostedt@goodmis.org, acme@redhat.com, ak@linux.intel.com, andriy.shevchenko@linux.intel.com, mcb30@ip
List-Id: linux-arch.vger.kernel.org

RnJvbTogIkx1aXMgUi4gUm9kcmlndWV6IiA8bWNncm9mQGtlcm5lbC5vcmc+CgpJZiB5b3UgbW9k
aWZ5IHRoZSB0YXJnZXQgYXNtIHdlIGN1cnJlbnRseSBkbyBub3QgZm9yY2UgdGhlCnJlY29tcGls
YXRpb24gb2YgdGhlIGZpcm13YXJlIGZpbGVzLiBUaGUgdGFyZ2V0IGFzbSBpcyBpbgp0aGUgZmly
bXdhcmUvTWFrZWZpbGUsIHBlZyB0aGlzIGZpbGUgYXMgYSBkZXBlbmRlbmN5IHRvCnJlcXVpcmUg
cmUtY29tcGlsYXRpb24gb2YgZmlybXdhcmUgdGFyZ2V0cyB3aGVuIHRoZSBhc20KY2hhbmdlcy4K
CnYzOiBpbnRyb2R1Y2VkIGluIHRoaXMgc2VyaWVzCgpTaWduZWQtb2ZmLWJ5OiBMdWlzIFIuIFJv
ZHJpZ3VleiA8bWNncm9mQGtlcm5lbC5vcmc+Ci0tLQogZmlybXdhcmUvTWFrZWZpbGUgfCAzICsr
LQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2Zpcm13YXJlL01ha2VmaWxlIGIvZmlybXdhcmUvTWFrZWZpbGUKaW5kZXggZTI5N2Ux
YjUyNjM2Li5mYTNlODFjMmE5N2IgMTAwNjQ0Ci0tLSBhL2Zpcm13YXJlL01ha2VmaWxlCisrKyBi
L2Zpcm13YXJlL01ha2VmaWxlCkBAIC0xNzYsNyArMTc2LDggQEAgcXVpZXRfY21kX2Z3YmluID0g
TUtfRlcgICAkQAogd29yZHNpemVfZGVwcyA6PSAkKHdpbGRjYXJkIGluY2x1ZGUvY29uZmlnLzY0
Yml0LmggaW5jbHVkZS9jb25maWcvMzJiaXQuaCBcCiAJCWluY2x1ZGUvY29uZmlnL3BwYzMyLmgg
aW5jbHVkZS9jb25maWcvcHBjNjQuaCBcCiAJCWluY2x1ZGUvY29uZmlnL3N1cGVyaDMyLmggaW5j
bHVkZS9jb25maWcvc3VwZXJoNjQuaCBcCi0JCWluY2x1ZGUvY29uZmlnL3g4Nl8zMi5oIGluY2x1
ZGUvY29uZmlnL3g4Nl82NC5oKQorCQlpbmNsdWRlL2NvbmZpZy94ODZfMzIuaCBpbmNsdWRlL2Nv
bmZpZy94ODZfNjQuaCBcCisJCWZpcm13YXJlL01ha2VmaWxlKQogCiAkKHBhdHN1YnN0ICUsJChv
YmopLyUuZ2VuLlMsICQoZnctc2hpcHBlZC15KSk6ICU6ICQod29yZHNpemVfZGVwcykKIAkkKGNh
bGwgY21kLGZ3YmluLCQocGF0c3Vic3QgJS5nZW4uUywlLCRAKSkKLS0gCjIuOS4yCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxp
bmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5vcmcveGVu
LWRldmVsCg==
