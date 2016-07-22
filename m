From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v3 08/13] firmware/Makefile: force recompilation
	if makefile changes
Date: Fri, 22 Jul 2016 14:24:42 -0700
Message-ID: <1469222687-1600-9-git-send-email-mcgrof@kernel.org>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, linux@rasmusvillemoes.dk, platform-driver-x86@vger.kernel.org, paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, linux-sh@vger.kernel.org, x86@kernel.org, fontana@sharpeleven.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb.de, will.deacon@arm.com, rusty@rustcorp.com.au, rostedt@goodmis.org, christopher.denicolo@suse.com, ak@linux.intel.com, ciaran.farrell@suse.com, jpoimboe@redhat.com, andriy.shevchenko@linux.intel.com, mcb30@ipxe.org, linux-kbuild@vger.kernel.org, alan@linux.intel.com, jgross@suse.com, pebolle@tiscali.nl, tony.luck@intel.com, ananth@in.ibm.com, gregk
List-Id: linux-arch.vger.kernel.org

SWYgeW91IG1vZGlmeSB0aGUgdGFyZ2V0IGFzbSB3ZSBjdXJyZW50bHkgZG8gbm90IGZvcmNlIHRo
ZQpyZWNvbXBpbGF0aW9uIG9mIHRoZSBmaXJtd2FyZSBmaWxlcy4gVGhlIHRhcmdldCBhc20gaXMg
aW4KdGhlIGZpcm13YXJlL01ha2VmaWxlLCBwZWcgdGhpcyBmaWxlIGFzIGEgZGVwZW5kZW5jeSB0
bwpyZXF1aXJlIHJlLWNvbXBpbGF0aW9uIG9mIGZpcm13YXJlIHRhcmdldHMgd2hlbiB0aGUgYXNt
CmNoYW5nZXMuCgp2MzogaW50cm9kdWNlZCBpbiB0aGlzIHNlcmllcwoKU2lnbmVkLW9mZi1ieTog
THVpcyBSLiBSb2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwub3JnPgotLS0KIGZpcm13YXJlL01ha2Vm
aWxlIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9maXJtd2FyZS9NYWtlZmlsZSBiL2Zpcm13YXJlL01ha2VmaWxlCmlu
ZGV4IGUyOTdlMWI1MjYzNi4uZmEzZTgxYzJhOTdiIDEwMDY0NAotLS0gYS9maXJtd2FyZS9NYWtl
ZmlsZQorKysgYi9maXJtd2FyZS9NYWtlZmlsZQpAQCAtMTc2LDcgKzE3Niw4IEBAIHF1aWV0X2Nt
ZF9md2JpbiA9IE1LX0ZXICAgJEAKIHdvcmRzaXplX2RlcHMgOj0gJCh3aWxkY2FyZCBpbmNsdWRl
L2NvbmZpZy82NGJpdC5oIGluY2x1ZGUvY29uZmlnLzMyYml0LmggXAogCQlpbmNsdWRlL2NvbmZp
Zy9wcGMzMi5oIGluY2x1ZGUvY29uZmlnL3BwYzY0LmggXAogCQlpbmNsdWRlL2NvbmZpZy9zdXBl
cmgzMi5oIGluY2x1ZGUvY29uZmlnL3N1cGVyaDY0LmggXAotCQlpbmNsdWRlL2NvbmZpZy94ODZf
MzIuaCBpbmNsdWRlL2NvbmZpZy94ODZfNjQuaCkKKwkJaW5jbHVkZS9jb25maWcveDg2XzMyLmgg
aW5jbHVkZS9jb25maWcveDg2XzY0LmggXAorCQlmaXJtd2FyZS9NYWtlZmlsZSkKIAogJChwYXRz
dWJzdCAlLCQob2JqKS8lLmdlbi5TLCAkKGZ3LXNoaXBwZWQteSkpOiAlOiAkKHdvcmRzaXplX2Rl
cHMpCiAJJChjYWxsIGNtZCxmd2JpbiwkKHBhdHN1YnN0ICUuZ2VuLlMsJSwkQCkpCi0tIAoyLjgu
NAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClhlbi1k
ZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9saXN0cy54
ZW4ub3JnL3hlbi1kZXZlbAo=
