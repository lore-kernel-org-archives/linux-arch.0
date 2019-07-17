From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Wed, 17 Jul 2019 10:42:26 -0400
Message-ID: <779FC7D4-67CE-4D22-8154-FC108479935F@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
 <20190717074435.GU3419@hirez.programming.kicks-ass.net>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190717074435.GU3419@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Waiman Long <longman@redhat.com>, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Cj4+ICAqICAgIG1jc19ub2RlCj4+ICAqICAgKy0tLS0tLS0tKyAgICAgICstLS0tKyAgICAgICAg
ICstLS0tKwo+PiAgKiAgIHwgbmV4dCAgIHwgLS0tPiB8bmV4dHwgLT4gLi4uICB8bmV4dHwgLT4g
TlVMTCAgW01haW4gcXVldWVdCj4+ICAqICAgfCBsb2NrZWQgfCAtKyAgICstLS0tKyAgICAgICAg
ICstLS0tKwo+PiAgKiAgICstLS0tLS0tLSsgIHwKPj4gICogICAgICAgICAgICAgICB8ICAgKy0t
LS0tLS0tLSsgICAgICAgICArLS0tLSsKPj4gICogICAgICAgICAgICAgICArLT4gfG1jczo6bmV4
dHwgLT4gLi4uICB8bmV4dHwgLT4gTlVMTCAgICAgW1NlY29uZGFyeSBxdWV1ZV0KPj4gKiAgICAg
ICAgICAgICAgICAgICB8Y25hOjp0YWlsfCAtKyAgICAgICstLS0tKwo+PiAgKiAgICAgICAgICAg
ICAgICAgICArLS0tLS0tLS0tKyAgfCAgICAgICAgXgo+PiAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICArLS0tLS0tLS0rCj4+ICAqCj4+ICAqIE4uQi4gbG9ja2VkID0gMSBpZiBzZWNv
bmRhcnkgcXVldWUgaXMgYWJzZW50Lgo+PiAgKi8KCgpJIHdvdWxkIGNoYW5nZSBtY3Nfbm9kZSB0
byBjbmFfbm9kZSwgbmV4dCB0byBtY3M6Om5leHQgYW5kIGxvY2tlZCB0byBtY3M6OmxvY2tlZApp
biB0aGUgdmVyeSBmaXJzdCBub2RlLiBPdGhlciB0aGFuIHRoYXQsIHRoaXMgaXMgZ3JlYXQuIFRo
YW5rcywgUGV0ZXIgYW5kIExvbmdtYW4hCgpJIHNob3VsZCBwcm9iYWJseSBzdGljayB0aGlzIGdy
YXBoaWMgaW4gdGhlIGNvbW1lbnQgYXQgdGhlIHRvcCBvZiB0aGUgZmlsZSwgCmluc3RlYWQgb2Yg
YSBjb21tZW50IHRvIGZpbmRfc3VjY2Vzc29yKCkgKG9yIHdoYXRldmVyIHRoaXMgZnVuY3Rpb24g
ZW5kcyB1cCAKYmVpbmcgY2FsbGVkKS4KCuKAlCBBbGV4CgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
