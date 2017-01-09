From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 08/14] jump_label: move guard #endif down
	where it belongs
Date: Mon,  9 Jan 2017 06:58:26 -0800
Message-ID: <20170109145833.11502-9-mcgrof@kernel.org>
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

VGhlIGVuZGluZyBoZWFkZXIgZ3VhcmQgaXMgbWlzcGxhY2VkLiBUaGlzIGhhcyBubwpmdW5jdGlv
bmFsIGNoYW5nZSwgdGhpcyBpcyBqdXN0IGFuIGV5ZS1zb3JlLgoKU2lnbmVkLW9mZi1ieTogTHVp
cyBSLiBSb2RyaWd1ZXogPG1jZ3JvZkBrZXJuZWwub3JnPgotLS0KIGluY2x1ZGUvbGludXgvanVt
cF9sYWJlbC5oIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvanVtcF9sYWJlbC5oIGIvaW5j
bHVkZS9saW51eC9qdW1wX2xhYmVsLmgKaW5kZXggYTA1NDdjNTcxODAwLi5iNjNkNmI3YjBkYjAg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvanVtcF9sYWJlbC5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvanVtcF9sYWJlbC5oCkBAIC00MDIsNiArNDAyLDYgQEAgZXh0ZXJuIGJvb2wgX19fX3dyb25n
X2JyYW5jaF9lcnJvcih2b2lkKTsKICNkZWZpbmUgc3RhdGljX2JyYW5jaF9lbmFibGUoeCkJCXN0
YXRpY19rZXlfZW5hYmxlKCYoeCktPmtleSkKICNkZWZpbmUgc3RhdGljX2JyYW5jaF9kaXNhYmxl
KHgpCXN0YXRpY19rZXlfZGlzYWJsZSgmKHgpLT5rZXkpCiAKLSNlbmRpZgkvKiBfTElOVVhfSlVN
UF9MQUJFTF9IICovCi0KICNlbmRpZiAvKiBfX0FTU0VNQkxZX18gKi8KKworI2VuZGlmCS8qIF9M
SU5VWF9KVU1QX0xBQkVMX0ggKi8KLS0gCjIuMTEuMAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVs
QGxpc3RzLnhlbi5vcmcKaHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1kZXZlbAo=
