From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 02/14] xtensa: skip adding literal when
	SORT() is used
Date: Mon,  9 Jan 2017 06:58:20 -0800
Message-ID: <20170109145833.11502-3-mcgrof@kernel.org>
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

V2hlbiBTT1JUKGZvby4qKSBpcyB1c2VkIHRoZSBjdXJyZW50IHNlZCByZXBsYWNlbWVudHMgYWRk
ClNPUlQoZm9vLmxpdGVyYWwgZm9vLiopLCB0aGlzIGJyZWFrcyBsaW5raW5nLiBBdm9pZCBhZGRp
bmcKbGl0ZXJhbHMgZm9yIFNPUlQgZ2xvYnMsIGlmIG5lZWRlZCwgdGhlc2UgbmVlZCB0byBiZSBh
ZGRlZAptYW51YWxseS4KClNpZ25lZC1vZmYtYnk6IEx1aXMgUi4gUm9kcmlndWV6IDxtY2dyb2ZA
a2VybmVsLm9yZz4KLS0tCiBhcmNoL3h0ZW5zYS9rZXJuZWwvTWFrZWZpbGUgfCA4ICsrKystLS0t
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2FyY2gveHRlbnNhL2tlcm5lbC9NYWtlZmlsZSBiL2FyY2gveHRlbnNhL2tlcm5lbC9N
YWtlZmlsZQppbmRleCAyNjRmYjg5YzQ0NGUuLmNjZWRkMDE2YThlMCAxMDA2NDQKLS0tIGEvYXJj
aC94dGVuc2Eva2VybmVsL01ha2VmaWxlCisrKyBiL2FyY2gveHRlbnNhL2tlcm5lbC9NYWtlZmls
ZQpAQCAtMzAsMTAgKzMwLDEwIEBAIEFGTEFHU19teGhlYWQubyArPSAtbXRleHQtc2VjdGlvbi1s
aXRlcmFscwogIwogIyBSZXBsaWNhdGUgcnVsZXMgaW4gc2NyaXB0cy9NYWtlZmlsZS5idWlsZAog
Ci1zZWQteSA9IC1lICc6YTsgcy9cKihcKFteKV0qXClcLnRleHRcLnVubGlrZWx5LyooXDEubGl0
ZXJhbC51bmxpa2VseSAue3RleHR9LnVubGlrZWx5LzsgdGE7ICcgXAotCS1lICc6Yjsgcy9cKihc
KFteKV0qXClcLnRleHRcKFwuW2Etel0qXCkvKihcMS57dGV4dH1cMi5saXRlcmFsIC57dGV4dH1c
Mi87IHRiOyAnIFwKLQktZSAnOmM7IHMvXCooXChbXildKlwpXChcLlthLXpdKml0XHxcLnJlZlwp
XC50ZXh0LyooXDFcMi5saXRlcmFsIFwyLnt0ZXh0fS87IHRjOyAnIFwKLQktZSAnOmQ7IHMvXCoo
XChbXildXCsgXHxcKVwudGV4dC8qKFwxLmxpdGVyYWwgLnt0ZXh0fS87IHRkOyAnIFwKK3NlZC15
ID0gLWUgJzphOyBzL1wqKFwoW14pU09SVF0qXClcLnRleHRcLnVubGlrZWx5LyooXDEubGl0ZXJh
bC51bmxpa2VseSAue3RleHR9LnVubGlrZWx5LzsgdGE7ICcgXAorCS1lICc6Yjsgcy9cKihcKFte
KVNPUlRdKlwpXC50ZXh0XChcLlthLXpdKlwpLyooXDEue3RleHR9XDIubGl0ZXJhbCAue3RleHR9
XDIvOyB0YjsgJyBcCisJLWUgJzpjOyBzL1wqKFwoW15TT1JUKV0qXClcKFwuW2Etel0qaXRcfFwu
cmVmXClcLnRleHQvKihcMVwyLmxpdGVyYWwgXDIue3RleHR9LzsgdGM7ICcgXAorCS1lICc6ZDsg
cy9cKihcKFteU09SVCldXCsgXHxcKVwudGV4dC8qKFwxLmxpdGVyYWwgLnt0ZXh0fS87IHRkOyAn
IFwKIAktZSAncy9cLnt0ZXh0fS8udGV4dC9nJwogCiBxdWlldF9jbWRfX2NwcF9sZHNfUyA9IExE
UyAgICAgJEAKLS0gCjIuMTEuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbi5v
cmcKaHR0cHM6Ly9saXN0cy54ZW4ub3JnL3hlbi1kZXZlbAo=
