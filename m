From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Wed, 3 Apr 2019 23:14:49 -0400
Message-ID: <C74425B5-3006-4721-8BEF-55E86830C13D@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, peterz@infradead.org, dave.dice@oracle.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

SGksIEhhbmp1bi4gCgo+IE9uIEFwciAzLCAyMDE5LCBhdCAxMDowMiBQTSwgSGFuanVuIEd1byA8
Z3VvaGFuanVuQGh1YXdlaS5jb20+IHdyb3RlOgo+IAo+IEhpIEFsZXgsCj4gCj4gT24gMjAxOS8z
LzI5IDIzOjIwLCBBbGV4IEtvZ2FuIHdyb3RlOgo+PiArCj4+ICtzdGF0aWMgX19hbHdheXNfaW5s
aW5lIHZvaWQgY25hX2luaXRfbm9kZShzdHJ1Y3QgbWNzX3NwaW5sb2NrICpub2RlLCBpbnQgY3B1
aWQsCj4+ICsJCQkJCSAgdTMyIHRhaWwpCj4+ICt7Cj4+ICsJaWYgKGRlY29kZV9udW1hX25vZGUo
bm9kZS0+bm9kZV9hbmRfY291bnQpID09IC0xKQo+PiArCQlzdG9yZV9udW1hX25vZGUobm9kZSwg
bnVtYV9jcHVfbm9kZShjcHVpZCkpOwo+IAo+IEhvdyBhYm91dCB1c2luZyBjcHVfdG9fbm9kZSgp
IGhlcmUgYW5kICNpbmNsdWRlIDxsaW51eC90b3BvbG9neS5oPiBpbiB0aGlzCj4gZmlsZSwgdGhl
biB0aGUgY29kZSBjYW4gYmUgcmV1c2VkIGZvciBvdGhlciBhcmNoaXRlY3R1cmVzIHN1Y2ggYXMg
QVJNNjQ/Ckdvb2QgcG9pbnQuIFRoYW5rcyEKCuKAlCBBbGV4Cgo+IAo+IFRoYW5rcwo+IEhhbmp1
bgo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
