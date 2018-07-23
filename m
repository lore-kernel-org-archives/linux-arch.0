From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 14/17] driver/acpi: enable Hygon support to
 ACPI driver
Date: Mon, 23 Jul 2018 21:20:34 +0800
Message-ID: <1532352037-7151-15-git-send-email-puwen@hygon.cn>
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

Rm9yIERoeWFuYSBwcm9jZXNzb3JzIGhhdmUgTk9OU1RPUCBUU0MgZmVhdHVyZSwgc28gZW5hYmxl
IHRoZSBzdXBwb3J0CnRvIEFDUEkgZHJpdmVyLgoKU2lnbmVkLW9mZi1ieTogUHUgV2VuIDxwdXdl
bkBoeWdvbi5jbj4KLS0tCiBkcml2ZXJzL2FjcGkvYWNwaV9wYWQuYyAgICAgICB8IDEgKwogZHJp
dmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfcGFkLmMgYi9kcml2ZXJz
L2FjcGkvYWNwaV9wYWQuYwppbmRleCA1NTJjMWY3Li5hNDc2NzZhIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2FjcGkvYWNwaV9wYWQuYworKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9wYWQuYwpAQCAtNzAs
NiArNzAsNyBAQCBzdGF0aWMgdm9pZCBwb3dlcl9zYXZpbmdfbXdhaXRfaW5pdCh2b2lkKQogCiAj
aWYgZGVmaW5lZChDT05GSUdfWDg2KQogCXN3aXRjaCAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9y
KSB7CisJY2FzZSBYODZfVkVORE9SX0hZR09OOgogCWNhc2UgWDg2X1ZFTkRPUl9BTUQ6CiAJY2Fz
ZSBYODZfVkVORE9SX0lOVEVMOgogCQkvKgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Byb2Nl
c3Nvcl9pZGxlLmMgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYwppbmRleCBhYmI1NTlj
Li5iMjEzMWM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYworKysg
Yi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYwpAQCAtMjA1LDYgKzIwNSw3IEBAIHN0YXRp
YyB2b2lkIGxhcGljX3RpbWVyX3N0YXRlX2Jyb2FkY2FzdChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3Ig
KnByLAogc3RhdGljIHZvaWQgdHNjX2NoZWNrX3N0YXRlKGludCBzdGF0ZSkKIHsKIAlzd2l0Y2gg
KGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvcikgeworCWNhc2UgWDg2X1ZFTkRPUl9IWUdPTjoKIAlj
YXNlIFg4Nl9WRU5ET1JfQU1EOgogCWNhc2UgWDg2X1ZFTkRPUl9JTlRFTDoKIAljYXNlIFg4Nl9W
RU5ET1JfQ0VOVEFVUjoKLS0gCjIuNy40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMu
eGVucHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3hlbi1kZXZlbA==
