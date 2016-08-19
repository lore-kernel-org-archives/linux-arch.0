From: mcgrof@kernel.org
Subject: [PATCH v4 05/16] xtensa: skip adding literal when
	SORT() is used
Date: Fri, 19 Aug 2016 14:32:54 -0700
Message-ID: <1471642385-5629-6-git-send-email-mcgrof@kernel.org>
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

RnJvbTogIkx1aXMgUi4gUm9kcmlndWV6IiA8bWNncm9mQGtlcm5lbC5vcmc+CgpXaGVuIFNPUlQo
Zm9vLiopIGlzIHVzZWQgdGhlIGN1cnJlbnQgc2VkIHJlcGxhY2VtZW50cyBhZGQKU09SVChmb28u
bGl0ZXJhbCBmb28uKiksIHRoaXMgYnJlYWtzIGxpbmtpbmcuIEF2b2lkIGFkZGluZwpsaXRlcmFs
cyBmb3IgU09SVCBnbG9icywgaWYgbmVlZGVkLCB0aGVzZSBuZWVkIHRvIGJlIGFkZGVkCm1hbnVh
bGx5LgoKU2lnbmVkLW9mZi1ieTogTHVpcyBSLiBSb2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwub3Jn
PgotLS0KIGFyY2gveHRlbnNhL2tlcm5lbC9NYWtlZmlsZSB8IDggKysrKy0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJj
aC94dGVuc2Eva2VybmVsL01ha2VmaWxlIGIvYXJjaC94dGVuc2Eva2VybmVsL01ha2VmaWxlCmlu
ZGV4IGMzMWY1ZDVhZmM3ZC4uODE4MDg1MGVkMTQ3IDEwMDY0NAotLS0gYS9hcmNoL3h0ZW5zYS9r
ZXJuZWwvTWFrZWZpbGUKKysrIGIvYXJjaC94dGVuc2Eva2VybmVsL01ha2VmaWxlCkBAIC0yOSwx
MCArMjksMTAgQEAgQUZMQUdTX214aGVhZC5vICs9IC1tdGV4dC1zZWN0aW9uLWxpdGVyYWxzCiAj
CiAjIFJlcGxpY2F0ZSBydWxlcyBpbiBzY3JpcHRzL01ha2VmaWxlLmJ1aWxkCiAKLXNlZC15ID0g
LWUgJzphOyBzL1wqKFwoW14pXSpcKVwudGV4dFwudW5saWtlbHkvKihcMS5saXRlcmFsLnVubGlr
ZWx5IC57dGV4dH0udW5saWtlbHkvOyB0YTsgJyBcCi0JLWUgJzpiOyBzL1wqKFwoW14pXSpcKVwu
dGV4dFwoXC5bYS16XSpcKS8qKFwxLnt0ZXh0fVwyLmxpdGVyYWwgLnt0ZXh0fVwyLzsgdGI7ICcg
XAotCS1lICc6Yzsgcy9cKihcKFteKV0qXClcKFwuW2Etel0qaXRcfFwucmVmXClcLnRleHQvKihc
MVwyLmxpdGVyYWwgXDIue3RleHR9LzsgdGM7ICcgXAotCS1lICc6ZDsgcy9cKihcKFteKV1cKyBc
fFwpXC50ZXh0LyooXDEubGl0ZXJhbCAue3RleHR9LzsgdGQ7ICcgXAorc2VkLXkgPSAtZSAnOmE7
IHMvXCooXChbXilTT1JUXSpcKVwudGV4dFwudW5saWtlbHkvKihcMS5saXRlcmFsLnVubGlrZWx5
IC57dGV4dH0udW5saWtlbHkvOyB0YTsgJyBcCisJLWUgJzpiOyBzL1wqKFwoW14pU09SVF0qXClc
LnRleHRcKFwuW2Etel0qXCkvKihcMS57dGV4dH1cMi5saXRlcmFsIC57dGV4dH1cMi87IHRiOyAn
IFwKKwktZSAnOmM7IHMvXCooXChbXlNPUlQpXSpcKVwoXC5bYS16XSppdFx8XC5yZWZcKVwudGV4
dC8qKFwxXDIubGl0ZXJhbCBcMi57dGV4dH0vOyB0YzsgJyBcCisJLWUgJzpkOyBzL1wqKFwoW15T
T1JUKV1cKyBcfFwpXC50ZXh0LyooXDEubGl0ZXJhbCAue3RleHR9LzsgdGQ7ICcgXAogCS1lICdz
L1wue3RleHR9Ly50ZXh0L2cnCiAKIHF1aWV0X2NtZF9fY3BwX2xkc19TID0gTERTICAgICAkQAot
LSAKMi45LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8v
bGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
