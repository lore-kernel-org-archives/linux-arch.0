From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 04/17] x86/smpboot: smp init nodelay and no
 flush caches before sleep
Date: Mon, 23 Jul 2018 21:20:24 +0800
Message-ID: <1532352037-7151-5-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

RGh5YW5hIHVzZSBubyBkZWxheSBpbiBzbXBfcXVpcmtfaW5pdF91ZGVsYXkoKSwgYW5kIHJldHVy
biBpbgptd2FpdF9wbGF5X2RlYWQoKSBhcyBBTUQgZG9lcy4KClNpZ25lZC1vZmYtYnk6IFB1IFdl
biA8cHV3ZW5AaHlnb24uY24+Ci0tLQogYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYyB8IDQgKysr
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMgYi9hcmNoL3g4Ni9rZXJuZWwvc21wYm9v
dC5jCmluZGV4IGRiOTY1NmUuLjI2Y2IyYzkgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9z
bXBib290LmMKKysrIGIvYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYwpAQCAtNjU4LDYgKzY1OCw3
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzbXBfcXVpcmtfaW5pdF91ZGVsYXkodm9pZCkKIAogCS8q
IGlmIG1vZGVybiBwcm9jZXNzb3IsIHVzZSBubyBkZWxheSAqLwogCWlmICgoKGJvb3RfY3B1X2Rh
dGEueDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0lOVEVMKSAmJiAoYm9vdF9jcHVfZGF0YS54ODYg
PT0gNikpIHx8CisJICAgICgoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1Jf
SFlHT04pICYmIChib290X2NwdV9kYXRhLng4NiA+PSAweDE4KSkgfHwKIAkgICAgKChib290X2Nw
dV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQpICYmIChib290X2NwdV9kYXRhLng4
NiA+PSAweEYpKSkgewogCQlpbml0X3VkZWxheSA9IDA7CiAJCXJldHVybjsKQEAgLTE1NzQsNyAr
MTU3NSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtd2FpdF9wbGF5X2RlYWQodm9pZCkKIAl2b2lk
ICptd2FpdF9wdHI7CiAJaW50IGk7CiAKLQlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09
IFg4Nl9WRU5ET1JfQU1EKQorCWlmIChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZF
TkRPUl9BTUQgfHwKKwkgICAgYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1Jf
SFlHT04pCiAJCXJldHVybjsKIAlpZiAoIXRoaXNfY3B1X2hhcyhYODZfRkVBVFVSRV9NV0FJVCkp
CiAJCXJldHVybjsKLS0gCjIuNy40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVu
cHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3hlbi1kZXZlbA==
