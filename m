From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/4] kasan: Document support on 32-bit powerpc
Date: Tue, 10 Dec 2019 07:40:55 +0100
Message-ID: <8b64ce35-01df-3c0f-2695-40633c324331@c-s.fr>
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-4-dja@axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191210044714.27265-4-dja@axtens.net>
Content-Language: fr
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
List-Id: linux-arch.vger.kernel.org

CgpMZSAxMC8xMi8yMDE5IMOgIDA1OjQ3LCBEYW5pZWwgQXh0ZW5zIGEgw6ljcml0wqA6Cj4gS0FT
QU4gaXMgc3VwcG9ydGVkIG9uIDMyLWJpdCBwb3dlcnBjIGFuZCB0aGUgZG9jcyBzaG91bGQgcmVm
bGVjdCB0aGlzLgo+IAo+IFN1Z2dlc3RlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3Bo
ZS5sZXJveUBjLXMuZnI+Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEF4dGVucyA8ZGphQGF4dGVu
cy5uZXQ+CgpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBj
LXMuZnI+Cgo+IC0tLQo+ICAgRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0IHwgIDMg
KystCj4gICBEb2N1bWVudGF0aW9uL3Bvd2VycGMva2FzYW4udHh0ICAgfCAxMiArKysrKysrKysr
KysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vcG93ZXJwYy9rYXNhbi50eHQKPiAK
CkNocmlzdG9waGUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
