From: Dr. Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Subject: Re: [Question] New mmap64 syscall?
Date: Wed, 7 Dec 2016 12:07:24 +0100
Message-ID: <0F280FED-870A-42B5-ABC4-1976ACA32462@theobroma-systems.com>
References: <20161206185440.GA4654@yury-N73SV> <3014428.VXGdOARdm1@wuerfel>
 <20161207103451.GA869@yury-N73SV>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161207103451.GA869@yury-N73SV>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: szabolcs.nagy@arm.com, Catalin Marinas <catalin.marinas@arm.com>, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Arnd Bergmann <arnd@arndb.de>, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, libc-alpha@sourceware.org, Nathan_Lynch@mentor.com, LKML <linux-kernel@vger.kernel.org>, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

W1Jlc2VuZCwgYXMgbXkgbWFpbC1jbGllbnQgaGFkIGluc2lzdGVkIG9uIHVzaW5nIHRoZSB3cm9u
ZyBNSU1FIHR5cGXigKZdCgo+IE9uIDA3IERlYyAyMDE2LCBhdCAxMTozNCwgWXVyeSBOb3JvdiA8
eW5vcm92QGNhdml1bW5ldHdvcmtzLmNvbT4gd3JvdGU6Cj4gCj4+IElmIHRoZXJlIGlzIGEgdXNl
IGNhc2UgZm9yIGxhcmdlciB0aGFuIDE2VEIgb2Zmc2V0cywgd2Ugc2hvdWxkIGFkZAo+PiB0aGUg
Y2FsbCBvbiBhbGwgYXJjaGl0ZWN0dXJlcywgcHJvYmFibHkgdXNpbmcgeW91ciBhcHByb2FjaCAz
LiBJIGRvbid0Cj4+IHRoaW5rIHRoYXQgd2Ugc2hvdWxkIHRyZWF0IGl0IGFzIGFueXRoaW5nIHNw
ZWNpYWwgZm9yIGFybTY0IHRob3VnaC4KPiAKPiBGcm9tIHRoaXMgcG9pbnQgb2YgdmlldywgMTYr
VEIgb2Zmc2V0IGlzIGEgbWF0dGVyIG9mIDE2K1RCIHN0b3JhZ2UsCj4gYW5kIGl0J3MgbW9yZSB0
aGFuIHJlYWwuIFRoZSBvdGhlciBjb25zaWRlcmF0aW9uIHRvIGFkZCBpdCBpcyB0aGF0Cj4gd2Ug
aGF2ZSA2NC1iaXQgc3VwcG9ydCBmb3Igb2Zmc2V0cyBpbiBzeXNjYWxscyBsaWtlIHN5c19sbHNl
ZWsoKS4KPiBTbyBtbWFwNjQoKSB3aWxsIHNpbXBseSBleHRlbmQgdGhpcyBzdXBwb3J0LgoKSSBi
ZWxpZXZlIHRoZSBxdWVzdGlvbiBpcyByYXRoZXIgaWYgdGhlIDE2VEIgb2Zmc2V0IGlzIGEgcmVh
bCB1c2UtY2FzZSBmb3IgSUxQMzIuICBUaGlzCnNlZW1zIHRvIGJyaW5nIHRoZSBkaXNjdXNzaW9u
IGZ1bGwtY2lyY2xlLCBhcyB0aGlzIHdvdWxkIGluZGljYXRlIHRoYXQgNjRiaXQgaXMgdGhlIApw
cmVmZXJyZWQgYml0LXdpZHRoIGZvciBhbGwgc2l6ZXMsIG9mZnNldHMsIGV0Yy4gdGhyb3VnaG91
dCBhbGwgZmlsZXN5c3RlbS1yZWxhdGVkIGNhbGxzIAooaS5lLiBzdGF0LCBzZWVrLCBldGMuKS4K
CkJ1dCBpZiB0aGF0IGlzIHRoZSBjYXNlLCB0aGVuIHdlIHNob3VsZCBoYXZlIGdvbmUgd2l0aCA2
NGJpdCBhcmd1bWVudHMgaW4gYSBzaW5nbGUKcmVnaXN0ZXIgZm9yIG91ciBJTFAzMiBkZWZpbml0
aW9uIG9uIEFBcmNoNjQuCgpJbiBvdGhlciB3b3JkczogV2h5IG5vdCBrZWVwIElMUDMyIHNpbXBs
ZSBhbiBhc2sgdXNlcnMgdGhhdCBuZWVkIGEgMTZUQisgb2Zmc2V0CnRvIHVzZSBMUDY0PyBJdCBz
ZWVtcyBtdWNoIG1vcmUgY29uc2lzdGVudCB3aXRoIHRoZSBvdGhlciBjaG9pY2VzIHRha2VzIHNv
IGZhci4KCuKAlFBoaWwuCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
