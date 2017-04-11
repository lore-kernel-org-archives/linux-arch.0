From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
Date: Tue, 11 Apr 2017 23:39:43 +1000
Message-ID: <1491917983.7236.9.camel@kernel.crashing.org>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hoga>
List-Id: linux-arch.vger.kernel.org

T24gVHVlLCAyMDE3LTA0LTExIGF0IDEzOjI4ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToKPiArc3RhdGljIGlubGluZSB2b2lkIF9faW9tZW0gKmlvcmVtYXBfbm9wb3N0KHBoeXNfYWRk
cl90IG9mZnNldCwKPiBzaXplX3Qgc2l6ZSkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBp
b3JlbWFwX25vY2FjaGUob2Zmc2V0LCBzaXplKTsKPiArfQo+ICsKCk5vIHRoaXMgaXMgd3Jvbmcg
YXMgSSBleHBsYWluZWQuCgpUaGlzIGlzIGEgc2VtYW50aWMgdGhhdCBzaW1wbHkgKmNhbm5vdCog
YmUgZ2VuZXJpY2FsbHkgcHJvdmlkZWQgYWNjcm9zcwphcmNoaXRlY3R1cmVzIGFzIGEgbWFwcGlu
ZyBhdHRyaWJ1dGUuCgpUaGUgc29sdXRpb24gdG8geW91ciBwcm9ibGVtIGxpZXMgZWxzZXdoZXJl
LgoKQ2hlZXJzLApCZW4uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
