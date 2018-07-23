From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 06/17] x86/nops: init ideal_nops for Hygon
Date: Mon, 23 Jul 2018 21:20:26 +0800
Message-ID: <1532352037-7151-7-git-send-email-puwen@hygon.cn>
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

VGhlIGlkZWFsX25vcHMgZm9yIERoeWFuYSBwcm9jZXNzb3JzIHNob3VsZCBiZSBwNl9ub3BzLgoK
U2lnbmVkLW9mZi1ieTogUHUgV2VuIDxwdXdlbkBoeWdvbi5jbj4KLS0tCiBhcmNoL3g4Ni9rZXJu
ZWwvYWx0ZXJuYXRpdmUuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jIGIvYXJjaC94ODYv
a2VybmVsL2FsdGVybmF0aXZlLmMKaW5kZXggYTQ4MTc2My4uOGY0OTI1YiAxMDA2NDQKLS0tIGEv
YXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2FsdGVy
bmF0aXZlLmMKQEAgLTIyMiw2ICsyMjIsMTAgQEAgdm9pZCBfX2luaXQgYXJjaF9pbml0X2lkZWFs
X25vcHModm9pZCkKIAkJfQogCQlicmVhazsKIAorCWNhc2UgWDg2X1ZFTkRPUl9IWUdPTjoKKwkJ
aWRlYWxfbm9wcyA9IHA2X25vcHM7CisJCXJldHVybjsKKwogCWNhc2UgWDg2X1ZFTkRPUl9BTUQ6
CiAJCWlmIChib290X2NwdV9kYXRhLng4NiA+IDB4ZikgewogCQkJaWRlYWxfbm9wcyA9IHA2X25v
cHM7Ci0tIAoyLjcuNAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClhlbi1kZXZlbCBtYWlsaW5nIGxpc3QKWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qu
b3JnCmh0dHBzOi8vbGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4tZGV2
ZWw=
