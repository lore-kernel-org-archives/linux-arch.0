From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 06/14] firmware/Makefile: force recompilation
	if makefile changes
Date: Mon,  9 Jan 2017 06:58:24 -0800
Message-ID: <20170109145833.11502-7-mcgrof@kernel.org>
References: <20161222023811.21246-1-mcgrof@kernel.org>
 <20170109145833.11502-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20170109145833.11502-1-mcgrof@kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, linux@rasmusvillemoes.dk, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, sparclinux@vger.kernel.org, wangnan0@huawei.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, xen-devel@lists.xensource.com, msalter@redhat.com, linux-sh@vger.kernel.org, mpe@ellerman.id.au, joro@8bytes.org, x86@kernel.org, fontana@sharpeleven.org, dsahern@gmail.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, linux@roeck-us.net, linux-xtensa@linux-xtensa.org, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb.de, jani.nikula@intel.com, will.deacon@arm.com, rusty@rustcorp.com.au, rostedt@goodmis.org, ak@
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
cHMpCiAJJChjYWxsIGNtZCxmd2JpbiwkKHBhdHN1YnN0ICUuZ2VuLlMsJSwkQCkpCi0tIAoyLjEx
LjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4t
ZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMu
eGVuLm9yZy94ZW4tZGV2ZWwK
