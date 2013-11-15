From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH -tip RFC v2 20/22] [BUGFIX] kprobes: Prohibit probing on
	func_ptr_is_kernel_text
Date: Fri, 15 Nov 2013 04:54:13 +0000
Message-ID: <20131115045413.27580.91113.stgit@kbuild-fedora.novalocal>
References: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

UHJvaGliaXQgcHJvYmluZyBvbiBmdW5jX3B0cl9pc19rZXJuZWxfdGV4dCgpIGJ5IGFkZGluZwpp
dCB0byB0aGUga3Byb2JlX2JsYWNrbGlzdC4KClNpbmNlIHRoZSBmdW5jX3B0cl9pc19rZXJuZWxf
dGV4dCgpIGlzIGNhbGxlZCBmcm9tCm5vdGlmaWVyX2NhbGxfY2hhaW4oKSB3aGljaCBpcyBjYWxs
ZWQgZnJvbSBpbnQzIGhhbmRsZXIsCnByb2JpbmcgaXQgbWF5IGNhdXNlIGRvdWJsZSBpbnQzIGZh
dWx0IGFuZCBrZXJuZWwgd2lsbApyZWJvb3QuCgpUaGlzIGhhcHBlbmVzIHdoZW4gdGhlIGtlcm5l
bCBidWlsdCB3aXRoIENPTkZJR19ERUJVR19OT1RJRklFUlM9eS4KClNpZ25lZC1vZmYtYnk6IE1h
c2FtaSBIaXJhbWF0c3UgPG1hc2FtaS5oaXJhbWF0c3UucHRAaGl0YWNoaS5jb20+CkNjOiBBbmRy
ZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgpDYzogIlV3ZSBLbGVpbmUtS8O2
bmlnIiA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpDYzogQm9yaXNsYXYgUGV0a292
IDxicEBzdXNlLmRlPgpDYzogSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+Ci0tLQoga2Vy
bmVsL2V4dGFibGUuYyB8ICAgIDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9rZXJuZWwvZXh0YWJsZS5jIGIva2VybmVsL2V4dGFibGUuYwppbmRleCA4
MzJjYjI4Li44ODVjODc3IDEwMDY0NAotLS0gYS9rZXJuZWwvZXh0YWJsZS5jCisrKyBiL2tlcm5l
bC9leHRhYmxlLmMKQEAgLTIwLDYgKzIwLDcgQEAKICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4K
ICNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KKyNpbmNs
dWRlIDxsaW51eC9rcHJvYmVzLmg+CiAKICNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4KICNpbmNs
dWRlIDxhc20vdWFjY2Vzcy5oPgpAQCAtMTM3LDMgKzEzOCw0IEBAIGludCBmdW5jX3B0cl9pc19r
ZXJuZWxfdGV4dCh2b2lkICpwdHIpCiAJCXJldHVybiAxOwogCXJldHVybiBpc19tb2R1bGVfdGV4
dF9hZGRyZXNzKGFkZHIpOwogfQorTk9LUFJPQkVfU1lNQk9MKGZ1bmNfcHRyX2lzX2tlcm5lbF90
ZXh0KTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
